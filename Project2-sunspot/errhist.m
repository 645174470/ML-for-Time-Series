function [hist1] = errhist(e1)
e1 = abs(e1);
hist1 = zeros(1,6);
for i =1:length(e1)
    if e1(i)<0.2
        hist1(1)=hist1(1)+1;
    elseif e1(i)<0.4
        hist1(2)=hist1(2)+1;
    elseif e1(i)<0.6
        hist1(3) = hist1(3)+1;
    elseif e1(i)<0.8
        hist1(4) = hist1(4)+1;
    elseif e1(i)<1
        hist1(5) = hist1(5)+1;
    else 
        hist1(6) = hist1(6)+1;
    end
end
end