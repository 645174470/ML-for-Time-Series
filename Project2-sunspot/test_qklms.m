clear all;
data = csvread('SN_m_tot_V2.0.csv', 0, 3, [0,3,3228,3]);
meand = min(data);
std = std(data);
yn = (data-meand)./std; 
epsu = 1.7;
h = 0.1;
D = 1;
L = 6;
lr_k = 0.05;
lr = 0.02;
%data size
N_tr = 1600; %number of train
N_te = 1600; %number of test
X = zeros(L,N_tr);
XR = zeros(L,3200);
TR = zeros(3200,1);
for i =1:3200
    XR(:,i) = yn(i:i+L-1)';
    TR(i) = yn(i+L-1+D);
end
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
% [e1,mse_te_lms]=LMS(lr,X,T,X_te,T_te);
% [e2,mse_te_lmcc]=LMCC(lr,X,T,X_te,T_te,h);
% [e3,mse_te_q,y_te]= QKLMS(lr_k,h,epsu,X,T,X_te,T_te);
% [e4,mse,y_te_kmcc]= QKMCC(lr_k,h,epsu,X,T,X_te,T_te);
% plot(mse_te_lms)
% hold on
% plot(mse_te_lmcc)
% hold on
% plot(mse_te_q)
% hold on
% plot(mse)
% hold on
% mean(mse_te_lms)
% mean(mse_te_lmcc)
% mean(mse_te_q)
% mean(mse)
% plot(e1)
% hold on 
% plot(e2)
% hold on 
% plot(e3)
% hold on
% plot(e4)
% hold off
% legend('LMS','LMCC','QKLMS','QKMCC')
% ylabel('Normalized error power')
% xlabel('iteration')
% title('Performance for different system')
thd = 0.3;
change = 10;
% r = 1000;
% [count1,mse1]=AUTO_LMS(lr,XR,TR,X_te,T_te,change,r,thd);
% [count2,mse2] = RLMS(lr,X,T,r,thd);
r = randi([1600 3200],50,1);
for i = 1:50
    [e1(i),mse_te_lms]=AUTO_LMS(lr,X,T,XR,TR,r(i),thd);
    [e2(i)]=AUTO_LMCC(lr,X,T,XR,TR,h,r(i),thd);
    [e3(i)] = AUTO_QKLMS(lr_k,h,epsu,X,T,XR,TR,r(i),thd);
    [e4(i)]= AUTO_QKMCC(lr_k,h,epsu,X,T,XR,TR,r(i),thd);
    [e5(i)] = RLMS(lr,X,T,XR,TR,r(i),thd);
    [e6(i)]= RLMCC(lr,X,T,XR,TR,h,r(i),thd);
    [e7(i)] = RQKLMS(lr_k,h,epsu,X,T,XR,TR,r(i),thd);
    [e8(i)]= RQKMCC(lr_k,h,epsu,X,T,XR,TR,r(i),thd);
 end
mean(e1)
mean(e2)
mean(e3)
mean(e4)
mean(e5)
mean(e6)
mean(e7)
mean(e8)
% mse = zeros(4,N_tr);
% neuralsize = zeros(4,N_tr);
% t=zeros(4,1);
% epsu = [1,1.5,2,2.5];
% for i = 1:4
%     [t(i),neuralsize(i,:),mse(i,:),y_te(i,:)]= QKMCC(lr_k,h,epsu(i),X,T,X_te,T_te);
%     plot(mse(i,:))
%     hold on 
% end
% hold off 
% legend(['quantized size = 1 mean MSE = ',num2str(mean(mse(1,:)))],...
%     ['quantized size = 1.5 mean MSE = ',num2str(mean(mse(2,:)))],...
%     ['quantized size = 2 mean MSE = ',num2str(mean(mse(3,:)))],...
%     ['quantized size = 2.5 mean MSE = ',num2str(mean(mse(4,:)))])
% xlabel('iteration')
% ylabel('MSE')
% title('Different Quantized Size for QKMCC')
% figure(2)
% for i = 1:4
%     plot(neuralsize(i,:))
%     hold on
% end
% hold off 
% legend(['quantized size = 1 time = ',num2str(t(1))],['quantized size = 1.5 time = ',num2str(t(2))],...
%     ['quantized size = 2 time = ',num2str(t(3))],['quantized size = 2.5 time = ',num2str(t(4))])
% xlabel('iteration')
% ylabel('neuralsize')
% title('Neural Size for Different Quantized Size')
%hist1 = [e1;e2;e3';e4']';
% hist1 = zeros(4,6);
% hist1(1,:) = errhist(e1);
% hist1(2,:) = errhist(e2);
% hist1(3,:) = errhist(e3);
% hist1(4,:) = errhist(e4);
% bar(hist1')
% legend('LMS','LMCC','QKLMS','QKMCC')
% ylabel('number')
% xlabel('Range(Absolute Value)')
% xticklabels({'0~0.1','0.1~0.2','0.2~0.3','0.3~0.4','0.4~0.5','>0.5'})