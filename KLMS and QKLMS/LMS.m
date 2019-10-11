
function  [w1,mse_te]=LMS(lr,X,T,X_te,T_te)
N_tr = size(X,2);
TD = size(X,1);
%N_te = size(X_te,2);
mse_te = zeros(1,N_tr);
%lr = .01;%learning rate
w1 = zeros(1,TD);
e_l = zeros(N_tr,1);
for n=1:N_tr
    y = w1*X(:,n);
    e_l(n) = T(n) - y;
    w1 = w1 + lr*e_l(n)*X(:,n)';
    %testing
    err = zeros(N_te,1);
    for j =1:N_te
        err(j) = T_te(j)-(w1*X_te(j));
    end
    mse_te(n) = mean(err.^2);
end
end

%==========plot and test===================
% figure
% plot(mse_te,'b-','LineWidth',2)
% hold on
% plot(mse_te_k,'r--','LineWidth',2)
% set(gca, 'FontSize', 14);
% set(gca, 'FontName', 'Arial');
% 
% legend('LMS','KLMS')
% xlabel('iteration')
% ylabel('testing MSE')
