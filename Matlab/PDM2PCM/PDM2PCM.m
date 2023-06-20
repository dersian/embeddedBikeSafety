    function PDM2PCM(fileName, mic)
    % Filter Specifications:
    % Sampling Frequencies
    fs_in = 2304000;
    fs_out = 48000;
    % CIC:
    CIC_order = 4;
    CIC_decRate = 12;
    CIC_delay = 12;
    % HBF:
    HBF1_coeffs = load('HBF1.mat');
    HBF2_coeffs = load('HBF2.mat');
    HBF_decRate = 2;
    % FIR:
    FIR_coeffs = load('FIR.mat');

    % Load in samples from specified file
    data = importdata(fileName);
    
    % OTHER:
    % Extract the corresponding mic data
    PDM_data = transpose(data(:, mic));
    
    %{
    % VHDL:
    ILA_fs = 100000000;
    % Delete unused cols
    data.data(:,[1,2,3]) = [];
    % Create output vector
    dec_fac = floor(ILA_fs / fs_in);
    PDM_data = zeros(1, round(length(data.data)/dec_fac));
    k = 1;

    for i = 2:length(data.data)
        if data.data(i, 2) == 1
            PDM_data(k) = data.data(i, 1);
            k = k + 1;
        end
    end
    %}

    PDM_data = PDM_data * 2 - 1; %rescale(PDM_data,-1,1);
    

    % Plot Spectrum PDM Data
    %plot_time(PDM_data, fs_in);
    plot_freq(PDM_data, fs_in);

    % Multi Stage Filters:
    % 1. CIC
    CIC_output = CIC(PDM_data, CIC_delay, CIC_decRate, CIC_order);
    plot_freq(CIC_output, fs_out);
    % 2. HBF + 2x Dec coeff aanpassen!!!
    HBF1_output = HBF(CIC_output, HBF1_coeffs);
    HBF1_output = HBF1_output(1:HBF_decRate:end);
    % 3. HBF + 2x Dec
    HBF2_output = HBF(HBF1_output, HBF2_coeffs);
    HBF2_output = HBF2_output(1:HBF_decRate:end);
    % 4. FIR
    FIR_output = FIR(HBF2_output, FIR_coeffs);
    PCM_data = FIR_output;

    % Plot Spectrum PCM Data
    plot_time(PCM_data, fs_out);
    plot_freq(PCM_data, fs_out);
    
end 

%%
function CIC_output = CIC(samples, delay, decRate, order)
    integrated = integrate(samples, delay, decRate, order);
    combd = comb(integrated, decRate, delay, order);
    CIC_output = combd(1:decRate:end);
    %%
    function integrated=integrate(input, decRate, delay, order)
        max_val = (decRate*delay)^order;
        intermed_vals = zeros(order, length(input));
        % Initialize the first values
        for k = 1:order
            intermed_vals(k, 1) = input(1);
        end
        % Go over rest of samples 1 by 1
        for i = 2:length(input)
            for j = 1:order
                % First integrator -> takes input
                if j == 1
                    intermed_vals(j, i) = input(i) + intermed_vals(j, i-1);
                % Rest of integrators -> takes input of prev integrator
                else
                    intermed_vals(j, i) = intermed_vals(j-1, i) + intermed_vals(j, i-1);
                end
                %%{
                % Over/underflow
                if (intermed_vals(j, i) > max_val-1) 
                    intermed_vals(j, i) = intermed_vals(j, i) - 2*max_val;        
                elseif (intermed_vals(j, i) < -max_val) 
                    intermed_vals(j, i) = intermed_vals(j, i) + 2*max_val; 
                end
                %}
            end
        end
        integrated = intermed_vals(order, :);
    end
    %%
    
    %%
    function combd=comb(input, decRate, delay, order)
        max_val = (decRate*delay)^order;
        intermed_vals = zeros(order, length(input));
        
        % Initialize the first (delay-1) values
        for i = 1:delay
            for j = 1:order
                % First integrator -> takes input
                if j == 1
                    intermed_vals(j, i) = input(i);
                % Rest of integrators -> takes input of prev integrator
                else
                    intermed_vals(j, i) = intermed_vals(j-1, i);
                end
            end
        end
    
        for i = delay+1:length(input)
            for j = 1:order
                % First integrator -> takes input
                if j == 1
                    intermed_vals(j, i) = input(i) - input(i-delay);
                % Rest of integrators -> takes input of prev integrator
                else
                    intermed_vals(j, i) = intermed_vals(j-1, i) - intermed_vals(j-1, i-delay);
                end
                %%{
                % Over/underflow
                if (intermed_vals(j, i) > max_val-1) 
                    intermed_vals(j, i) = intermed_vals(j, i) - 2*max_val;        
                elseif (intermed_vals(j, i) < -max_val) 
                    intermed_vals(j, i) = intermed_vals(j, i) + 2*max_val; 
                end
                %}
            end
        end   
        combd = intermed_vals(order, :);
    end
    %%
end
%%

%%
function HBF_output = HBF(samples, coeffs)
    HBF_output = zeros(1, length(samples));
    HBF_order = length(coeffs.coeff)-1;
    for k = 1:length(samples)
        if k < HBF_order+1
            for n = 0:k-1
                HBF_output(1, k) = HBF_output(1, k) + samples(1, k-n)*coeffs.coeff(n+1);
            end
        else
            for n = 0:HBF_order
                HBF_output(1, k) = HBF_output(1, k) + samples(1, k-n)*coeffs.coeff(n+1);
            end
        end
    end
end
%%

%%
function FIR_output = FIR(samples, coeffs)
    FIR_output = zeros(1, length(samples));
    FIR_order = length(coeffs.coeff.Numerator)-1;
    for k = 1:length(samples)
        if k < FIR_order+1
            for n = 0:k-1
                FIR_output(1, k) = FIR_output(1, k) + samples(1, k-n)*coeffs.coeff.Numerator(n+1);
            end
        else
            for n = 0:FIR_order
                FIR_output(1, k) = FIR_output(1, k) + samples(1, k-n)*coeffs.coeff.Numerator(n+1);
            end
        end
    end
end
%%

%%
function plot_freq(samples, fs)
    L = length(samples);
    
    FFT = fft(samples);
    P2 = abs(FFT/L); % complex -> reeel
    P1 = P2(1:floor(L/2+1)); % 1 kant van de symmetrische pakken
    P1(2:end-1) = 2*P1(2:end-1);
    fvec = fs*(0:(L/2))/L; 
    P1(1, 1) = 0;
    
    figure;
    plot(db(abs(FFT)));
    title('FFT');
    
    figure;
    plot(fvec, P1);
    title('Frequency Spectrum');
    xlabel('Freq (Hz)');
    ylabel('Amplitude');
    %{
    figure;
    plot(fvec, pow2db(P1));
    title('Spectral Density');
    xlabel('Freq (Hz)');
    ylabel('Power/Frequency (dB/Hz)');
    %}
end
%%

%%
function plot_time(samples, fs)
    L = length(samples);
    tvec = (0:L-1)*(1/fs);
    
    figure;
    plot(tvec, samples);
    title('Samples');
    xlabel('Time (s)');
    ylabel('Amplitude');
    %hold on
    %ref = sin(2*pi*236.8*tvec);
    %plot(tvec, ref);
    %legend('PCM Data', 'Reference Signal')
end
%%