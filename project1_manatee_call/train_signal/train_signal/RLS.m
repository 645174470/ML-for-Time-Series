function[MSE,w_opt]=RLS(forget_factor,M,x)
iters=length(x)-M;  
RLS_e = zeros(1,iters);
W_e = zeros(M,iters);
T = eye(M,M)*10;
MSE = zeros(1,iters);
for j=1:iters                   
        U=x(j+M-1:-1:j);                     
        Pi=T*U;                               
        K=Pi/(forget_factor+U'*Pi);           
        RLS_e(j)=x(j+M)-W_e(:,j)'*U;               
        W_e(:,j+1)=W_e(:,j)+K*RLS_e(j);  
        pred = W_e(:,j+1)'*U;
        e = x(j+M) - pred;
        MSE(j) = e'*e/(U'*U);
        T=(T-T*U*U'*T/(forget_factor+U'*T*U))/forget_factor;
        w_opt = W_e(:,end);
end
end