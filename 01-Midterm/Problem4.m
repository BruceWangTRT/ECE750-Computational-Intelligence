clc

%Generate y(t) with different initial conditions y(0) and y(1)
Y=zeros(1,502);
% Y(1,1)=(rand(1)-0.5)/0.5*1.8;%y(0),-1.23
% Y(1,2)=(rand(1)-0.5)/0.5*1.8;%y(1),-1.69
Y(1,1)=1.6;
Y(1,2)=1.2;
for i=3:502
    Y(1,i)= (0.3-0.6.*exp(-Y(1,i-1).^2)).*Y(1,i-1)-(0.8+0.9.*exp(-Y(1,i-1).^2)).*Y(1,i-2)+0.3.*sin(pi.*Y(1,i-1));
end
% plot(Y(1,:)');

P=Y(1,1:350);
T=Y(1,3:352);
TestIn=Y(1,351:500);
TestOut=Y(1,353:502);

%set up feed forward network,train & test
% 1 layer
% for i=2:8:58 
%     net=newff(P,T,[i]);
%     net=train(net,P,T);
%     yout=sim(net,TestIn);
%     error=yout-TestOut;
%     error=mse(error).^0.5;
%     Re1(ceil(i/8),1)=error;
%     %Re1(ceil(i/8),1)=ceil(i/8);
% end


% 2 layers

% for j=2:8:58
%     for i=2:8:58 
%         net=newff(P,T,[j,i]);
%         net=train(net,P,T);
%         yout=sim(net,TestIn);
%         error=yout-TestOut;
%         error=mse(error).^0.5;
%         Re2(ceil(j/8),ceil(i/8))=error;
%     end
% end


% 3 layers

% for k=2:8:58
%     for j=2:8:58
%         for i=2:8:58 
%             net=newff(P,T,[k,j,i]);
%             net=train(net,P,T);
%             yout=sim(net,TestIn);
%             error=yout-TestOut;
%             error=mse(error).^0.5;
%             Re3(ceil(j/8)+k-2,ceil(i/8))=error;
%         end
%     end
% end

%RBF network
net=newrb(P,T,0.0,1.0,30,10);
yout=sim(net,TestIn);
error=yout-TestOut;
error=mse(error).^0.5