yn = randn(1,5000);
subplot(4,1,1)
plot(yn)
title('yn')
tn = -0.8*yn+0.7*[0,yn(1:end-1)]; % zn=un+0.5*u(n-1)
subplot(4,1,2)
plot(tn)
title('tn')
qn = tn +0.25*tn.^2 + 0.11*tn.^3;
subplot(4,1,3)
plot(qn)
title('qn')
ylim([0,5])
% Ouput of the nonlinear channel
xn = awgn(qn,15);
subplot(4,1,4)
plot(xn)
ylim([0,5])
title('xn')
% N_tr = 1000;
% L = 5;
% h = 0.1;
% X = zeros(L,N_tr);
% for k=1:N_tr
%     X(:,k) = yn(k:k+L-1)';
% end
% 
% 
plot(st)
hold on
plot(stk)
hold on 
plot(stq)
legend('LMS','KLMS','QKLMS')
xlabel('iteration')
ylabel('Running Time')
title('Runing Time')
hold off
for i=1:N_tr
    stk(i) = sum(tk(1:i));
    stq(i) = sum(tq(1:i));
    st(i) = sum(t(1:i));
end
plot(mse_te)
hold on 
plot(mse_te_k)
hold on 
plot(mse_te_q)
legend('LMS','KLMS','QKLMS')
xlabel('iteration')
ylabel('MSE')
hold off