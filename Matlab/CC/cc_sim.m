function correlation_test()
    [samples, fs] = audioread('rec_1_trim.wav');
    t = (0:length(samples)-1)/fs;
    fprintf('len t = %d\r\n', length(t));

    plot(t, samples);
    title('Rec Data');
    xlabel('Time(s)');
    ylabel('Amplitude');
    
    % Create Extended Time Array
    int = 3.125000e-05; % difference between 2 time points
    t_ext = [t, t(end)+int: int : (t(end)*2)+int];
    fprintf('len t_ext = %d\r\n', length(t_ext));
    
    % Original Signal Time Extended (w zeros)
    signal = transpose(samples(:,1));
    signal = [signal, zeros(1, length(t_ext) - length(signal))];
    fprintf('len signal = %d\r\n', length(signal));
    figure;
    plot(t_ext, signal);
    
    hold on
    
    % Delayed Signal
    signal2 = zeros(1, length(signal));
    signal2(100000:100000+length(t)-1) = transpose(samples(:,1)); %fill delay
    plot(t_ext, signal2);
    fprintf('len signal2 = %d\r\n', length(signal2));
    title('Signal 1 and Delayed Signal 2');
    xlabel('Time(s)');
    ylabel('Amplitude');
    
    % Correlation Function
    [corr, t_xcorr] = xcorr(signal, signal2);
    t_corr = (0:length(corr)-1)/fs;
    figure;
    plot(t_corr, corr); % of t_xcorr
    title('Correlation Function');

    % Find Delay
    delay = finddelay(signal, signal2);
    timeDelay = delay/fs;
    fprintf('maxCorrTimeStamp = %d\r\n', timeDelay);
end