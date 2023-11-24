close all
clear
clc

fs = 8000;
note = [48, 90];
d = [1,1];
start = [0, 0];


[y] = createMusic(d, note, fs, start);
[ffty, fy] = my_FFT(y, fs);

%Define the lowpass cutoff
lCutoff = 140;
HLP = zeros(length(fy), 1);
HLP(-lCutoff <= fy & fy <= lCutoff) = 1;

%plot the fft plot.
figure
plot(fy, abs(ffty))
xlabel("Freqeuncy (Hz)")
ylabel("|FFT(x)|")
xlim([-1600, 1600])
title("FFT plot of 2 Notes")
set(gca,'ClippingStyle','rectangle');
set(gca,'FontSize',15)
set(gca,'FontName','Calibri')

lpFiltered = ffty.*HLP;

audiowrite("note48Lowpass.wav", rescale(my_FFTinv(lpFiltered), -1, 0.99999) , fs);

figure
plot(fy, abs(lpFiltered))
xlabel("Freqeuncy (Hz)")
ylabel("|FFT(x)|")
xlim([-1600, 1600])
title("FFT plot after Low Pass Filter")
set(gca,'ClippingStyle','rectangle');
set(gca,'FontSize',15)
set(gca,'FontName','Calibri')

HCutoff = 1000;
HHP = ones(length(fy), 1);
HHP(-HCutoff <= fy & fy <= HCutoff) = 0;

hpFiltered = ffty.*HHP;

audiowrite("note90Highpass.wav", rescale(my_FFTinv(hpFiltered), -1, 0.99999), fs);
figure
plot(fy, abs(hpFiltered))
xlabel("Freqeuncy (Hz)")
ylabel("|FFT(x)|")
xlim([-1600, 1600])
title("FFT plot after High Pass Filter")
set(gca,'ClippingStyle','rectangle');
set(gca,'FontSize',15)
set(gca,'FontName','Calibri')


%% Ex 1.2.2
close all
clear
clc

fs = 8000;
note1 = 50:71;
d1 = ones(1,length(note1));
start1 = zeros(1, length(note1));

note2 = 72:90;
d2 = ones(1,length(note2));
start2 = zeros(1, length(note2));

x1 = createMusic(d1, note1, fs, start1);
audiowrite('50-71Notes.wav', x1, fs);
[fftx1, fx1] = my_FFT(x1, fs);

figure
plot(fx1, abs(fftx1))
xlabel("Freqeuncy (Hz)")
ylabel("|FFT(x)|")
title("FFT plot of x1")
xlim([0, 600])
set(gca,'ClippingStyle','rectangle');
set(gca,'FontSize',15)
set(gca,'FontName','Calibri')

x2 = createMusic(d2, note2, fs, start2);
audiowrite('72-90Notes.wav', rescale(x2,-1, 0.99999), fs);
[fftx2, fx2] = my_FFT(x2, fs);

figure
plot(fx2, abs(fftx2))
xlabel("Freqeuncy (Hz)")
ylabel("|FFT(x)|")
title("FFT plot of x2")
xlim([0, 2000])
set(gca,'ClippingStyle','rectangle');
set(gca,'FontSize',15)
set(gca,'FontName','Calibri')

x = x1+x2;
audiowrite('combinedNotes50.wav', x, fs);
[fftx, fx] = my_FFT(x, fs);

figure
plot(fx, abs(fftx))
xlabel("Freqeuncy (Hz)")
ylabel("|FFT(x)|")
title("FFT plot of x")
xlim([0, 2000])
% set(gca,'ClippingStyle','rectangle');
set(gca,'FontSize',15)
set(gca,'FontName','Calibri')

%Define the lowpass cutoff
lCutoff = 500;
HLP = zeros(length(fx), 1);
HLP(-lCutoff <= fx & fx <= lCutoff) = 1;

HCutoff = 500;
HHP = ones(length(fx), 1);
HHP(-HCutoff <= fx & fx <= HCutoff) = 0;

y1 = fftx.*HLP;
y2 = fftx.*HHP;

