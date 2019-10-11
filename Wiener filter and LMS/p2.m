[y,Fs] = audioread('speech.wav');
%N=100;%window size
%N=200;
N=500;
M=15;%filter mode
%M=6;
wnum=floor((length(y)-2*N-1)/N);
W =zeros(M,wnum);
%err = zeros(1,(length(y)-N-1));
MSE = zeros(1,wnum);
W_save =zeros(M,wnum);
MSE_lms = zeros(1,wnum);
W_lms  = zeros(M,1);
for index= 1:wnum
  x = y((index-1)*N+1:index*N);  
  d = y(N*index+1:N*(1+index));
  acfin = xcorr(x);

  Rxx=zeros(M);
  for m=1:M                            
    for n=1:M
        Rxx(m,n)=acfin(N+abs(m-n));
    end
  end
 p = xcorr(x,d);
 P = p(N:(N+M-1));
 %w_opt = 
 W(:,index)=Rxx\P;
%  X = zeros(length(x),M);
%  for i = 1:length(x)
%     for j =1:M
%         X(i,j) = y(index*N+j-1);
%     end
%  end
 pred = conv(x,W(:,index));
 err = d - pred(1:N);
 MSE(index) = err'*err/(x'*x);
 %err = d - pred;

 en = zeros(N,1);

 mu =0.1;
 for k = 1:(N-M)
     x_lms = x(k+M-1:-1:k);
     y_lms = W_lms.' * x_lms;
     en(k) = d(k+M) - y_lms ;
     W_lms = W_lms + mu*en(k)*x_lms;
 end
 W_save(:,index)=W_lms;
 pred_lms = conv(x,W_lms);
 err_lms = d-pred_lms(1:N);
 MSE_lms(index) = err_lms'*err_lms/(x.'*x);
end
figure(1)
plot(MSE_lms)
hold on
plot(MSE)
xlabel('window')
ylabel('Normalized MSE value ')
title(['M=',num2str(M),' N=',num2str(N)])
legend('LMS','Wiener')
figure(2)
for i = 1:M
    plot(W_save(i,:))
    hold on 
    xlabel('w(i)')
    ylabel('value')
end
% plot(W(:,2))
% hold on
% plot(W(:,3))
% hold on
% xticks([1 2 3])
% xticklabels({'100','500','1000'})

