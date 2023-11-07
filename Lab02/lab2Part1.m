%% EX 1.2.1 - 1.2.2
close all
clear

f0 = 800;
fs = 2000;
d = 2;

t = 0:1/fs:d - 1/fs;
L = length(t);

x = sin(2*pi*f0*t);

plot(fs/L*(0:L-1),abs(fft(x)))

audiowrite(sprintf("%dHz_%dHz.flac", f0, fs), x, fs);

%% EX 1.2.3
close all
clear

f1 = 800;

f2 = 7200;

fs = 8000;

d = 2;
L = fs*d;

t = (0:L- 1)*1/fs;

y1 = sin(2*pi*f1*t);
y2 = sin(2*pi*f2*t);

subplot(2,1,1)
plot(fs/L*(0:L-1),abs(fft(y1)))
title("FFT plot of Sine Wave (800Hz Fundamental, 8000Hz Sampling)")
ylabel("|fft(x)|")
xlabel("Frequency (Hz)")
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')

subplot(2,1,2)
plot(fs/L*(0:L-1),abs(fft(y2)))
title("FFT plot of Sine Wave (7200Hz Fundamental, 8000Hz Sampling)")
ylabel("|fft(x)|")
xlabel("Frequency (Hz)")
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')


%% EX 1.2.4
close all
clear

load handel.mat

d = length(y)/Fs;

%original Fs = 8192

filename = "handel.wav";

plot(Fs/length(y)*(0:length(y)-1),abs(fft(y)))
hold on
% plot(0:1/Fs:length(y)/Fs - 1/Fs,y);

%%When you undersample you introduce more low frequency componenets leading
%%to aliasing.
audiowrite(filename, y, 4096)
[y1, Fs1] = audioread(filename);

plot(Fs1/length(y1)*(0:length(y1)-1),abs(fft(y1)))

title("FFT plot handel.mat")
legend("Original Audio", "Undersampled Audio")
ylabel("|fft(x)|")
xlabel("Frequency (Hz)")
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
xlim([0, 8200])
set(gca,'ClippingStyle','rectangle');

hold off


subplot(2,1,1)
stem((0:length(y)-1)*1/Fs, y,"filled")
title("Original handel.mat")
ylabel("Amplitude")
xlabel("Time")
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
xlim([0, 0.01])
set(gca,'ClippingStyle','rectangle');

subplot(2,1,2)
stem((0:length(y1)-1)*1/Fs1, y1,"filled")
title("Undersampled handel.mat")
ylabel("Amplitude")
xlabel("Time")
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
xlim([0, 0.01])
set(gca,'ClippingStyle','rectangle');

%%sound(y, Fs)


