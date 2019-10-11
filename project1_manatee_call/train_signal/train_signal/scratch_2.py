import numpy as np
import torch
import torch.nn as nn
from torch.autograd import Variable
import torch.utils.data as Data
import matplotlib.pyplot as plt
from sklearn.metrics import accuracy_score
import torch.nn.functional as F
from sklearn.metrics import roc_curve, auc


EPOCH = 50               # train the training data n times, to save time, we just train 1 epoch
BATCH_SIZE = 64
TIME_STEP = 1        # rnn time step / image height
INPUT_SIZE = 17640      # rnn input size / image width
LR = 0.01
train_signal = np.loadtxt('train.txt')
noise_signal = np.loadtxt('noise.txt')
# test_signal = np.loadtxt('test.txt')
test_signal = np.loadtxt('test_modified.txt')


long = 17640
train1 = train_signal[93930:93930+long]
train2 = train_signal[203930:203930+long]
train3 = train_signal[313930:313930+long]
train4 = train_signal[422430:422430+long]
train5 = train_signal[535430:535430+long]
train6 = train_signal[645430:645430+long]
train7 = train_signal[755430:755430+long]
train8 = train_signal[867300:884940]
train9 = train_signal[983300:1000940]
train10 = train_signal[1093300:1110940]
white_noise = train_signal[1:1+long]
classdata = np.hstack([train1,train2,train3,train4,train5,train6,train7,train8,train9,train10,noise_signal,white_noise])

classdata = classdata.reshape(16,long)
classlabel=[1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0]
# for i in range(16):
#     classlabel.append(i)
classlabel = np.array(classlabel).transpose()
X_train = torch.FloatTensor(classdata)
X_train = torch.unsqueeze(X_train,dim=1).type(torch.FloatTensor)
classlabel = torch.from_numpy(classlabel)
classlabel = classlabel.long()
train_dataset = Data.TensorDataset(X_train,classlabel)
train_loader = Data.DataLoader(
    dataset=train_dataset,
    batch_size=BATCH_SIZE,
    shuffle=True,
)
class RNN(nn.Module):
    def __init__(self):
        super(RNN, self).__init__()

        self.rnn = nn.LSTM(         # if use nn.RNN(), it hardly learns
            input_size=INPUT_SIZE,
            hidden_size=64,         # rnn hidden unit
            num_layers=2,           # number of rnn layer
            batch_first=True,       # input & output will has batch size as 1s dimension. e.g. (batch, time_step, input_size)
        )

        self.out = nn.Linear(64, 2)

    def forward(self, x):
        # x shape (batch, time_step, input_size)
        # r_out shape (batch, time_step, output_size)
        # h_n shape (n_layers, batch, hidden_size)
        # h_c shape (n_layers, batch, hidden_size)
        r_out, (h_n, h_c) = self.rnn(x, None)   # None represents zero initial hidden state

        # choose r_out at the last time step
        out = self.out(r_out[:, -1, :])
        return out


rnn = RNN()
print(rnn)

optimizer = torch.optim.Adam(rnn.parameters(), lr=LR)   # optimize all cnn parameters
loss_func = nn.CrossEntropyLoss()                       # the target label is not one-hotted

# training and testing
for epoch in range(EPOCH):
    for step, (b_x, b_y) in enumerate(train_loader):        # gives batch data
        b_x = b_x.view(-1, TIME_STEP, INPUT_SIZE)              # reshape x to (batch, time_step, input_size)

        output = rnn(b_x)                               # rnn output
        loss = loss_func(output, b_y)                   # cross entropy loss
        optimizer.zero_grad()                           # clear gradients for this training step
        loss.backward()                                 # backpropagation, compute gradients
        optimizer.step()                                # apply gradients

test_signal = test_signal.reshape(75, TIME_STEP, INPUT_SIZE)
test_signal = torch.FloatTensor(test_signal)
# test_signal = torch.unsqueeze(test_signal, dim=1).type(torch.FloatTensor)
output=rnn(test_signal)
predict = torch.max(output, 1)[1].data.numpy()
# for i in range(predict.size):
#     if predict[i]>9:
#         predict[i]=0
#     else:
#         predict[i]=1
plt.plot(predict)
plt.show()
# predict2 = []
# for i in range(25):
#     predict2.append((np.sum(predict[i*3+1:(i+1)*3]) > 0))
label1 = [0,0,1,0,0,1,0,0,1,0,0,0,1,0,1,0,0,0,0,1,1,1,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1,0,1,1,0,1,1,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0]
# label2 = [1,1,1,0,1,0,1,1,1,1,0,0,1,1,0,1,1,1,0,0,1,1,0,0,0]
accuracy1 = accuracy_score(predict, label1)
# accuracy2 = accuracy_score(predict2, label2)
print(accuracy1)
# aa = F.softmax(output, dim=1)
# bb = aa.data.numpy()
# y_score = bb[:,1]
# # y_score = []
# # for i in range(len(label1)):
# #     y_score.append(bb[i,1*(label1[i]==1)])
#
# fpr, tpr, thresholds= roc_curve(label1,y_score,pos_label=None,sample_weight=None,drop_intermediate=True)
# plt.plot(fpr,tpr,marker = 'o')
# plt.show()
# AUC = auc(fpr, tpr)
np.savetxt('RNN.txt',predict)
