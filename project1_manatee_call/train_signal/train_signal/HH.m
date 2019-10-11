function [false,miss] = HH(pre,label)
false = 0;
miss = 0;
for i = 1:length(pre)
    if pre(i)>label(i)
        false=false+1;
    end
    if pre(i)<label(i)
        miss = miss+1;
    end
end
l1 = length(find(label));
l0 = length(find(pre));
if l0==0
    false =1;
else
    false = false/l0;
end
miss = miss/l1;
end
