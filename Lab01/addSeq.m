function [y, nOut] = addSeq(x1, t1, x2, t2)
    figure
    hold on
    subplot(3,1,1)
    stem(t1, x1)
    title("Plot of x1[n]")
    xlabel ('Time (Seconds)')
    ylabel ('Amplitude')

    subplot(3,1,2)
    stem(t2,x2)
    title("Plot of x2[n]")
    xlabel ('Time (Seconds)')
    ylabel ('Amplitude')
    ot1len = length(t1);
    ot2len = length(t2);
    nOut = min(t1(1),t2(1)):1:max(t1(length(t1)),t2(length(t2)));
    x1 = horzcat(x1, zeros(1,length(nOut) - length(t1)));
    t1 = horzcat(t1, zeros(1,length(nOut) - length(t1)));
    
    while(sum(nOut == t1) ~= ot1len)
        t1 = circshift(t1,1);
        x1 = circshift(x1,1);
    end
    x2 = horzcat(x2, zeros(1,length(nOut) - length(t2)));
    t2 = horzcat(t2, zeros(1,length(nOut) - length(t2)));
    sum(nOut == t2)
    while(sum(nOut == t2) ~= ot2len)
        sum(nOut == t2)
        t2 = circshift(t2,1);
        x2 = circshift(x2,1);
    end

    y = x1+x2;
    
    subplot(3,1,3)
    stem(nOut,y)
    title ('Sum of Time Aligned Sequences') % Figure title
    xlabel ('Time')
    ylabel ('Amplitude')
    legend("x1[n]+x2[n]")
    hold off
end