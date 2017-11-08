clc
clear

data=xlsread('Problem3_data.xls');
train=data(1:3,:);
test=data(4:6,:);
SamNum=100;      %Train data 
TestSamNum=100;   %Test data
Overlap=3;

%Generate Input output
%Train
SamIn=train(1:2,1:100);
SamOut=train(3,1:100);
%Test
TestSamIn=test(1:2,1:100);
TestSamOut=test(3,1:100);


InDim=2;  %input dimension
ClusterNum=10;  %Number of nodes


%Initialize
Centers=SamIn(:,1:ClusterNum);


%K-mean method
while 1
    NumberInClusters=zeros(ClusterNum,1);
    IndexInClusters=zeros(ClusterNum,SamNum);


    for i=1:SamNum
        AllDistance=dist(Centers',SamIn(:,i));
        [MinDist,Pos]=min(AllDistance);
        NumberInClusters(Pos)=NumberInClusters(Pos)+1;
        IndexInClusters(Pos,NumberInClusters(Pos))=i;
    end
    
    OldCenters=Centers;
    
   
    for i=1:ClusterNum
        if NumberInClusters(i)>0
            Index=IndexInClusters(i,1:NumberInClusters(i));
            Centers(:,i)=mean(SamIn(:,Index)')';
        else
            NewCenter=ceil(SamNum*rand(1));
            Centers(:,i)=SamIn(:,NewCenter);
        end
        
    end
    
    EqualNum=sum(sum(Centers==OldCenters));
    if EqualNum==InDim*ClusterNum
        break
    end
end
    
% get spreads
AllDistances=dist(Centers',Centers);
Maximun=max(max(AllDistances));
for i=1:ClusterNum
   AllDistances(i,i)=Maximun+1;
end
Spreads=Overlap*min(AllDistances)';

tic

%RBF
for i=1:SamNum
    for j=1:ClusterNum
        Distance=dist(SamIn(:,i)',Centers(:,j));
        HiddenUnitOut(j,i)=gaussmf(Distance,[Spreads(j) 0]);
    end
end
W2=SamOut*pinv(HiddenUnitOut);


for i=1:TestSamNum
    for j=1:ClusterNum
        TestDistance=dist(TestSamIn(:,i)',Centers(:,j));
        TestHiddenUnitOut(j,i)=gaussmf(TestDistance,[Spreads(j) 0]);
    end
end
TestNNOut=W2*TestHiddenUnitOut;

TestError=TestNNOut-TestSamOut;
MeanSquaredError=mse(TestError)

toc

plot(TestNNOut,'-r*');
hold on
plot(TestSamOut,':bo');
legend('Training Data','Original Data')

clear

