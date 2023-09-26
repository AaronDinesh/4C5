% function [y, nOut] = AddSeq(x1, t1, x2, t2)
%     figure
%     hold on
%     plot(t1, x1)
%     plot(t2,x2)
% 
%     nOut = min(t1(1),t2(1)):1:max(t1(length(t1)),t2(length(t2)));
%     offset1 = strfind(erase(strjoin(string(nOut),''),'-'), erase(strjoin(string(t1),''),'-')) - 1;
%     x1 = horzcat(zeros(1,offset1),x1);
%     x1 = horzcat(x1, zeros(1,max(length(nOut) - length(x1),0)));
%     erase(strjoin(string(nOut),''),'-')
%     offset2 = strfind(erase(strjoin(string(nOut),''),'-'), erase(strjoin(string(t2),''),'-')) - 1;
%     x2 = horzcat(zeros(1,offset2), x2);
%     x2 = horzcat(x2, zeros(1,max(length(nOut) - length(x2),0)));
%     y = x1+x2;
% 
%     plot(nOut, y)
%     hold off
% end


function [y, nOut] = addSeq(x1, t1, x2, t2)
    figure
    hold on
    stem(t1, x1)
    stem(t2,x2)
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

    y = x1+x2;

    stem(nOut,y)
    title ('Time Aligned Sequences') % Figure title
    xlabel ('Time')
    ylabel ('Amplitude')
    legend("x1[n]", "x2[n]", "x1[n]+x2[n]")
    hold off
end
    