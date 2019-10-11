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