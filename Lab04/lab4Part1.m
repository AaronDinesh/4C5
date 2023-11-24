%% Ex 1.1.1
close all
clear

fs = 8000;
note = 110;
d = 2;
start = 0;


[y, nOut] = createNote(d, note, fs, start);
[ffty, fy] = my_FFT(y, fs);

plot(fy, abs(ffty))
xlabel("Freqeuncy (Hz)")
ylabel("|FFT(x)|")
xlim([0, max(fy)])
title("FFT plot of note 110")
set(gca,'ClippingStyle','rectangle');
set(gca,'FontSize',15)
set(gca,'FontName','Calibri')

%% Ex 1.1.2
close all
clear

fs = 8000;
note = 48:51;
d = [1,1,1,1];
start = 1:1:4;

[y] = createMusic(d, note, fs, start);
[ffty, fy] = my_FFT(y, fs);

plot(fy, abs(ffty))
xlabel("Freqeuncy (Hz)")
ylabel("|FFT(x)|")
xlim([0, 300])
title("FFT plot of 4 Notes")
set(gca,'ClippingStyle','rectangle');
set(gca,'FontSize',15)
set(gca,'FontName','Calibri')

