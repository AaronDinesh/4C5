close all
clear

tt1 = -10:1:-2;
tx1 = 1:1:length(tt1);

tt2 = 0:1:5;
tx2 = 1:1:length(tt2);
[result, time] = AddSeq(tx1, tt1, tx2, tt2)

function [y, nOut] = AddSeq(x1, t1, x2, t2)
    figure
    hold on
    plot(t1, x1)
    plot(t2,x2)

    nOut = min(t1(1),t2(1)):1:max(t1(length(t1)),t2(length(t2)));
    offset1 = strfind(erase(strjoin(string(nOut),''),'-'), erase(strjoin(string(t1),''),'-')) - 1;
    x1 = horzcat(zeros(1,offset1),x1);
    x1 = horzcat(x1, zeros(1,max(length(nOut) - length(x1),0)));

    offset2 = strfind(erase(strjoin(string(nOut),''),'-'), erase(strjoin(string(t2),''),'-')) - 2;
    x2 = horzcat(zeros(1,offset2), x2);
    x2 = horzcat(x2, zeros(1,max(length(nOut) - length(x2),0)));
    y = x1+x2;

    plot(nOut, y)
    hold off

end
