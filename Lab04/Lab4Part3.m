%% Ex 1.3.1.1
close all
clear
clc

[y, fs] = audioread("violin-C5.wav");
window_length = length(y);
overlap = round(window_length / 2); % Set the overlap to be half the window length
[S, F, T] = spectrogram(y, window_length, overlap, window_length, fs);

% Plot the spectrogram in grayscale with white background
imagesc(T, F, 10*log10(abs(S)), [min(min(10*log10(abs(S)))) max(max(10*log10(abs(S))))]);

set(gca, 'YDir', 'normal'); % This is to ensure that the frequency axis is displayed correctly
% Set the figure background color to white
set(gcf, 'color', 'w');

% Add labels and title
xlabel('Time (seconds)');
ylabel('Frequency (Hz)');
title('Spectrogram of Violin (Full Length Window)');

% Add a colorbar to show intensity
colorbar;

%% Ex 1.3.4.1

close all
clear
clc

T = readtable ('ptbdb_normal.csv ') ;
Tarray = table2array ( T ) ;
normalPatient = Tarray (1 ,1: end) ;

T = readtable ('ptbdb_abnormal.csv ') ;
Tarray = table2array ( T ) ;
abnormalPatient = Tarray (1 ,1: end) ;

hold on
plot(normalPatient)
plot(abnormalPatient)
legend("normal", "abnormal")
xlabel("Sample Number")
ylabel("Amplitude")
title("Plot of normal and abnormal ECG")
hold off

figure
subplot(2,1,1)

fs = 250;
% Set parameters for the spectrogram
desired_window_duration = 0.1; % 40 ms
window_length = 2^nextpow2(round(desired_window_duration * fs)); % Round up to the nearest power of two
overlap = round(window_length / 2); % Set the overlap to be half the window length
nfft = window_length; % Number of FFT points, equal to window length for no zero-padding

% Create the spectrogram
[S, F, T] = spectrogram(normalPatient, window_length, overlap, nfft, fs);
imagesc(T, F, 10*log10(abs(S)), [min(min(10*log10(abs(S)))) max(max(10*log10(abs(S))))]);

set(gca, 'YDir', 'normal'); % This is to ensure that the frequency axis is displayed correctly
% Set the figure background color to white
set(gcf, 'color', 'w');

% Add labels and title
xlabel('Time (seconds)');
ylabel('Frequency (Hz)');
title('Spectrogram of Normal ECG');

% Add a colorbar to show intensity
colorbar;



subplot(2,1,2)
% Create the spectrogram
[S, F, T] = spectrogram(abnormalPatient, window_length, overlap, nfft, fs);
imagesc(T, F, 10*log10(abs(S)), [min(min(10*log10(abs(S)))) max(max(10*log10(abs(S))))]);


set(gca, 'YDir', 'normal'); % This is to ensure that the frequency axis is displayed correctly
% Set the figure background color to white
set(gcf, 'color', 'w');

% Add labels and title
xlabel('Time (seconds)');
ylabel('Frequency (Hz)');
title('Spectrogram of Abnormal ECG');

% Add a colorbar to show intensity
colorbar;