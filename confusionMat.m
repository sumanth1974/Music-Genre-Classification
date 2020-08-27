clc
clear all 
load dataset2.mat

rng(0,'twister'); % For reproducibility
numObs = length(a);
p = randperm(numObs);
whole_matrix = whole_matrix(p,:);
a = a(p);

half = floor(numObs/2);
training = whole_matrix(1:half,:);
trainingGenres = a(1:half);
Mdl = fitcecoc(training,trainingGenres);

sample = whole_matrix(half+1:end,:);
grouphat = predict(Mdl,sample);

group = a(half+1:end);
[C,order] = confusionmat(group,grouphat,'Order',{'blues','classical','country','disco','hiphop','jazz','metal','pop','reggae','rock'})
C_sum = sum(C)
c_sum = sum(C_sum)
trace(C)
accuracy_callsifier = trace(C)/500
confusionchart(C);
%plotconfusion(training,trainingGenres);