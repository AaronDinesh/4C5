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
plot(t0, x0);

%y1
fo1 = 400; 
t1 = 0:1/fs:2;
y1 = sin(2*pi*fo1*t1);

%y2
fo2 = 400;
t2 = 0:1/fs:4;
y2 =  sin(2*pi*t2*fo2);

%y3
fo3 = 400;
t3 = 0:1/fs:3;
y3 = sin(2*pi*t3*fo3);
y3 = (delayseq(y3',1*fs))';

[tempY,tempNOut] = addMulSeq(x0, t0, y1, t1, 1/fs, 0);
[tempY1,tempNOut1] = addMulSeq(tempY, tempNOut, y2, t2, 1/fs, 0);
[finalY, finalNOut] = addMulSeq(tempY1, tempNOut1, y3, t3, 1/fs, 0);
%% Exe 4.9
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
t2 = 0:1/fs:4;
y2 =  sin(2*pi*t2*fo2);

%y3
fo3 = 400;
t3 = 0:1/fs:3;
y3 = sin(2*pi*t3*fo3);
y3 = (delayseq(y3',1*fs))';

%Multiply the sequences elementwise
[tempY,tempNOut] = addMulSeq(x0, t0, y1, t1, 1/fs, 1);
[tempY1,tempNOut1] = addMulSeq(tempY, tempNOut, y2, t2, 1/fs, 1);
[finalY, finalNOut] = addMulSeq(tempY1, tempNOut1, y3, t3, 1/fs, 1);

%% Exe 4.10
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
t2 = 0:1/fs:4;
y2 =  sin(2*pi*t2*fo2);

%y3
fo3 = 400;
t3 = 0:1/fs:3;
y3 = sin(2*pi*t3*fo3);
y3 = (delayseq(y3',1*fs))';

%Convolve the sequences
[tempY,tempNOut] = convSeq(x0, t0, y1, t1, 1/fs);
figure
subplplot(3,1,1)
stem(t0,x0)
title("Sine Wave 300Hz 2sec Delay")
xlabel("Time (Seconds)")
ylabel("Amplitude")

subplot(3,1,2)
stem(t1, y1)
title("Sine Wave 400Hz 0sec Delay")
xlabel("Time (Seconds)")
ylabel("Amplitude")



[tempY1,tempNOut1] = convSeq(x0, t0, y2, t2, 1/fs);
[finalY, finalNOut] = convSeq(x0, t0, y3, t3, 1/fs);
%% Helper Functions

function [y, nOut] = addMulSeq(x1, t1, x2, t2, stepSize, addMul)
    figure
    hold on
    % plot(t1, x1)
    % plot(t2,x2)
    nOut = min(t1(1), t2(1)):stepSize:max(t1(length(t1)), t2(length(t2)));
    x1 = horzcat(x1, zeros(1,length(nOut) - length(x1)));
    x1 = circshift(x1, find(nOut == t1(1)) - 1);

    x2 = horzcat(x2, zeros(1,length(nOut) - length(x2)));
    x2 = circshift(x2, find(nOut == t2(1)) - 1);

    if(addMul == 0)
        y = x1+x2;
    elseif(addMul == 1)
        y = x1.*x2;
    else
        error("Incorrect value %d for addMul option\n", addMul);
    end
    
    plot(nOut,y);

    if(addMul == 0)
        title ('Addititon of Seqeunces'); % Figure title
        legend("x1[n]+x2[n]");
    else
        title ('Elementwise Multiplication of Sequences'); % Figure title
        legend("x1[n].*x2[n]");
    end

    xlabel ('Time (seconds)')
    ylabel ('Amplitude');
    
    hold off
end


function [y, nOut] = convSeq(x1, t1, x2, t2, stepSize)
    y = conv(x1, x2);
    nOut = min(t1(1), t2(1)):stepSize: length(y)*stepSize;
    nOut(end) = [];
end








