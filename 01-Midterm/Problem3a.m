%data generatation
clc
clear

%Generate data for training
r1=randperm(1001);
s1=sort(r1(1:100));
TrainIn(1,:)=s1/500-1;

r2=randperm(1001);
s2=sort(r2(1:100));
TrainIn(2,:)=s2/500-1;
for i=1:100
    TrainOut(i)=sin(2*pi*TrainIn(1,i))*cos(0.5*pi*TrainIn(2,i));
end

%Generate data for testing
r3=randperm(1001);
s3=sort(r3(1:100));
TestIn(1,:)=s3/500-1;

r4=randperm(1001);
s4=sort(r4(1:100));
TestIn(2,:)=s4/500-1;
for i=1:100
    TestOut(i)=sin(2*pi*TestIn(1,i))*cos(0.5*pi*TestIn(2,i));
end
% xlswrite('Problem3_data.xls',TrainIn,'Sheet1','A1');
% xlswrite('Problem3_data.xls',TrainOut,'Sheet1','A3');
% xlswrite('Problem3_data.xls',TestIn,'Sheet1','A4');
% xlswrite('Problem3_data.xls',TestOut,'Sheet1','A6');

% plot(TrainIn(1,:)')
% hold on
% plot(TrainIn(2,:)','g')
% legend('x1','x2')

