%% Exe 2.2
close all
clear

n = -10:1:10;
figure
hold on
out = delta(n) + 2.*delta(n-1) - delta(n-3) + delta(n-4) + 2.*delta(n-5);
stem(n, out)
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
title ('Exercise 2.2 - x[n]') % Figure title
xlabel ('Time')
ylabel ('Amplitude')
hold off

%% Exe2.3
close all
clear

n = -10:1:10;
out = delta(n) + 2.*delta(n-1) - delta(n-3) + delta(n-4) + 2.*delta(n-5);
figure
subplot(3,1,1)
% Delay the signal by 2
stem(n, out)
title ('Exercise 2.3 - No Time Shift') % Figure title
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
xlabel ('Time (Seconds)')
ylabel ('Amplitude')

subplot(3,1,2)
stem(n, delayseq(out', 2))
title ('Exercise 2.3 - Delay by 2 ') % Figure title
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
xlabel ('Time (Seconds)')
ylabel ('Amplitude')

subplot(3,1,3)
stem(n, delayseq(out', -3))
title ('Exercise 2.3 - Advance by 3 ') % Figure title
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
xlabel ('Time (Seconds)')
ylabel ('Amplitude')

%% Exe2.4
close all
clear

n1 = 1:1:2;
out1 = -1.*delta(n1-1) +3.*delta(n1-2);
subplot(3,1,1)
stem(n1, out1)
title ('Exercise 2.3 - x1[n]') % Figure title
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
xlabel ('Time (Seconds)')
ylabel ('Amplitude')

n2 = 1:1:4;
out2 = 3.*delta(n2-1)+3.*delta(n2-2)+delta(n2-3)-2.*delta(n2-4);
subplot(3,1,2)
stem(n2, out2)
title ('Exercise 2.3 - x2[n]') % Figure title
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
xlabel ('Time (Seconds)')
ylabel ('Amplitude')

[y1, y2, nOut] = alignSeq(out1, n1, out2, n2);


subplot(3,1,3)
hold on
stem(nOut, y1)
stem(nOut, y2)
title ('Exercise 2.3 - x2[n]') % Figure title
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
xlabel ('Time (Seconds)')
ylabel ('Amplitude')
legend("x1[n]", "x2[n]")
hold off

%% Exe 2.5
close all
clear
figure
t1 = -10:1:3;
x1 = 1:1:length(t1);
subplot(3,1,1)
stem(t1,x1)
title ('Exercise 2.5 - x1[n]') % Figure title
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
xlabel ('Time (Seconds)')
ylabel ('Amplitude')

t2 = -3:1:13;
x2 = 1:1:length(t2);
subplot(3,1,2)
stem(t2,x2)
title ('Exercise 2.5 - x2[n]') % Figure title
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
xlabel ('Time (Seconds)')
ylabel ('Amplitude')



[y, nOut] = addSeq(x1, t1, x2, t2);

subplot(3,1,3)
stem(nOut,y)
title ('Exercise 2.5 - y[n] = x1[n] + x2[n]') % Figure title
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
xlabel ('Time (Seconds)')
ylabel ('Amplitude')

%% Exe 2.6
close all
clear

t1 = -4:1:4;
x = delta(t1+3) + delta(t1+1) + delta(t1-1) + delta(t1-3);
h = delta(t1 - 1);
y = conv(x,h);

subplot(3,1,1)
stem(t1, x, "Filled")
title ('Exercise 2.6 - x[n]') % Figure title
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
xlabel ('Time (Seconds)')
ylabel ('Amplitude')

subplot(3,1,2)
stem(t1, h, "Filled")
title ('Exercise 2.6 - h[n]') % Figure title
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
xlabel ('Time (Seconds)')
ylabel ('Amplitude')

subplot(3,1,3)

convT = t1(1)+t1(1):t1(1)+t1(1)+length(y)-1;

stem(convT, y, "Filled")
title ('Exercise 2.6 - y[n]') % Figure title
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')
xlabel ('Time (Seconds)')
ylabel ('Amplitude')
%% Optional Exe 2.7
close all
clear

T = readtable('IRL_DLY_RR_2021_grid.csv') ; % built in matlab function to
Tarray = table2array (T) ; % strip headers
seq = Tarray(1,3:end);
seq = seq ./ 10;


figure
stem(seq, "Filled");
ylabel("Rainfall in mm")
title("Raw Data");
xlim([0, 365])
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')

figure
windowSize = 3;
[hN, hNOut] = movAvg(windowSize);
y = conv(seq, hN);
stem(y, "Filled");
ylabel("Rainfall in mm")
xlim([0, 365])
title(sprintf('Moving Average Window Size %d',windowSize));
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')

figure
windowSize = 5;
[hN, hNOut] = movAvg(windowSize);
y = conv(seq, hN);
stem(y, "Filled");
xlim([0, 365])
ylabel("Rainfall in mm")
title(sprintf('Moving Average Window Size %d',windowSize));
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')

figure
windowSize = 7;
[hN, hNOut] = movAvg(windowSize);
y = conv(seq, hN);
stem(y, "Filled");
xlim([0, 365])
ylabel("Rainfall in mm")
title(sprintf('Moving Average Window Size %d',windowSize));
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')

figure
windowSize = 10;
[hN, hNOut] = movAvg(windowSize);
y = conv(seq, hN);
stem(y, "Filled");
xlim([0, 365])
ylabel("Rainfall in mm")
title(sprintf('Moving Average Window Size %d',windowSize));
set(gca,'FontSize',15)
set(gca,'FontName','Times New Roman')




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

function [y1, y2, nOut] = alignSeq(x1, t1, x2, t2)

    nOut = min(t1(1), t2(1)):1:max(t1(length(t1)), t2(length(t2)));
    x1 = horzcat(x1, zeros(1,length(nOut) - length(x1)));
    x1 = circshift(x1, find(nOut == t1(1)) - 1);

    x2 = horzcat(x2, zeros(1,length(nOut) - length(x2)));
    x2 = circshift(x2, find(nOut == t2(1)) - 1);

    y1 = x1;
    y2 = x2;

end

