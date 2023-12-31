close all
clear
% Exe 4.4-4.5

% d = duration of signal
% N = total number of samples
% fs = sampling frequency (Hz)
% N = d * fs + 1

d = 2;
fs = 8000;
fo = 300;
N = d * fs + 1;

t = 0:1/fs:2;

%Higher frequencies change the pitch
x = sin(2*pi*fo*t);
sound(x, fs);

%% Exe 4.6
close all
clear

fo = 300;
t0 = 1/fo;
fs = 8000;
t = 0:1/fs:4/fo;
x = sin(2*pi*fo*t);
figure % new figure
hold on
stem (t, x, "Filled") % x as a function of t
title (sprintf('Sine Wave with Fundamental Period %d and Frequency %dHz',1/fo, fo)) % Figure title
xlabel ('Time')
ylabel ('Amplitude')
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
ylim ([ -1 1]) % Restrict y values between -1 and 1
xlim ([0, 4*t0])
hold off

%% Exe 4.7
close all
clear

fo = 300;
fs = 8000;
delay = 2;
t = 0:1/fs:4;
x = sin(2*pi*fo*t);

delayX = delayseq(x',delay*fs + 1);
figure % new figure
hold on
stem (t, x) % x as a function of t
stem(t, delayX)
title (sprintf('Original and delayed sine wave with frequency %dHz',fo)) % Figure title
xlabel ('Time (Seconds)')
ylabel ('Amplitude')
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
legend("Original Wave", "Delayed Wave")
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

figure
[x0Aligned, y1Aligned, nOut] = alignSeq(x0,t0, y1, t1, 1/fs);
subplot(2,1,1)
stem(nOut,x0Aligned);
xlabel ('Time (Seconds)')
ylabel ('Amplitude')
title("x0[n] 300Hz 2s delay")
ylim([-1, 1])
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')

subplot(2,1,2)
stem(nOut,y1Aligned);
xlabel ('Time (Seconds)')
ylabel ('Amplitude')
title("y1[n] 400Hz 0s delay")
ylim([-1, 1])
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')

%y2
fo2 = 400;
t2 = 0:1/fs:4;
y2 =  sin(2*pi*t2*fo2);

figure
[x0Aligned, y2Aligned, nOut] = alignSeq(x0,t0, y2, t2, 1/fs);
subplot(2,1,1)
stem(nOut,x0Aligned);
xlabel ('Time (Seconds)')
ylabel ('Amplitude')
title("x0[n] 300Hz 2s delay")
ylim([-1, 1])
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')

subplot(2,1,2)
stem(nOut,y2Aligned);
xlabel ('Time (Seconds)')
ylabel ('Amplitude')
title("y2[n] 400Hz 0s delay")
ylim([-1, 1])
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')

%y3
fo3 = 400;
t3 = 0:1/fs:3;
y3 = sin(2*pi*t3*fo3);
y3 = (delayseq(y3',1*fs))';

figure
[x0Aligned, y3Aligned, nOut] = alignSeq(x0,t0, y3, t3, 1/fs);
subplot(2,1,1)
stem(nOut,x0Aligned);
xlabel ('Time (Seconds)')
ylabel ('Amplitude')
title("x0[n] 300Hz 2s delay")
ylim([-1, 1])
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')

subplot(2,1,2)
stem(nOut,y3Aligned);
xlabel ('Time (Seconds)')
ylabel ('Amplitude')
title("y3[n] 400Hz 1s delay")
ylim([-1, 1])
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')


[tempY,tempNOut] = addMulSeq(x0, t0, y1, t1, 1/fs, 0);
[tempY1,tempNOut1] = addMulSeq(tempY, tempNOut, y2, t2, 1/fs, 0);
[finalY, finalNOut] = addMulSeq(tempY1, tempNOut1, y3, t3, 1/fs, 0);


figure
fft_x0 = fft(x0);

subplot(2,1,1)
plot(fs/length(x0)*(0:length(x0)-1), abs(fft_x0))
xlim([0,500])
title("Sine Wave 300Hz 2sec Delay")
xlabel("Frequency (Hz)")
ylabel("|fft(x)|")
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')

subplot(2,1,2)
fft_finalY = fft(finalY);
plot(fs/length(finalY)*(0:length(finalY)-1), abs(fft_finalY))
xlim([0,500])
title("Sine Wave after addition with other waves")
xlabel("Frequency (Hz)")
ylabel("|fft(x)|")
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
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

figure
subplot(4,1,1)
stem(t0, x0, "Filled");
title("Original Sine Wave")
xlabel("Time (Seconds)")
ylabel("Amplitude")
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')

%Convolve the sequences
[tempY,tempNOut] = convSeq(x0, t0, y1, t1, 1/fs);

subplot(4,1,2)
stem(tempNOut, tempY, "Filled");
title("Convolution with y1[n]")
xlabel("Time (Seconds)")
ylabel("Amplitude")
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')


[tempY1,tempNOut1] = convSeq(tempY, tempNOut, y2, t2, 1/fs);

subplot(4,1,3)
stem(tempNOut1, tempY1, "Filled");
title("Convolution with y2[n]")
xlabel("Time (Seconds)")
ylabel("Amplitude")
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')


[finalY, finalNOut] = convSeq(tempY1, tempNOut1, y3, t3, 1/fs);


subplot(4,1,4)
stem(finalNOut, finalY, "Filled");
title("Convolution with y3[n]")
xlabel("Time (Seconds)")
ylabel("Amplitude")
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')

%% Helper Functions

function [y, nOut] = addMulSeq(x1, t1, x2, t2, stepSize, addMul)
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
end


function [y, nOut] = convSeq(x1, t1, x2, t2, stepSize)
    y = conv(x1, x2);
    nOut = t1(1) + t2(1):stepSize:(t1(1) + t2(1) + length(y) - 1)*stepSize;
end


function [y1, y2, nOut] = alignSeq(x1, t1, x2, t2, stepSize)

    nOut = min(t1(1), t2(1)):stepSize:max(t1(length(t1)), t2(length(t2)));
    x1 = horzcat(x1, zeros(1,length(nOut) - length(x1)));
    x1 = circshift(x1, find(nOut == t1(1)) - 1);

    x2 = horzcat(x2, zeros(1,length(nOut) - length(x2)));
    x2 = circshift(x2, find(nOut == t2(1)) - 1);

    y1 = x1;
    y2 = x2;

end






