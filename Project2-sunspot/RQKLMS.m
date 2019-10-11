function [count] = RQKLMS(lr_k,h,epsu,X,T,X_te,T_te,r,thd)
%init

epsf = sqrt(2-2*exp(-epsu^2*h));
N_tr = size(X,2);
N_te = size(X_te,2);
% e_k = zeros(N_tr,1);
y = zeros(N_tr,1);
% n=1 init
% e_k(1) = T(1);
y(1) = 0;
% start
neuralsize = zeros(1,N_tr);
mem = X(:,1);
alpha = lr_k*T(1);
for n=r-100:r-1
    %training
    ii = 1:size(mem,2);
    dist = exp(-sum((X_te(:,n)*ones(1,size(mem,2))-mem(:,ii)).^2)*h);
    y(n) = alpha(ii)*(dist)';
    err_d = T_te(n)-y(n);
    dist = sqrt(2-2*dist);
    %e_k(n) = T(n) - y(n);
    [mm,j]=min(dist);
    if mm<=epsf
        alpha(j) = alpha(j) + lr_k*err_d;
    else
        mem =[mem,X_te(:,n)];
        alpha = [alpha,err_d];
    end
%     neuralsize(n) = size(mem,2);
%     err = y - T ;
%     mse = err'*err/N_tr;
%     testing
%     y_te = zeros(N_te,1);
%     
%     for jj = 1:N_te
%         ii = 1:size(mem,2);
%         y_te(jj) = alpha(ii)*(exp(-sum((X_te(:,jj)*ones(1,size(mem,2))-mem(:,ii)).^2)*h))';
%     end
%     err = T_te - y_te;
%     mse_te_k(n) =  err'*err/(T_te'*T_te);
end
% y_te = zeros(N_te,1);
count = 0;    
for jj = r:3200
    count = count +1;
    ii = 1:size(mem,2);
%     y_te= alpha(ii)*(exp(-sum((X_te(:,r)*ones(1,size(mem,2))-mem(:,ii)).^2)*h))';
    y_te = alpha(ii)*(exp(-sum((X_te(:,r)*ones(1,size(mem,2))-mem(:,ii)).^2)*h))';
    err = T_te(jj) - y_te;
    mse_te_k =  err'*err/(X_te(jj)'*X_te(jj));
    if mse_te_k>thd
        break
    end
end
count = jj-r+1;

end