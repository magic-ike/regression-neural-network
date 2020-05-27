clear all;
close all;

%% setup

% training data

a = -4 * pi;
b = 4 * pi;
nsamp = 10000;

rx = a + ((b - a) .* rand(nsamp, 1));
ry = func(rx) + (0.2 .* randn(nsamp, 1));

figure('Name', 'Regression Network', 'NumberTitle', 'off'); hold on;
plot(rx, ry, 'mx', 'linewidth', 1);


% underlying function

x = a : pi/8 : b;
xextrap = [(round(2 * a) : pi/8 : a) x (b : pi/8 : round(2 * b))];
y = func(xextrap);

plot(xextrap, y, 'k--', 'linewidth', 2);
legend('training data', 'underlying function');


%% neural network creation and training

netconf = [10]; % simple nnet: 1 layer, 10 neurons
%netconf = [40 30 20 10 5 3]; % complex nnet: 6 layers, varying #s of neurons

% overfitting gets worse the more complex the network is;
% one approach to deal with overtraining is to create an ensemble model
% (average many nnets together)

net = feedforwardnet(netconf);
net = train(net, rx.', ry.');


% network output (with extrapolation)

ypred = net(xextrap);

plot(xextrap, ypred, 'g', 'linewidth', 2);
legend('training data', 'underlying function', 'network output');

