function [count,mse_te]=AUTO_LMS(lr,X,T,X_te,T_te,r,thd)
N_tr = size(X,2);
TD = size(X,1);
N_te = size(X_te,2);
%lr = .01;%learning rate
w1 = zeros(1,6);
e_l = ones(N_tr,1);
count = 1;
% k = 1000;
for n=r-25:r-1
%     if n <r+change
%         y(n) = w1*X(:,n);
%     else
%         %         if mse_tr(n-1)>mse_tr(n-2)
%         %             if exp((mse_tr(n-2)-mse_tr(n-1))/k)<rand(1)
%         %                 y(n-1) = y(n-2);
%         %             else
%         %                 k= 0.5*k;
%         %             end
%         %         end
%         %         if mse_tr(n-1)>mse_tr(n-2)
%         %             y(n-1) = y(n-2);
%         %         end
%         if mse_tr(n-1)<mse_tr(n-2)
%             %y(n-1) = 0;
%             %             y(n-1) = y(n-2);
%             a = 1-exp(-0.1*(count-1));
%             count = count+1;
%            
%             y(n) = (1-a)*w1*X(:,n)+a*y(n-1);
%         else
%             y(n) = w1*X(:,n);
%         end
% 
%         
%     end
    y(n) = w1*X_te(:,n);
    e_l(n) = T_te(n) - y(n);
    w1 = w1 + lr*e_l(n)*X_te(:,n)';
%     e_l(n) = T(n) - y(n);
%     w1 = w1 + lr*e_l(n)*X(:,n)';
    %testing
%     mse_tr(n) = e_l(n)^2/(X(:,n)'*X(:,n));
%     if mse(n)>thd 
%         break
%     end
end
y_te = w1*X_te(:,r);
mse_te(r) = T_te(r)^2/(X_te(:,r)'*X_te(:,r));
count =1;
for j =r:3200
    err(j) = T_te(j)-y_te;
    mse_te(j) = err(j)^2/(X_te(:,j)'*X_te(:,j));
    %     y_te(j) = w1*X_te(:,j);
    if j-r >1
        if mse_te(j)<mse_te(j-1)
            a = 1-exp(-0.1*(count-1));
            count = count+1;
            y_te = (1-a)*T_te(j)+a*y_te;
        end
    end
%     a = 1-exp(-0.2*(count-1));
%     y_te(j) = (1-a)*w1*X(:,j)+a*y_te(j-1);

    if mse_te(j)>thd
        break
    end
end
count = j-r+1;
% mse_te = err*err'/(T_te'*T_te);
end

%==========plot and test===================
% figure
% plot(mse_te,'b-','LineWidth',2)
% hold on
% plot(mse_te_k,'r--','LineWidth',2)
% set(gca, 'FontSize', 14);
% set(gca, 'FontName', 'Arial');
% 
% legend('LMS','KLMS')
% xlabel('iteration')
% ylabel('testing MSE')
