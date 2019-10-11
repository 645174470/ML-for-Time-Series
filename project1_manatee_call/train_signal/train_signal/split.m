[test_signal,Fs] =audioread('test_signal.wav');
[time_signal,Fs2] =audioread('time series with calls.mp3');
fs = 17640*3;
batch = length(test_signal)/fs;
audio = zeros(fs,batch);
for i = 1:batch
    audio(:,i) = test_signal((i-1)*fs+1:i*fs);
    sound(audio(:,i),Fs)
    pause(5)
    clear sound
end
label1 = [0,0,1,0,0,1,0,0,1,0,0,0,1,0,1,0,0,0,0,1,1,1,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1,0,1,1,0,1,1,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0];