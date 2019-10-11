function [count]=RLMCC(lr,X,T,X_te,T_te,hmcc,r,thd)
N_tr = size(X,2);
TD = size(X,1);
%N_te = size(X_te,2);
%lr = .01;%learning rate
w1 = zeros(1,TD);
e_l = zeros(N_tr,1);
count =0;
for n=r-100:r-1
%     count = count+1;
    y = w1*X_te(:,n);
    e_l(n) = T_te(n) - y;
%     mse = e_l(n)^2/(X(:,n)'*X(:,n));
%     if mse <thd
%         break
%     end
    w1 = w1 + lr*exp(-e_l(n)^2*hmcc)*e_l(n)*X_te(:,n)';
    %testing
%     for j =1:N_te
%         err(j) = T_te(j)-(w1*X_te(:,j));
%     end
%     mse_te(n) = err*err'/(T_te'*T_te);
end
% for j =1:N_te
%     err(j) = T_te(j)-(w1*X_te(:,j));
% end
% mse_te = err*err'/(T_te'*T_te);
for j =r:3200
    count = count+1;
    y_te = w1*X_te(:,r);
    err(j) = T_te(j)-y_te;
    mse_te(j) = err(j)^2/(X_te(:,j)'*X_te(:,j));
    if mse_te(j)>thd
        break
    end
end
end