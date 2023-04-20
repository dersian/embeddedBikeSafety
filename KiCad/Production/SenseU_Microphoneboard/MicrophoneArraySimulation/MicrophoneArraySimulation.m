
% Apply a filter to simulate the frequency response of the microphones
% Load the .wav file
filename = 'Spectrograms 01.wav';
[x, fs] = audioread(filename);


% Define the microphone spacing
mic_spacing = 0.066; % meters

% Define the microphone positions
n_mics = 6;
mic_pos = (0:n_mics-1) * mic_spacing;

% Apply a filter to simulate the frequency response of the microphones
f_min = 20; % Hz
f_max = 10000; % Hz

f_min = f_min/(fs/2);
f_max = f_max/(fs/2) - 0.01;

b = fir1(100, [f_min f_max] / (fs/2), 'bandpass');
mic_signals = zeros(n_mics, length(x));

for i = 1:n_mics
    % Apply a delay to simulate the different arrival times at each microphone
    delay = mic_pos(i) / 343; % seconds
    delay_samples = round(delay * fs);
    delayed_x = [zeros(delay_samples,1); x(1:end-delay_samples)];
    delayed_x = delayed_x(1,:)/2;
    
    % Apply the filter to simulate the frequency response of the microphone
    mic_signals(i,:) = filter(b, 1, delayed_x);
end

% Plot the signals from each microphone
t = (0:length(x)-1) / fs;
figure;
for i = 1:n_mics
    subplot(n_mics,1,i);
    plot(t, mic_signals(i,:));
    ylabel(sprintf('Mic %d', i));
    xlim([0 max(t)]);
end
xlabel('Time (s)');