xReconstructed = my_FFTinv(y1+y2);
audiowrite('ReconstructuredCombinedNotes.wav', xReconstructed, fs);

euclidDistX1 = sqrt(sum((x1-my_FFTinv(y1)).^2))
euclidDistX2 = sqrt(sum((x2-my_FFTinv(y2)).^2))

figure
subplot(2,2,1)
plot(fx, abs(fftx1))
xlabel("Freqeuncy (Hz)")
ylabel("|FFT(x)|")
title("FFT plot of x1")
xlim([0, 600])
set(gca,'ClippingStyle','rectangle');
set(gca,'FontSize',15)
set(gca,'FontName','Calibri')

subplot(2,2,2)
plot(fx, abs(fftx2))
xlabel("Freqeuncy (Hz)")
ylabel("|FFT(x)|")
title("FFT plot of x2")
xlim([0, 2000])
set(gca,'ClippingStyle','rectangle');
set(gca,'FontSize',15)
set(gca,'FontName','Calibri')

subplot(2,2,3)
plot(fx, abs(y1))
xlabel("Freqeuncy (Hz)")
ylabel("|FFT(x)|")
title("FFT plot of y1")
xlim([0, 600])
set(gca,'ClippingStyle','rectangle');
set(gca,'FontSize',15)
set(gca,'FontName','Calibri')

subplot(2,2,4)
plot(fx, abs(y2))
xlabel("Freqeuncy (Hz)")
ylabel("|FFT(x)|")
title("FFT plot of y2")
xlim([0, 2000])
set(gca,'ClippingStyle','rectangle');
set(gca,'FontSize',15)
set(gca,'FontName','Calibri')

for i=300:700
    %Define the lowpass cutoff
    lCutoff = i;
    HLP = zeros(length(fx), 1);
    HLP(-lCutoff <= fx & fx <= lCutoff) = 1;
    
    HCutoff = i;
    HHP = ones(length(fx), 1);
    HHP(-HCutoff <= fx & fx <= HCutoff) = 0;
    
    y1 = fftx.*HLP;
    y2 = fftx.*HHP;

    errX1(i-299) = sqrt(sum((x1-my_FFTinv(y1)).^2));
    errX2(i-299) = sqrt(sum((x2-my_FFTinv(y2)).^2));
end

figure
hold on
plot(300:700,errX1)
plot(300:700,errX2)
hold off
xlabel("Cutoff Freqeuncy (Hz)")
ylabel("Euclidian Error")
legend('errX1', 'errX2')
title("Euclidian Distance between original and filtered signals")
set(gca,'ClippingStyle','rectangle');
set(gca,'FontSize',15)
set(gca,'FontName','Calibri')

%% Ex1.2.2.7
close all
clear
clc
[y, fs] = audioread('melody2.wav');
[ffty, fy] = my_FFT(y, fs);
plot(fy, abs(ffty))
xlabel("Freqeuncy (Hz)")
ylabel("|FFT(x)|")
xlim([0, 1500])
title("FFT plot of melody2.wav")
set(gca,'ClippingStyle','rectangle');
set(gca,'FontSize',15)
set(gca,'FontName','Calibri')

%propose a bandpass from 630-1000hZ
%Define the lowpass cutoff
lCutoff = 786;
HLP = zeros(length(fy), 1);
HLP(-lCutoff <= fy & fy <= lCutoff) = 1;

HCutoff = 349;
HHP = ones(length(fy), 1);
HHP(-HCutoff <= fy & fy <= HCutoff) = 0;

HBP = HLP & HHP;

melody = ffty.*HBP;

audiowrite('filteredMelody2.wav',my_FFTinv(melody), fs);

figure
plot(fy, abs(melody))
xlabel("Freqeuncy (Hz)")
ylabel("|FFT(x)|")
xlim([348, 787])
title("FFT plot of filteredMelody2.wav")
set(gca,'ClippingStyle','rectangle');
set(gca,'FontSize',15)
set(gca,'FontName','Calibri')

%% Ex 1.3.1

plot_spectrogram_various()



