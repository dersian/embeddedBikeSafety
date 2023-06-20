function DaS()
    % ----------------------------------------Sample Source-------------------------------------------------
    % Sample Source: Audio file
    %[samples, fs] = audioread('rec_1_trim.wav'); 
    %n = (0:length(samples)-1);
    %info = audioinfo('rec_1_trim.wav');
    %fprintf('Sample Rate = %d\r\n', info.SampleRate);
    %fprintf('Bits Per Sample = %d\r\n', info.BitsPerSample);
    %fprintf('Total Amount of Samples = %d\r\n', info.TotalSamples);
    % Audio Sample
    %plot(n, samples);
    %title('Sound Source');
    %xlabel('Samples(n)');
    %ylabel('Amplitude');
    
    % Sample Source: Sine
    fs = 48000; % 48kHz
    ts = 1/fs;
    n = (0:ts:1-ts);   
    F = 10000; % 10kHz
    samples = sin(2*pi*F*n);
    %plot(n, samples);
    %title('Sound Source');
    %xlabel('Seconds (t)');
    %ylabel('Amplitude');
    
    % ----------------------------------------Delay Table-------------------------------------------------
    delayTable = readtable('delayTables/delayTable_48kHz_9mics_r60.csv');

    % ----------------------------------------Mic Geometry-------------------------------------------------
    micAmount = length(delayTable{1,:});
    maxDelayCol = max(delayTable{:,:});
    maxDelay = max(maxDelayCol);
    bufferLength = 2*maxDelay+1; % buffer length is calculated from the max delay
    angleResolution = 1; 
    delayTableLength = (360/angleResolution)+1; %delayTableLength+1 -> includes angle 0 and 360
    
    fprintf('max delay in samples (from center of buffer) = %d\r\n', maxDelay);
    fprintf('total bufferlength in samples = %d\r\n', bufferLength);
 
    % ----------------------------------------Simulate Signals-------------------------------------------------
    % Choose custom delay
    sourceAngle = 60;
    customDelay = round(interp1([0,180],[1,maxDelay],sourceAngle));
    fprintf('custom delay in samples = %d\r\n', customDelay);

    % Create/Simulate Mic Signals
    n_ext = [n, zeros(1, maxDelay)];
    signals = zeros(micAmount, length(n_ext));
    for mic = 1:micAmount
        sampleDelay = delayTable{sourceAngle, mic};
        signals(mic, sampleDelay:sampleDelay + length(samples)-1) = samples;
    end

    % Write mic signals to file for VHDL code
    % First map all fractions to integer values -> take 16 bits: -65536 - +65535
    mapped_signals = zeros(micAmount, length(n_ext));
    [val, idx] = max(signals);
    max_sample = max(val);
    for mic = 1:micAmount
        for sample = 1:length(n_ext)
            mapped_signals(mic, sample) = round((signals(mic, sample)/max_sample)*65535);
        end
    end 
    writematrix(mapped_signals,'Sources\mic_signals.csv','Delimiter',';')

    % Create Delay Buffers (1 per mic)
    delayBuffers = zeros(micAmount, bufferLength);
    
    % ----------------------------------------DaS-------------------------------------------------
    % Delay and Sum Algorithm
    % Calculate output length
    output_length = ceil(length(n)/bufferLength);
    output = zeros(delayTableLength, output_length+1);
    for angle = 1:delayTableLength-1
        n_i = 1;
        o_i = 1;
        while n_i <= length(n_ext)
            for mic = 1:micAmount
                % fill the delaybuffer with n(=bufferLength) samples from the signals
                if (n_i + bufferLength - 1 > length(n_ext)) % check if we are at the end
                    res = length(n_ext) - n_i;
                    delayBuffers(mic, 1:res+1) = mapped_signals(mic, n_i: n_i+res);
                    % fill the rest with zeros
                    delayBuffers(mic, res+1:bufferLength) = zeros(1, bufferLength - res);
                    delayindex = delayTable{angle, mic};
                    output(angle, o_i) = output(angle, o_i) + delayBuffers(mic, delayindex);
                else
                    delayBuffers(mic, :) = mapped_signals(mic, n_i: n_i + bufferLength-1);
                    delayindex = delayTable{angle, mic};
                    output(angle, o_i) = output(angle, o_i) + delayBuffers(mic, delayindex); 
                end
            end
            n_i = n_i + bufferLength;
            o_i = o_i + 1;
        end
    end
    writematrix(output,'Results\DaS_output.csv','Delimiter',';')
 
    % Calculate RMS for corresponding angles
    rmsAngle_output = zeros(delayTableLength, 2);
    for j = 1:delayTableLength
        rmsAngle_output(j, 1) = (j-1)*angleResolution;
        rmsAngle_output(j, 2) = rms(output(j, :));
    end
    % Calculate normalized RMS
    maxRMS = max(rmsAngle_output(:, 2));
    norm_rmsAngle_output = zeros(delayTableLength, 2);
    for k = 1:delayTableLength
        norm_rmsAngle_output(k, 1) = rmsAngle_output(k, 1);
        norm_rmsAngle_output(k, 2) = rmsAngle_output(k, 2) / maxRMS;
    end     

    % Polar plot
    figure;
    polarplot(deg2rad(norm_rmsAngle_output(:, 1)), norm_rmsAngle_output(:, 2));

    % Return max @ angle
    [val, idx] = max(norm_rmsAngle_output);
    max_idx = find(val==1);
    maxAngle = idx(max_idx);
    fprintf('source angle calculated by DaS = %d\r\n', maxAngle);
    
    %}
end

