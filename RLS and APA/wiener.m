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