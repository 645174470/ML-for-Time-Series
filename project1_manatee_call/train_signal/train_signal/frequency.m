[train_signal,Fs1] =audioread('train_signal.wav');
[noise_signal,Fs2] =audioread('noise_signal.wav');
[test_signal,Fs3] =audioread('test_signal.wav');
Y1 = fft(train_signal,length(train_signal));
Y2 = fft(noise_signal,length(noise_signal));
Y3 = fft(test_signal,length(test_signal));
% figure(1)
% subplot(3,1,1)
% plot(abs(Y1))
% xlim([0,1000])
% subplot(3,1,2)
% plot(abs(Y2))
% xlim([0,1000])
% subplot(3,1,3)
% plot(abs(Y3))
% xlim([0,1000])
t1 = (0:length(train_signal)-1)/Fs1;
t2 = (0:length(noise_signal)-1)/Fs2;
t3 = (0:length(test_signal)-1)/Fs3;
halfl1=floor(length(train_signal)/2);
Pyy1 = Y1(1:halfl1+1);
Pyy1 = abs(Pyy1);
f1 = ((0:halfl1)+1)*Fs1/length(train_signal);
halfl2=floor(length(noise_signal)/2);
Pyy2 = Y2(1:halfl2+1);
Pyy2 = abs(Pyy2);
f2 = ((0:halfl2)+1)*Fs2/length(noise_signal);
halfl3=floor(length(test_signal)/2);
Pyy3 = Y3(1:halfl3+1);
Pyy3 = abs(Pyy3);
f3 = ((0:halfl3)+1)*Fs3/length(test_signal);
figure(1)
subplot(3,1,1)
plot(f1,Pyy1)
title('Manatee Call')
xlabel('Frenquency(Hz)')
ylabel('Amplitude')
subplot(3,1,2)
plot(f2,Pyy2)
title('Noise')
xlabel('Frenquency(Hz)')
ylabel('Amplitude')
xlim([0,2000])
ylim([0,2000])
subplot(3,1,3)
plot(f3,Pyy3)
title('Test Signal')
xlabel('Frenquency(Hz)')
ylabel('Amplitude')
ylim([0,2000])
filtered = highp(test_signal,300,10,1,80,Fs2);
Y2f = fft(filtered,length(filtered));
Pyyf = Y2f(1:halfl3+1);
% figure(2)
% plot(f3,abs(Pyyf))
% xlim([0,1000])
% plot(filtered)
% label1 = [0,0,1,0,0,1,0,0,1,0,0,0,1,0,1,0,0,0,0,1,1,1,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1,0,1,1,0,1,1,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0];
% figure(3)
% stem(label1)