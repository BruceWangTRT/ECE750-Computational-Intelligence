% a=load('data.txt')
% index=randperm(176)
% TrainInP5=a(index(1:132),2:14)'
% TrainOutP5=a(index(1:132),1)'
% TestInP5=a(index(133:176),2:14)'
% TestOutP5=a(index(133:176),1)'
clc

net1=newff(minmax(TrainInP5),TrainOutP5,[20 20]);
net1.trainParam.lr=0.1;
net1.trainParam.goal=0.01;
net1.trainParam.epochs=1000;

net=train(net1,TrainInP5,TrainOutP5);
y=sim(net,TestInP5);
e1=y-TestOutP5;
sum(sum(round(y)-TestOutP5))%miss-classified number
perf1=mse(e1)
% a=[13.72 1.43 2.5 16.7 108 3.4 3.67 0.19 2.04 6.8 0.89 2.87 1285]
% b=[12.04 4.3 2.38 22 80 2.1 1.75 0.42 1.35 2.6 0.79 2.57 580]
% c=[14.13 4.1 2.74 24.5 96 2.05 0.76 0.56 1.35 9.2 0.61 1.6 560]
% aa=[a;b;c]
% aa=aa'
% sim(net,aa)
% round(sim(net,aa))
