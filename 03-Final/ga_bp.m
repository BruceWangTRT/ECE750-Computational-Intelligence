%% Directions
% Main Program£ºga_bp.m
% Fitness Function£ºmse_test.m
%% Clear work space
clear all
clc
warning off 
nntwarn off
%% Declare global variants
global R     % number of inputs
global S3    % number of outputs
global S2    % number of neurons in hidden layer 1
global S1    % number of neurons in hidden layer 1
global S     % length of chromosome
S1=5;
S2=5;
%% Data
inputs = (1:0.1:10);          %x
targets = inputs.*cos(inputs);%y=xcos(x)
R=size(inputs,1);
S3=size(targets,1);
%% BackPropagation Training Network
% Create Network
% Training method: 'traingda'-Gradient descent 
% with adaptive learning rate backpropagation
% 'trainlm'-Levenberg-Marquardt backpropagation
net=newff(inputs,targets,[S1 S2],{'tansig','purelin'},'traingda'); 
% Set parameters
net.trainParam.show=10;
net.trainParam.epochs=2000;
net.trainParam.goal=1.0e-28;
net.trainParam.lr=0.3;
% Train
[net,tr]=train(net,inputs,targets);
% Test
s_bp=sim(net,inputs);                         %output of bp
error_bp=sum((s_bp-targets).^2)/length(s_bp); %Square error of bp
%% Genetic Algorithms Training Network
% Create Network
net1=newff(minmax(inputs),[S1 S2],{'tansig','purelin'},'traingda'); 
% Set parameters & initialize network
net1 = configure(net1, inputs, targets);
S=R*S1+S1*S2+S2*S3+S1+S2+S3;
h=@(x)mse_test(x, net1, inputs, targets);%encoding in mse_test.m
ga_opts = gaoptimset('PopulationSize',80,'Generations',1000,'TolFun', 1e-8,'display','iter');
% Alternative options:
% 'MutationFcn',{@mutationuniform,0.5},
% 'CrossoverFcn',@crossovertwopoint,'CrossoverFcn',@crossoversinglepoint,
%
% Train with GA
x1=ga(h,S,[],[],[],[],[],[],[],[],ga_opts);
% Decoding
net1= setwb(net1, x1);
% Test
s_ga=sim(net1,inputs);                       %output of ga
error_ga=sum((s_ga-targets).^2)/length(s_ga);%Square error of ga
%% Plot
figure;
plot(inputs,targets);
hold on
plot(inputs,s_bp,'-.');
hold on
plot(inputs,s_ga,'.');
legend('xcos(x)','bp','ga');


