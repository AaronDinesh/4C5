function [y, nOut] = addSeq(x1, t1, x2, t2)
    figure
    hold on
    % plot(t1, x1)
    % plot(t2,x2)
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

    plot(nOut,y)
    title ('Time Aligned Sequences') % Figure title
    xlabel ('Time')
    ylabel ('Amplitude')
    legend("x1[n]", "x2[n]", "x1[n]+x2[n]")
    hold off
end