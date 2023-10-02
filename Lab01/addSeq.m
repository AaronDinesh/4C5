function [y, nOut] = addSeq(x1, t1, x2, t2)
    nOut = min(t1(1), t2(1)):1:max(t1(length(t1)), t2(length(t2)));
    x1 = horzcat(x1, zeros(1,length(nOut) - length(x1)));
    x1 = circshift(x1, find(nOut == t1(1)) - 1);

    x2 = horzcat(x2, zeros(1,length(nOut) - length(x2)));
    x2 = circshift(x2, find(nOut == t2(1)) - 1);

    y = x1+x2;
end