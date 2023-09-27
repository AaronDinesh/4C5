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

%% Exe 4.6
close all
clear

fo = 300;
fs = 8000;
t = 0:1/fs:4/fo;
x = sin(2*pi*fo*t);
figure % new figure
hold on
stem (t, x) % x as a function of t
title (sprintf('Sine Wave with Fundamental Period %d',1/fo)) % Figure title
xlabel ('Time')
ylabel ('Amplitude')
ylim ([ -1 1]) % Restrict y values between -1 and 1
hold off

%% Exe 4.7
close all
clear

fo = 300;
fs = 8000;
delay = 2;
t = 0:1/fs:4;
x = sin(2*pi*fo*t);

delayX = delayseq(x',delay*fs);
figure % new figure
hold on
stem (t, x) % x as a function of t
stem(t, delayX)
title (sprintf('Sine Wave with Fundamental Period %d',1/fo)) % Figure title
xlabel ('Time')
ylabel ('Amplitude')
ylim ([ -1 1]) % Restrict y values between -1 and 1
hold off


%% Exe 4.8
close all
clear
 
fs = 8000;

fo0 = 300;
t0 = 0:1/fs:4;
x0 = sin(2*pi*t0*fo0);
x0 = (delayseq(x0',2*fs))';

%y1
fo1 = 400; 
t1 = 0:1/fs:2;
y1 = sin(2*pi*fo1*t1);

%y2
fo2 = 400;
t2 = 0:1/fs:6;
y2 =  sin(2*pi*t2*fo2);
y2 = (delayseq(y2',2*fs))';

%y3
fo3 = 400;
t3 = 0:1/fs:3;
y3 = sin(2*pi*t3*fo3);
y3 = (delayseq(y3',1*fs))';

[tempY,tempNOut] = addSeq(x0, t0, y1, t1, 1/fs);
[tempY,tempNOut] = addSeq(tempY, tempNOut, y2, t2, 1/fs);
[finalY,finalNOut] = addSeq(tempY, tempNOut, y3, t3, 1/fs);














