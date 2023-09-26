close all
clear
% Exe 4.4-4.5

% d = duration of signal
% N = total number of samples
% fs = sampling frequency (Hz)
% N = d * fs

d = 2;
fs = 8000;
fo = 300;
N = d * fs;

t = 0:1/fs:2;

%Higher frequencies change the pitch
x = sin(2*pi*fo*t);
sound(x, fs);

% Exe 4.6

figure % new figure
stem (t , x ) % x as a function of t
title (sprintf('Sine Wave with Fundamental Period %d',1/fo)) % Figure title
xlabel ('Time')
ylabel ('Samples')
xlim ([0 4/fo]) % Restrict x values between 0 and 1
ylim ([ -1 1]) % Restrict y values between -1 and 1















