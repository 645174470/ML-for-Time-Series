h = ones(10,1);
x = zeros(10000,1);%stable noise
d = zeros(10000,1);
randnum = rand(10000,1);
power =0.1;
gn = wgn(10000,1,power);
for n=1:10000
    x(n) = fft(exp(-abs(randnum(n))^1.5)); 
end
%mode= [5,15,30];
output = conv(x,h);
d = output(1:10000)+gn;
iters=1000;                                    
M=15; 
WSNR = zeros(3,iters);
MSE = zeros(3,iters);
% for i = 1:length(mode)
%         M = mode(i);
%         [WSNR(i,:),MSE(i,:)]=RLS(M,iters,x,h,d);
% end
% figure(1)
% for i =1:3
%     plot(WSNR(i,:))
%     hold on
% end
% hold off
% xlabel('iteration')
% ylabel('WSNR for RLS')
% legend('M=5','M=15','M=30')
% figure(2)
% for i =1:3
%     plot(MSE(i,:))
%     hold on
% end
% %axis([900,1000,0,1])
% hold off
% xlabel('iteration')
% ylabel('MSE for RLS')
% legend('M=5','M=15','M=30')
% [MSE(2,:),WSNR(2,:)]=LMS(x,h,M,500,0.1,0.1);
% [MSE(1,:),WSNR(1,:)]=wiener(x,h,M,500,0.1);
% [WSNR(3,:),MSE(3,:)]=RLS(M,iters,x,h,d);
% figure(1)
% for i =1:3
%     plot(WSNR(i,:))
%     hold on
% end
% hold off
% xlabel('iteration')
% ylabel('WSNR')
% legend('wiener','LMS','RLS')
% figure(2)
% for i =1:3
%     plot(MSE(i,:))
%     hold on
% end
% %axis([900,1000,0,1])
% hold off
% xlabel('iteration')
% ylabel('MSE')
% legend('wiener','LMS','RLS')
function [WSNR , MSE] = RLS(M,iters,x,h,d)
forget_factor=0.98; 
RLS_e = zeros(1,iters);
W_e = zeros(M,iters);
T = eye(M,M)*10;
for j=1:iters                   
        U=x(j+M-1:-1:j);                     
        Pi=T*U;                               
        K=Pi/(forget_factor+U'*Pi);           
        RLS_e(j)=d(j+M)-W_e(:,j)'*U;               
        W_e(:,j+1)=W_e(:,j)+K*RLS_e(j);  
        y = W_e(:,j+1)'*U;
        err = d(j) - y;
        T=(T-T*U*U'*T/(forget_factor+U'*T*U))/forget_factor;
        w_opt = W_e(:,j+1);
        MSE(j) = err'*err/(U'*U);
        
 if M > 10
    h(M)=0;
    WSNR(j) = 10*log10(h'*h/((h-w_opt)'*(h-w_opt)));
else
    h_opt_lms = h(1:M);
    WSNR(j) = 10*log10(h_opt_lms'*h_opt_lms/((h_opt_lms-w_opt)'*(h_opt_lms-w_opt)));
 end
 
end
end
