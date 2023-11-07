%%Ex 1.3.3
% Create a note
close all
clear
note = 60;
fs = 8000;
d = [0.1, 0.2, 0.3, 0.4];

i = [60, 62, 64, -1];


subplot(4,1,1);
[y, ~] = createNote(i(1), d(1), fs, 0);
stem(fs/length(y)*(0:length(y)-1),abs(fft(y)), "filled")
title("FFT plot of note 60 (261.63 Hz)")
ylabel("|fft(x)|")
xlabel("Frequency (Hz)")
xlim([0, 500])
set(gca,'ClippingStyle','rectangle');
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')

subplot(4,1,2);
[y, ~] = createNote(i(2), d(2), fs, 0);
stem(fs/length(y)*(0:length(y)-1),abs(fft(y)), "filled")
title("FFT plot of note 62 (293.66 Hz)")
ylabel("|fft(x)|")
xlabel("Frequency (Hz)")
xlim([0, 500])
set(gca,'ClippingStyle','rectangle');
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')

subplot(4,1,3);
[y, ~] = createNote(i(3), d(3), fs, 0);
stem(fs/length(y)*(0:length(y)-1),abs(fft(y)), "filled")
title("FFT plot of note 64 (329.63 Hz)")
ylabel("|fft(x)|")
xlabel("Frequency (Hz)")
xlim([0, 500])
set(gca,'ClippingStyle','rectangle');
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')

subplot(4,1,4);
[y, ~] = createNote(i(4), d(4), fs, 0);
stem(fs/length(y)*(0:length(y)-1),abs(fft(y)), "filled")
title("FFT plot of note -1")
ylabel("|fft(x)|")
xlabel("Frequency (Hz)")
xlim([0, 500])
set(gca,'ClippingStyle','rectangle');
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')





%% Ex 1.4.2
%Create a melody
close all
clear

note = 24;
fs = 8000;
d = 1;
i = [60, 62, 64, 65, 67, 69, 71, 72];
[y, nOut] = createMelody(i, d, fs, 0);

audiowrite("Melody.flac", y, fs);



%% Ex 1.4.3
%Plot the melody vs time
close all
clear

[y, fs] = audioread("Melody.flac");
y = y';
t = (0:length(y) - 1)*1/fs;

subplot(2,1,1)
stem(t, y);
xlim([1 1.01]);
title("Plot of Melody.flac");
ylabel("Amplitude");
xlabel("Time");
set(gca,'FontSize',15);
set(gca,'FontName','Times New Roman');
set(gca,'ClippingStyle','rectangle');

subplot(2,1,2)
plot(fs/length(y)*(0:length(y)-1),abs(fft(y)));
xlim([200, 550]);
title("FFT plot of Melody.flac");
ylabel("|fft(x)|");
xlabel("Frequency (Hz)");
set(gca,'FontSize',15);
set(gca,'FontName','Times New Roman');
set(gca,'ClippingStyle','rectangle');

%% Ex 1.4.4
%Make the melody go 50% faster
close all
clear

[y, fs] = audioread("Melody.flac");
audiowrite("Melody_2x_Faster.flac",y, fs*2);

%% Ex 1.5
close all
clear
%Upsample a signal

note = 69;
fs = 8500;
f0 = round(440 * power(2, ((note - 69) / 12)),2);
duration = 1;
upsampleFactor = 4;
t = 0:1/fs:duration - 1/fs;

[x , ~] = createNote(note, duration, fs, 0);
% x = lowpass(x, f0, fs);
audiowrite(sprintf("Original Sound %d at rate %d Hz.flac", f0, fs),x, fs);

[y, nOut] = upsample(x,upsampleFactor,fs);
new_fs = fs*upsampleFactor;
% y = lowpass(y, f0, new_fs);
audiowrite(sprintf("Upsampled Sound %d at rate %d Hz.flac", f0, fs*upsampleFactor),y, fs*upsampleFactor);

subplot(2,1,1)
stem(t,x);
xlim([0 0+20/f0])
title(sprintf("Original Sound %d at rate %d Hz", f0, fs))
ylabel("Amplitude")
xlabel("Time (seconds)")
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
set(gca,'ClippingStyle','rectangle');

subplot(2,1,2)
stem(nOut, y);
xlim([0 0+20/f0])
title(sprintf("Upsampled Sound %d at rate %d Hz", f0, new_fs))
ylabel("Amplitude")
xlabel("Time (seconds)")
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
set(gca,'ClippingStyle','rectangle');

figure
subplot(2,1,1)
plot(fs/length(x)*(0:length(x)-1),abs(fft(x)))
title("FFT plot of Original Signal")
ylabel("|fft(x)|")
xlabel("Frequency (Hz)")
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')

subplot(2,1,2)
plot((fs*upsampleFactor)/length(y)*(0:length(y)-1),abs(fft(y)))
title("FFT plot of Upsampled Signal")
ylabel("|fft(x)|")
xlabel("Frequency (Hz)")
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')

%% Ex 1.5.2
close all
clear

load handel.mat
% sound(y, Fs)
[y2, nOut2] = upsample(y, 10, Fs);
% pause(11)
% sound(y2, Fs*4)

subplot(2,1,1)
stem((0:length(y)-1)*1/Fs , y);
title("Handel.mat Original")
ylabel("Amplitude")
xlabel("Time (seconds)")
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
set(gca,'ClippingStyle','rectangle');

subplot(2,1,2)
stem(nOut2, y2);
title("Upsampled Handel.mat")
ylabel("Amplitude")
xlabel("Time (seconds)")
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
set(gca,'ClippingStyle','rectangle');



%% Helper function
function [y, nOut] = upsample(x, n, fs)
    y = zeros(1, length(x)*n);
    nOut = (0:length(y)-1)*(1/(n*fs));
    for i = 1:1:length(x)
        y((i-1)*n+1) = x(i);
    end
    [h, ~] = linearInterp(n);
    y = conv(y,h, "same");

end


function [h, nOut] = linearInterp(size)
    nOut = -size:1:size;
    h = [0:1/size:1,flip(0:1/size:1 - 1/size)];
end