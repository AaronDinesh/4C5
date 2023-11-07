%% Ex1.3.2 Corrupted Speech with 105 Note
close all 
clear
[y, fs] = audioread("OSR_20_105_Corrupted.wav");

fBins = 2^19;
fftY = fft(y, fBins);
freqStep = fs/fBins;
f = freqStep*(0:fBins/2 -1);
fResponse = 2*abs(fftY(1:fBins/2));
figure
plot(f, fResponse);
title("FFT Plot of Corrupted Signal");
xlabel("Frequency (Hz)")
ylabel("Amplitude")

output = filter(HighpassFilter8, y);
output = filter(Filter5, output);

fBins = 2^19;
fftY = fft(output, fBins);
freqStep = fs/fBins;
f = freqStep*(0:fBins/2 -1);
fResponse = 2*abs(fftY(1:fBins/2));
figure
plot(f, fResponse);
title("FFT Plot of Fixed Signal");
xlabel("Frequency (Hz)")
ylabel("Amplitude")

audiowrite("Fixed_ER_Dual_Filter.wav", output, fs)

immse(y,output)


