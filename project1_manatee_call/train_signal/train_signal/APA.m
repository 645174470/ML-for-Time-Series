
function [MSE_apa,w_opt] = APA(y,M,N,iters)
d = zeros(N,1);
U = zeros(M,N);
eta = 0.1;
lam = 0.001;
w = zeros(M,iters);
MSE_apa = zeros(iters,1);
pred_apa = zeros(iters,1);
for j = (1:iters)
    for i =(1:N)
        U(:,i) = y(i+j+M-1:-1:i+j);
        d(i) = y(i+j+M);
    end
    %Ru = U*U'/N;
    %r_du = U*d/N;
    if j==1
        w(:,j) = eta*U/(U'*U+lam*eye(N,N))*d;
    else
    w(:,j) = (1-eta)*w(:,j-1) + eta*U/(U'*U+lam*eye(N,N))*d;
    end
    pred_apa(j) = y(j+N+M:-1:j+N+1)'*w(:,j);
    d_apa = y(j+N+M+1);
    err_APA = d_apa-pred_apa(j);
    MSE_apa(j) = err_APA'*err_APA/(y(j+N+M:-1:j+N+1).'*y(j+N+M:-1:j+N+1));
end
w_opt = w(:,end);
end