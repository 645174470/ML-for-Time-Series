load RNN.txt
label=[0,0,1,0,0,1,0,0,1,0,0,0,1,0,1,0,0,0,0,1,1,1,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1,0,1,1,0,1,1,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0];
ROC(RNN, label)

subplot(4,1,1)
stem(t_label)
title('Ground Truth')
subplot(4,1,2)
stem(label)
title('Prediction for Amplitude methid')
subplot(4,1,3)
stem(label2)
title('Prediction for RLS')
subplot(4,1,4)
stem(RNN)
title('Prediction for RNN')