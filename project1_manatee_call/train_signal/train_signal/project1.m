[train_signal,Fs1] =audioread('train_signal.wav');
[noise_signal,Fs2] =audioread('noise_signal.wav');
[test_signal,Fs3] =audioread('test_signal.wav');
train_signal(abs(train_signal)<0.01)=[];

% h_train_signal = highp(train_signal,5000,3000,10,300,Fs1);
% h_noise_signal = highp(noise_signal,5000,3000,10,300,Fs2);
h_test_signal = highp(test_signal,5000,3000,10,300,Fs2);
% h_test_signal(abs(h_test_signal)<0.04)=0;
% h=ones(10,1)/10;

% y2 = conv(h,test_signal);
% modified_test = y2(1:length(test_signal));
% figure(1)
% subplot(3,1,1)
% 
% subplot(3,1,2)
% plot(y2)
% subplot(3,1,3)
% plot(test_signal)
% figure(2)
% subplot(3,1,1)
% pwelch(train_signal)
% subplot(3,1,2)
% pwelch(noise_signal)
% subplot(3,1,3)
% pwelch(test_signal)
% [MSE_train,w_train] = RLS(0.98,3,train_signal);
% M = 5;
a = zeros(1,5);
b = zeros(1,5);
count = 1;
forget_factor = 0.15;
M=5;
[MSE_train,w_train] = RLS(forget_factor,M,train_signal);
output1 = conv(test_signal,w_train);
% figure(1)
% subplot(2,2,1)
% plot(output1)
% title('train signal prediction for original test sognal')
[~,w_noise] = RLS(forget_factor,M,noise_signal);
output2 = conv(test_signal,w_noise);
% subplot(2,2,2)
% plot(output2)
% title('noise signal prediction for original test sognal')
% subplot(2,2,3)
% [~,w_train] = RLS(0.98,M,train_signal);
output3 = conv(h_test_signal,w_train);
% plot(output3)
% title('train signal prediction for filtered test sognal')
% subplot(2,2,4)
% [MSE_noise,w_noise] = RLS(0.58,M,noise_signal);
output4 = conv(h_test_signal,w_noise);
% plot(output4)
% title('noise signal prediction for filtered test sognal')
batch = 17640;
iters = length(test_signal)/batch;
label1 = zeros(1,iters);
label2 = zeros(1,iters);
label3 = zeros(1,iters);
score = zeros(1,iters);
for i = 1:iters   
    err1 = output1((i-1)*batch+1:i*batch)- test_signal((i-1)*batch+1:i*batch);
    err2 = output2((i-1)*batch+1:i*batch)- test_signal((i-1)*batch+1:i*batch);
    err3 = output3((i-1)*batch+1:i*batch)- h_test_signal((i-1)*batch+1:i*batch);
    err4 = output4((i-1)*batch+1:i*batch)- h_test_signal((i-1)*batch+1:i*batch);
    if err1'*err1<err2'*err2
        label1(i)=1;
    end
     if err3'*err3<err4'*err4
        label2(i)=1;
     end
     score(i) = err4'*err4-err3'*err3;
     if score(i)>-6.7539
         label3(i)=1;
     end
end
% figure(1)
% subplot(3,1,1)
% stem(label1)
% title('Prediction for original test signal') 
% subplot(3,1,2)
% stem(label2)
% title('Prediction for filtered test signal') 
% subplot(3,1,3)
t_label=[0,0,1,0,0,1,0,0,1,0,0,0,1,0,1,0,0,0,0,1,1,1,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1,0,1,1,0,1,1,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0];
% stem(t_label)
% title('Ground Truth') 
% figure(2)
% roc = ROC(label2,t_label,M);
% figure(3)
% roc2 = ROC(label2,t_label,forget_factor);

% prediction = zeros(1,length(test_signal));
% for i =1:length(predict)
%     if predict(i)==1
%         prediction((i-1)*17640+1:i*17640)= ones(1,17640);
%     end
% end
% stem(prediction)
