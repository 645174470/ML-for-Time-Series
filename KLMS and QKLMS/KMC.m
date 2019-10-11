%=========Kernel LMS===================

function [t,neuralsize,mse_te_k]= KMC(lr_k,h,X,T,X_te,T_te)
N_tr = size(X,2);
N_te = size(X_te,2);
neuralsize = zeros(1,N_tr);
mse_te_k = zeros(1,N_tr);
%init
e_k = zeros(N_tr,1);
y = zeros(N_tr,1);
% y_te = zeros(N_te,1);
% n=1 init
e_k(1) = T(1);
y(1) = 0;
t=zeros(1,N_tr);
mse_te_k(1) = mean(T_te.^2);
% start
for n=2:N_tr
    %training
    tic
    ii = 1:n-1;
    y(n) = lr_k*(exp(-e_k(ii).^2*h).*e_k(ii))'*(exp(-sum((X(:,n)*ones(1,n-1)-X(:,ii)).^2)*h))';
    
    e_k(n) = T(n) - y(n);
    
    err = y - T ;
    mse = mean(err.^2);
    %testing
    y_te = zeros(N_te,1);
 
    for jj = 1:N_te
        ii = 1:n;
        y_te(jj) = lr_k*((exp(-e_k(ii).^2*h).*e_k(ii)))'*(exp(-sum((X_te(:,jj)*ones(1,n)-X(:,ii)).^2)*h))';
    end
  
    err = T_te - y_te;
    mse_te_k(n) = mean(err.^2);
    neuralsize(n) = n;
    t(n)=toc;
end
end
%=========end of Kernel LMS================