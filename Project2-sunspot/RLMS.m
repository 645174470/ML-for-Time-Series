function [count,mse_te] = RLMS(lr,X,T,X_te,T_te,r,thd)
N_tr = size(X,2);
TD = size(X,1);
N_te = size(X_te,2);
%lr = .01;%learning rate
w1 = zeros(1,TD);
e_l = ones(N_tr,1);
count = 0;
for n=r-100:r-1
    y = w1*X_te(:,n);
    e_l(n) = T_te(n) - y;
    w1 = w1 + lr*e_l(n)*X_te(:,n)';
    %testing
%     for j =1:N_te
%         y_te(j) = w1*X_te(:,j);
%         err(j) = T_te(j)-y_te(j);
%     end
%     mse_te(n) = err*err'/(T_te'*T_te);
end
for j =r:3200
    count = count+1;
    y_te = w1*X_te(:,r);
    err(j) = T_te(j)-y_te;
    mse_te(j) = err(j)^2/(X_te(:,j)'*X_te(:,j));
    if mse_te(j)>thd
        break
    end
end
% mse_te = err*err'/(T_te'*T_te);
end