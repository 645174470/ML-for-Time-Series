function [err,mse_te]=LMCC(lr,X,T,X_te,T_te,hmcc)
N_tr = size(X,2);
TD = size(X,1);
N_te = size(X_te,2);
%lr = .01;%learning rate
w1 = zeros(1,TD);
e_l = zeros(N_tr,1);
for n=1:N_tr
    y = w1*X(:,n);
    e_l(n) = T(n) - y;
    w1 = w1 + lr*exp(-e_l(n)^2*hmcc)*e_l(n)*X(:,n)';
    %testing
%     for j =1:N_te
%         err(j) = T_te(j)-(w1*X_te(:,j));
%     end
%     mse_te(n) = err*err'/(T_te'*T_te);
end
for j =1:N_te
    err(j) = T_te(j)-(w1*X_te(:,j));
end
mse_te = err*err'/(T_te'*T_te);

end