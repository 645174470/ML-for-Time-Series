[train_signal,Fs1] =audioread('train_signal.wav');
[noise_signal,Fs2] =audioread('noise_signal.wav');
[test_signal,Fs3] =audioread('test_signal.wav');
% subplot(2,1,1)
% plot(test_signal)
% ylabel('Amplitude')
% xlabel('Samples')
% title('Test signal before high pass filter')
h_train_signal = highp(train_signal,5000,3000,10,300,Fs1);
h_noise_signal = highp(noise_signal,5000,3000,10,300,Fs2);
h_test_signal = highp(test_signal,5000,3000,10,300,Fs2);
h_test_signal(abs(h_test_signal)<0.04)=0;

dd = find(h_test_signal==0);
for i = 2:length(dd)
    h_test_signal(dd(i)+1)=0;
    h_test_signal(dd(i)-1)=0;
end
% plot(h_test_signal)
% ylabel('Amplitude')
% xlabel('Samples')
% title('Test signal after additional processing')
batch  = 17640;
a = zeros(1,4);
b = zeros(1,4);
count =1;
m=100;
    
    % m = 150;
    M = floor(length(h_test_signal)/batch);
    label = zeros(1,M);
    score = zeros(1,M);
    for j = 1:M
        score(j) = length(find(h_test_signal((j-1)*batch+1:j*batch)));
        if score(j)>m
            label(j) = 1;
        end
    end
    t_label=[0,0,1,0,0,1,0,0,1,0,0,0,1,0,1,0,0,0,0,1,1,1,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1,0,1,1,0,1,1,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0];
%     [a(count),b(count)] = HH(label,t_label);
%     count=count+1;

% m =[50,100,150,200];
% for i = 1:4
%     plot(a,b)
%     plot(a(i),b(i),'r.','Markersize',20)
%     hold on
%     text(a(i),b(i),['T = ',num2str(m(i))]);
%     title('ROC of Amplitude method')
%     xlabel('False discovery rate (FDR)')
%     ylabel('False negative rate (FNR), Miss rate ')
% end
