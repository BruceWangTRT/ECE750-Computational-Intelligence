function mse_calc = mse_test(x, net, p, t)
% 'x' contains the weights and biases vector
% in row vector form as passed to it by the
% genetic algorithm. This must be transposed
% when being set as the weights and biases
% vector for the network.

% Direct encoding: set the weights and biases vector 
% to the one given as input
net= setwb(net, x);

% To evaluate the ouputs based on the given
% weights and biases vector
y = sim(net,p);

% Calculating the mean squared error
mse_calc = sum((y-t).^2)/length(y);

end