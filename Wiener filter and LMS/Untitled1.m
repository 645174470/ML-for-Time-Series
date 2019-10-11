noise = wgn(10000,1,0.1);
h=ones(10,1);
asn = zeros(10000,1);%stable noise
randnum = 100*rand(10000,1);
for n=1:10000
    asn(n)= fft(exp(-abs(randnum(n))^1.8)); 
end
output=conv(asn,h);
for index= 1:length(asn)
    d(index)=noise(index)+output(index);
end
rxx = xcorr(d);
for i =1:length(rxx)
    out(i)=fft(rxx(i));
end
subplot(1,2,1)
plot(autocorr(d))
xlabel('lag')
ylabel('Normalized value')
title('auto-correlation')
subplot(1,2,2)
pwelch(out)