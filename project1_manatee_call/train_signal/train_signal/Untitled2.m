load RNN.txt
load AM.txt
load RLS.txt
a = zeros(1,3);
b = zeros(1,3);
t_label=[0,0,1,0,0,1,0,0,1,0,0,0,1,0,1,0,0,0,0,1,1,1,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1,0,1,1,0,1,1,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0];

[a(1),b(1)] = HH(AM,t_label);
[a(2),b(2)] = HH(RLS,t_label);
[a(3),b(3)] = HH(RNN,t_label);

for i = 1:3
    plot(a,b)
    plot(a(i),b(i),'r.','Markersize',20)
    hold on
    text(a(1),b(1),['Amplitude Method']);
    text(a(2),b(2),['RLS Method']);
    text(a(3),b(3),['RNN Method']);
    title('Methods Comparison')
    xlabel('False discovery rate (FDR)')
    ylabel('False negative rate (FNR), Miss rate ')
end