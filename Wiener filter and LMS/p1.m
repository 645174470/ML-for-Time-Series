h=ones(10,1);%h(n)
asn = zeros(10000,1);%stable noise
randnum = rand(10000,1);
for n=1:10000
    asn(n)= fft(exp(-abs(randnum(n))^1.8)); 
end
mode= [5,15,30];
sample= [100,500,1000];
noise_power = [0.1,0.3,1.5];
A = zeros(3);
B = zeros(3);
C = zeros(3);
D = zeros(3);
% M = 30;
% N=1000;
% w_opt = zeros(3);
mu = 0.05;
for i = 1:length(mode)
    for j = 1:length(sample)
        M = mode(i);
        N = sample(j);
        [A(i,j),B(i,j),C]=LMS(asn,h,M,N,mu,0.1);
    end
end
figure(1)
plot(A(1,:),'red--')
hold on
plot(A(2,:),'g')
hold on
plot(A(3,:),'b:.')
hold on
xticks([1 2 3])
xticklabels({'100','500','1000'})
xlabel('number of samples')
ylabel('MSE for Wiener solution')
legend('M=5','M=15','M=30')
%title('WSNR for Wiener solution')
figure(2)
plot(B(1,:),'red--')
hold on
plot(B(2,:),'g')
hold on
plot(B(3,:),'b:.')
hold on
xticks([1 2 3])
xticklabels({'100','500','1000'})
xlabel('number of samples')
ylabel('WSNR for Wiener solution')
legend('M=5','M=15','M=30')
function[MSE_lms,WSNR_lms,w_opt_lms]=LMS(asn,h,M,N,mu,power)
gn=wgn(10000,1,power);%gaussian noise
en = zeros(N,1);
input = asn(1:N);
output= conv(input,h);
d = output(1:N)+gn(1:N);
W  = 0.01*rand(M,length(input));
for k = M:length(input)
    x = asn(k:-1:k-M+1);
    y = W(:,k-1).' * x;
    en(k) = d(k) - y ;
    W(:,k) = W(:,k-1) + mu*en(k)*x;
end
yn = zeros(size(input));
w_opt_lms = W(:,end);
for index = M:length(input)
    xx = input(index:-1:index-M+1);
    yn(index) = w_opt_lms'*xx;
end

err_lms = d(M:length(input))-yn(M:length(input));
MSE_lms = err_lms'*err_lms/(input'*input);
if M > 10
    h(M)=0;
    WSNR_lms = 10*log10(h'*h/((h-w_opt_lms)'*(h-w_opt_lms)));
else
    h_opt_lms = h(1:M);
    WSNR_lms = 10*log10(h_opt_lms'*h_opt_lms/((h_opt_lms-w_opt_lms)'*(h_opt_lms-w_opt_lms)));
end
end
function[MSE,WSNR,w_opt]=wiener(asn,h,M,N,power)
gn=wgn(10000,1,power);
input=asn(1:N);
output=conv(input,h);
d = zeros(N,1);
for index= 1:N
    d(index)=gn(index)+output(index);
end
acfin = xcorr(input);
Rxx=zeros(M);
for i=1:M
    for j=1:M
        Rxx(i,j)=acfin(N+abs(i-j));
    end
end
p = xcorr(input,d);
P = p(N:(N+M-1));
w_opt = Rxx\P;
if M > 10
    h(M)=0;
    WSNR = 10*log10(h.'*h/((h-w_opt).'*(h-w_opt)));
else
    h_opt = h(1:M);
    WSNR = 10*log10(h_opt.'*h_opt/((h_opt-w_opt).'*(h_opt-w_opt)));
end
% X = zeros(length(input),M);
% for i = 1:length(input)
%     for j =1:M
%         X(i,j) = asn(i+j-1);
%     end
% end
pred=conv(input,w_opt);
err = d(1:N) - pred(1:N);
MSE = err'*err/(input'*input);
end
