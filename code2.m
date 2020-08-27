clear 
close all
clc


load dataset2.mat

Y = a;
X = whole_matrix;
%csvwrite('whole.csv',X)


Mdl = fitcecoc(X,Y)

CVMdl = crossval(Mdl)
loss = kfoldLoss(CVMdl)
