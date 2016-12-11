clc; clear; close all;
maxIter = 20;
% network structure
layersizes = [25 30];
layertypes = {'logistic', 'logistic', 'softmax'};

% load datasets.
indata = loadMNISTImages('raw_data/train-images.idx3-ubyte');
y = loadMNISTLabels('raw_data/train-labels.idx1-ubyte');
y(y==0) = 10;
intest = loadMNISTImages('raw_data/t10k-images.idx3-ubyte');
yt = loadMNISTLabels('raw_data/t10k-labels.idx1-ubyte');
yt(yt==0) = 10;

outdata = zeros(10,size(indata,2));
for i = 1:10
	outdata(i,:) = (y == i);
end

outtest = zeros(10,size(intest,2));
for i = 1:10
	outtest(i,:) = (yt == i);
end

[llrecord, errrecord] = lbfgs_train(maxIter, layersizes, layertypes, indata, outdata, intest, outtest);

fig = figure('color', [1 1 1]);
subplot(1,2,1);
plot(0:maxIter, -llrecord(:,1),'rx-');
hold on;
plot(0:maxIter, -llrecord(:,2),'bx-');
ylabel('cross-entropy loss');
xlabel('iteration');

subplot(1,2,2);
plot(0:maxIter, errrecord(:,1),'rx-');
hold on;
plot(0:maxIter, errrecord(:,2),'bx-');
ylim([0 1]);
ylabel('error rate');
xlabel('iteration');
set(fig, 'Position', [10, 10, 1000, 400]);
