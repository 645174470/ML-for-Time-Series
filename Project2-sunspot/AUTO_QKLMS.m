function [count] = AUTO_QKLMS(lr_k,h,epsu,X,T,X_te,T_te,r,thd)
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
% neuralsize = zeros(1,N_tr);
mem = X(:,1);
alpha = lr_k*T(1);
% count = 1;
for n=r-25:r-1
    %training
    ii = 1:size(mem,2);
    dist = exp(-sum((X_te(:,n)*ones(1,size(mem,2))-mem(:,ii)).^2)*h);

    y(n) = alpha(ii)*(dist)';
  
    err_d = T_te(n)-y(n);
%     mse = err_d^2/(X(:,n)'*X(:,n));
%     if mse<thd
%         break
%     end
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
    %err = y - T ;
    %mse = err'*err/N_tr;
    %testing
end
% y_te = zeros(N_te,1);
count = 1;  
ii = 1:size(mem,2);
y_te = alpha(ii)*(exp(-sum((X_te(:,r)*ones(1,size(mem,2))-mem(:,ii)).^2)*h))';
mse_te(r) = T_te(r)^2/(X_te(:,r)'*X_te(:,r));
for jj = r:3200
    err(jj) = T_te(jj) - y_te;
    mse_te(jj) =  err(jj)^2/(X_te(jj)'*X_te(jj));
     if jj-r >1
        if mse_te(jj)<mse_te(jj-1)
            a = 1-exp(-0.1*(count-1));
            count = count+1;
            y_te = (1-a)*T_te(jj)+a*y_te;
        end
    end
%     count = count +1;
    
%     y_te = alpha(ii)*(exp(-sum((X_te(:,r)*ones(1,size(mem,2))-mem(:,ii)).^2)*h))';
    if mse_te(jj)>thd
        break
    end
end
count = jj-r+1;

end