[x,Fs] = audioread('speech.wav');
M=15;    
%mode = [6,15];
%  forget = [0.2,0.5,0.9];
forget_factor=0.98;
% MSE = zeros(3,length(x)-30);
% [MSE(1,:),W]=RLS(0.2,M,x);
% [MSE(2,:),W]=RLS(0.5,M,x);
% [MSE(3,:),W]=RLS(0.98,M,x);
%[MSE(4,:),W]=RLS(0.98,M,x);
% 
% for i =1:3
% subplot(3,1,i)
% plot(MSE(i,:))
% xlabel('iteration')
% ylabel('MSE for RLS')
% title(['forget factor =',num2str(forget(i))])
% axis([0,18000,0,0.5])
% end
% xlabel('iteration')
% ylabel('MSE for RLS')
%legend('M=6','M=15')
%legend('forget factor=0.2','forget factor=0.5','forget factor=0.9')
% for i = 1:15
%     plot(W(i,:))
%     hold on
% end
% ylabel('value')
% xlabel('iteration')
% title('change of w(i)')
[MSE,W_e]=RLS(0.98,15,x);
plot(MSE)
xlabel('iteration')
ylabel('MSE for RLS')
axis([0,18000,0,0.5])
function[MSE,W_e]=RLS(forget_factor,M,x)
iters=length(x)-30;  
RLS_e = zeros(1,iters);
W_e = zeros(M,iters);
T = eye(M,M)*10;
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
end
end

