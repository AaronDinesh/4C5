close all
clear

n = -10:1:10;

%% Exe 2.2
close all
clear

hold on
out = delta(n) + 2.*delta(n-1) - delta(n-3) + delta(n-4) + 2.*delta(n-5);
stem(n, out)
title ('Exercise 2.2 - x[n]') % Figure title
xlabel ('Time')
ylabel ('Amplitude')
hold off

%% Exe2.3
close all
clear

figure
subplot(1,3,1)
% Delay the signal by 2
stem(n, out)
title ('Exercise 2.3 - No Time Shift') % Figure title
xlabel ('Time')
ylabel ('Amplitude')

subplot(1,3,2)
stem(n, delayseq(out', 2))
title ('Exercise 2.3 - Delay by 2 ') % Figure title
xlabel ('Time')
ylabel ('Amplitude')

subplot(1,3,3)
stem(n, delayseq(out', -3))
title ('Exercise 2.3 - Advance by 3 ') % Figure title
xlabel ('Time')
ylabel ('Amplitude')

%% Exe2.4
close all
clear

n1 = -5:1:5;
out1 = -1.*delta(n1-1) +3.*delta(n1-2);
out2 = 3.*delta(n1-1)+3.*delta(n1-2)+delta(n1-3)-2.*delta(n1-4);
figure
subplot(1,3,1)
% Delay the signal by 2
stem(n1, out1)
title ('Exercise 2.4 - x1[n]') % Figure title
xlabel ('Time')
ylabel ('Amplitude')

subplot(1,3,2)
stem(n1,out2)
title ('Exercise 2.4 - x2[n]') % Figure title
xlabel ('Time')
ylabel ('Amplitude')

subplot(1,3,3)
stem(n1, out1+out2)
title ('Exercise 2.4 - x1[n]+x2[n]') % Figure title
xlabel ('Time')
ylabel ('Amplitude')

%% Exe 2.5
close all
clear

t1 = -10:1:3;
x1 = 1:1:length(t1);

t2 = -3:1:13;
x2 = 1:1:length(t2);

[y, nOut] = addSeq(x1, t1, x2, t2);

%% Exe 2.6
close all
clear

t1 = -4:1:4;
x = delta(t1+3) + delta(t1+1) + delta(t1-1) + delta(t1-3);
h = delta(t1);
y = conv(x,h);
figure
hold on
stem(t1,x)
stem(t1,h)
stem(y)
title ('Exercise 2.6 - x[n]*h[n]') % Figure title
xlabel ('Time')
ylabel ('Amplitude')
legend("x[n]", "h[n]", "y[n]")
hold off


%% Optional Exe 2.7
close all
clear

T = readtable('IRL_DLY_RR_2021_grid.csv') ; % built in matlab function to
Tarray = table2array (T) ; % strip headers
seq = Tarray(1,3:end);
seq = seq ./ 10;
windowSize = 3;
[hN, hNOut] = movAvg(windowSize);
y = conv(seq, hN);
stem(y);
ylabel("Rainfall in mm")
title(sprintf('Moving Average Window Size %d',windowSize));



% loop = 40;
% fig = figure('WindowState', 'maximized');
% fig.Visible = 'off';
% fig.Position(3:4)=[1920,1080];
% v = VideoWriter("MovingAverage","MPEG-4");
% v.FrameRate = 2;
% open(v);
% for i = 1:loop
%     [hN, hNOut] = movAvg(i);
%     y = conv(seq, hN);
%     stem(y);
%     title(sprintf('Moving Average Window Size %d',i));
%     drawnow();
%     writeVideo(v,getframe);
% end
% fig.Visible = 'on';
% close(v);
%% Functions
function seq = delta(n)
    seq = n == 0;
end

function [h, nOut] = movAvg(windowSize)
    nOut = 1:1:windowSize;
    h(1:windowSize)  = 1/windowSize;   
end

function [aX1, aX2, nOut] = alignSeq(x1, t1, x2, t2,1)
    nOut = min(t1(1),t2(1)):1:max(t1(length(t1)),t2(length(t2)));
    x1 = horzcat(x1, zeros(1,length(nOut) - length(t1)));
    t1 = horzcat(t1, zeros(1,length(nOut) - length(t1)));

    while(sum(nOut == t1) ~= 0)
        t1 = circshift(t1,1);
        x1 = circshift(x1,1);
    end
    x2 = horzcat(x2, zeros(1,length(nOut) - length(t2)));
    t2 = horzcat(t2, zeros(1,length(nOut) - length(t2)));

    while(sum(nOut == t2) ~= 0)
        t2 = circshift(t2,1);
        x2 = circshift(x2,1);
    end

    aX1 = x1;
    aX2 = x2;
end


