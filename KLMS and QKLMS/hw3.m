yn = randn(1,5000);
tn = -0.8*yn+0.7*[0,yn(1:end-1)]; % zn=un+0.5*u(n-1)
qn = tn +0.25*tn.^2 + 0.11*tn.^3;
% Ouput of the nonlinear channel
xn = awgn(qn,15);

h = 0.1;
D = 2;
L = 5;
%data size
N_tr = 1000; %number of train
N_te = 50; %number of test
i = 1;
e = zeros(4,N_tr);
for h = [0.01,0.1,0.5,1]
    [e(i,:),y,mse(i)] = KLMS(h,N_tr,yn,D,L);
    figure(i)
    subplot(2,1,1)
    plot(y)
    subplot(2,1,2)
    plot(yn)
    i=i+1;
% Desired signal


end
figure(5)
%['0.01','0.1','0.5','1']
for i = 1:4
    subplot(4,1,i)
    plot(e(i,:))
    hold on
end

    
