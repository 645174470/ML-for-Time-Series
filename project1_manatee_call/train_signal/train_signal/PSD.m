function []=PSD(s,Fs)
Y = fft(s);
halfl = floor(length(s)/2);
Pyy = Y(1:halfl+1);
Pyy = abs(Pyy);
f = ((0:halfl)+1)*Fs/length(s);
Pyy = Pyy/length(s);
Pyy = Pyy.^2;
if rem(length(s),2)
    Pyy(2:end) = Pyy(2:end)*2;
else
    Pyy(2:end-1) = Pyy(2:end-1)*2;
end
plot(f/1000, 10*log10(Pyy),'k')
xlabel('Frequency(kHz)')
ylabel('Power(dB)')
end