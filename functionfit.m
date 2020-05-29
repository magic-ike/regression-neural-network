clear all;
close all;


%% setup

% training data

n_samp = 100; % number of samples; play around with this

a = -1; % lower bound of training range
b = 1; % upper bound of training range

noise_coeff = 0; % the default was 0.2; 0 means noise has been removed completely

x_train = a + ((b - a) .* rand(n_samp, 1));
y_train = func(x_train) + (noise_coeff .* randn(n_samp, 1));

figure('Name', 'Regression Network', 'NumberTitle', 'off'); hold on;
plot(x_train, y_train, 'mx', 'linewidth', 1);


% underlying function

step = 0.05;
extrap_coeff = 3;

x = (extrap_coeff * a) : step : (extrap_coeff * b);
y = func(x);

plot(x, y, 'k--', 'linewidth', 2);
legend('training data', 'underlying function');


%% neural network creation and training

% play around with these
net_conf = [3]; % simple neural net
%net_conf = [40 30 20 10 5 3]; % complex neural net

net = feedforwardnet(net_conf);

% training algorithms
net.trainFcn = 'trainbr'; % best
%net.trainFcn = 'trainlm'; % pretty bad (default)
%net.trainFcn = 'trainscg'; % worst

net = train(net, x_train.', y_train.');


% network output (with extrapolation)

y_pred = net(x);

plot(x, y_pred, 'g', 'linewidth', 2);
legend('training data', 'underlying function', 'network output');

perf = perform(net, y, y_pred) % network performance

