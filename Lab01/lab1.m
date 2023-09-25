close all
clear

n = -10:1:10;

%Exe 2.2
hold on
out = delta(n) + 2.*delta(n-1) - delta(n-3) + delta(n-4) + 2.*delta(n-5);
stem(n, out)
title ('Exercise 2.2 - x[n]') % Figure title
xlabel ('Time')
ylabel ('Amplitude')
hold off

%Exe2.3
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


%Exe2.4

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

function seq = delta(n)
    seq = n == 0;
end



