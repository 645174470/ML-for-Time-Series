function  auc = ROC( predict, ground_truth)  
% INPUTS  
%  predict       - 分类器对测试集的分类结果  
%  ground_truth - 测试集的正确标签,这里只考虑二分类，即0和1  
% OUTPUTS  
%  auc            - 返回ROC曲线的曲线下的面积  
  
%初始点为（1.0, 1.0）  
x = 1.0;  
y = 1.0;  
%计算出ground_truth中正样本的数目pos_num和负样本的数目neg_num  
pos_num = sum(ground_truth==1);  
neg_num = sum(ground_truth==0);  
%根据该数目可以计算出沿x轴或者y轴的步长  
x_step = 1.0/neg_num;  
y_step = 1.0/pos_num;  
%首先对predict中的分类器输出值按照从小到大排列  
[predict,index] = sort(predict);  
ground_truth = ground_truth(index);  
%对predict中的每个样本分别判断他们是FP或者是TP  
%遍历ground_truth的元素，  
%若ground_truth[i]=1,则TP减少了1，往y轴方向下降y_step  
%若ground_truth[i]=0,则FP减少了1，往x轴方向下降x_step  
for i=1:length(ground_truth)  
    if ground_truth(i) == 1  
        y = y - y_step;  
    else  
        x = x - x_step;  
    end  
    X(i)=x;  
    Y(i)=y;  
end  
auc = -trapz(X,Y);
%画出图像       
plot(X,Y,'-ro','LineWidth',2,'MarkerSize',3);  
xlabel('FPR');  
ylabel('TPR');  
% title(['ROC M = ',num2str(M),', AUC = ',num2str(auc) ]);  
title(['ROC of RNN prediction for filtered signal,AUC = ',num2str(auc)])
%计算小矩形的面积,返回auc  
            
end  