clear all;
yn = csvread('SN_m_tot_V2.0.csv', 0, 3, [0,3,3228,3]);
%epsu = 1.7;
h = 0.1;
hmcc = 0.00001;
D = 1;
L = 6;
%lr_k = 0.1;
lr = 0.000001;
%data size
N_tr = 1500; %number of train
N_te = 1700; %number of test
X = zeros(L,N_tr);
T = zeros(N_tr,1);
for k=1:N_tr
    X(:,k) = yn(k:k+L-1)';
    T(k) = yn(k+L-1+D);
end
% Test data
X_te = zeros(L,N_te);
T_te = zeros(N_te,1);
for k=1:N_te
    X_te(:,k) = yn(k+N_tr:k+L-1+N_tr)';
    T_te(k) = yn(k+L-1+N_tr+D);
end
% [err,mse_te1] = LMS(lr,X,T,X_te,T_te);
% [err,mse_te2]=LMCC(lr,X,T,X_te,T_te,hmcc);
% mean(mse_te2)
epsu = 150;
lr_k = 0.02;
hqmcc=0.00001;
mse = zeros(4,N_tr);
neuralsize = zeros(4,N_tr);
t=zeros(4,1);
h_k=0.00002;
[err,mse_te1] = LMS(lr,X,T,X_te,T_te);
[err,mse_te2]=LMCC(lr,X,T,X_te,T_te,hmcc);
[t,neuralsize,mse3,y_te]= QKLMS(lr_k,h_k,epsu,X,T,X_te,T_te);
[err,neuralsize,mse_te_k,y_te]= QKMCC(lr_k,hqmcc,epsu,X,T,X_te,T_te);
% for i = 1:4
%     [err,neuralsize,mse(i,:),y_te]= QKMCC(lr_k,hqmcc(i),epsu,X,T,X_te,T_te);
%     plot(mse(i,:))
%     hold on 
% end
% hold off 
% legend(['MCC Kernel Size = 0.05 mean MSE = ',num2str(mean(mse(1,:)))],...
%     ['MCC Kernel Size = 0.1 mean MSE = ',num2str(mean(mse(2,:)))],...
%     ['MCC Kernel Size = 0.3 mean MSE = ',num2str(mean(mse(3,:)))],...
%     ['MCC Kernel Size = 0.5 mean MSE = ',num2str(mean(mse(4,:)))])
% xlabel('iteration')
% ylabel('MSE')
% title('Different Kernel Size for QKMCC')
% figure(2)
% for i = 1:4
%     plot(neuralsize(i,:))
%     hold on
% end
% hold off 
% legend(['quantized size = 0.5 time = ',num2str(t(1))],['quantized size = 0.7 time = ',num2str(t(2))],...
%     ['quantized size = 1 time = ',num2str(t(3))],['quantized size = 1.5 time = ',num2str(t(4))])
% xlabel('iteration')
% ylabel('neuralsize')
% title('Learning Curve for Different Quantized Size')