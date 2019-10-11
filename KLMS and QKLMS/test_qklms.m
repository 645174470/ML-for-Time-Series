yn = csvread('SN_m_tot_V2.0.csv', 0, 3, [0,3,3228,3]);
epsu = 1;
h = 0.1;
D = 7;
L = 6;
lr_k = 0.2;
lr = 0.01;
lr_c = 0.1;
%data size
N_tr = 3000; %number of train
N_te = 200; %number of test

T = zeros(N_tr,1);
for ii=1:N_tr
    T(ii) = yn(D+ii);
end


T_te = zeros(N_te,1);
for ii=1:N_te
    T_te(ii) = yn(D+ii+N_tr);
end

X = zeros(L,N_tr);
for k=1:N_tr
    X(:,k) = yn(k:k+L-1)';
end
% Test data
X_te = zeros(L,N_te);
for k=1:N_te
    X_te(:,k) = yn(k+N_tr:k+L-1+N_tr)';
end
%[t,mse_te]=LMS(lr,X,T,X_te,T_te);
% kmeeq = kmee_qip();
% kmeeq.train(N_tr,1,.5,.5,X,T,10);%window size, kernel size, kernel parameter,step size, X, D, 

[tq,neuralsize_q,mse_te_q]= QKLMS(lr_k,h,epsu,X,T,X_te,T_te);

%[tc,neuralsizec,mse_te_c]= KMC(lr_k,h,X,T,X_te,T_te);
%[tk,neuralsize,mse_te_k]= KLMS(lr_k,h,X,T,X_te,T_te);



% for h = [0.001,0.01,0.1,0.5,1]
%     [~,mse] = QKLMS(lr_k,h,epsu,X,T,X_te,T_te);
%     plot(mse)
%     hold on 
%     i=i+1;
% end
% hold off 
% legend('h=0.001','h=0.01','h=0.1','h=0.5','h=1')
% xlabel('iteration')
% ylabel('MSE')
% title('Different Kernel Size for QKLMS')