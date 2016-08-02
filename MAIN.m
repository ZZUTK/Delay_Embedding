%% Time Series Modeling and Classification through Delay Embedding
% Improvement of the paper:
% Z. Zhang, Y. Song, W. Wang and H. Qi, Derivative Delay Embedding: 
% Online Modeling of Streaming Time Series. CIKM, 2016.
%
% Author:   Zhifei Zhang
% E-mail:   zzhang61@vols.utk.edu
% Date:     July 20th, 2016
%
% This demo is only for research purpose. Please cite the above paper
% if using this code. 

%% add path
clc; clear; close all
addpath('data', 'DE', 'MGM', 'utilities')

%% load data (two datasets are available in this demo)
datasetInd = 2; % <<--- please specify the dataset index, 1 or 2.
dataset = {
    'UCI_CharacterTrajectories' % #1
    'MSR_Action3D'              % #2
    };
disp([ 'Processing the ' dataset{datasetInd}  ' dataset ' ])
switch datasetInd
    case 1
        load(dataset{1})
        data = UCI_CharacterTrajectories.data;
        trueLabel = UCI_CharacterTrajectories.trueLabel;
        categories = UCI_CharacterTrajectories.categories;
        % load setting
        setting_UCI
        % split training and testing sets
        % the first half for training, and the rest for testing 
        trainInd = 1:1433;
        testInd = 1434:length(trueLabel);
    case 2
        load(dataset{2})
        data = MSR_Action3D.data;
        trueLabel = MSR_Action3D.actionLabel;
        categories = MSR_Action3D.categories;
        subjectLabel = MSR_Action3D.subjectLabel;
        % load setting
        setting_MSR
        % split training and testing sets
        % subjects 1,3,5,7 for training, subjects 2,4,6,8 for testing 
        trainInd = find(subjectLabel==1 | subjectLabel==3 | ...
            subjectLabel==5 | subjectLabel==7 | subjectLabel==9);
        testInd = find(subjectLabel==2 | subjectLabel==4 | ...
            subjectLabel==6 | subjectLabel==8 | subjectLabel==10);
    otherwise
        error('Wrong dataset index!') 
end
load defaultColors

%% create grid for each class
classLabels = unique(trueLabel);
n_class = length(classLabels);
n_dimSignal = size(data{1},1);
Trans = cell(n_class, 1);
Grid = cell(n_class, 1);
for i=1:n_class
    Grid{i} = createGrid(gridSize, zeros(1, DE_dim*n_dimSignal));
end

%% training
startTime_train = tic;
for loop = 1:length(trainInd)
    if mod(loop, print_period) == 0
        fprintf('Trained %d / %d\n', loop, length(trainInd))
    end
    % extract data and label
    x = data{trainInd(loop)};
    % low-pass filter
    for i = 1:size(x, 1)
        x(i, :) = lowpassFilter(x(i,:), filter_param);
    end
    % data normalization
    if strfind(dataset{datasetInd}, 'MSR_Action3D')
        x = x - repmat(x(:,1), 1, size(x,2));
    end
    y = trueLabel(trainInd(loop));
    % multi-dimensional delay embedding
    point_cloud = delayEmbedingND(x', DE_dim, DE_step, DE_slid);
    % update transition list
    Trans{y} = add2Trans(point_cloud, Trans{y}, Grid{y}, isGrid);
end
% refine transition list and compute transition probability
for i=1:n_class
    Trans{i} = Trans_Prob(Trans{i});
end 
endTime_train = toc(startTime_train);

%% testing
startTime_test = tic;
dist = zeros(n_class, 1);
prediction = zeros(length(testInd), 1);
for loop = 1:length(testInd)
    if mod(loop, print_period) == 0
        fprintf('tested %d / %d\n', loop, length(testInd))
    end
    % extract data and label
    x = data{testInd(loop)};
    % low-pass filter
    for i = 1:size(x, 1)
        x(i, :) = lowpassFilter(x(i,:), filter_param);
    end
    % data normalization
    if strfind(dataset{datasetInd}, 'MSR_Action3D')
        x = x - repmat(x(:,1), 1, size(x,2));
    end
    y = trueLabel(testInd(loop));
    % multi-dimensional delay embedding
    point_cloud = delayEmbedingND(x', DE_dim, DE_step, DE_slid);
    % model matching
	for i = 1:n_class
        dist(i) = HDist( point_cloud, Trans{i}, Grid{i}, ...
            alpha, beta, isGrid );
	end 
    [~, loc] = min(dist);
    prediction(loop) = loc; 
end
endTime_test = toc(startTime_test);

%% print training and testing time
fprintf('Training time: %.3fsec, %.3fsec per sample\n', ...
    endTime_train, endTime_train/length(trainInd))
fprintf('Testing time: %.3fsec, %.3fsec per sample\n', ...
    endTime_test, endTime_test/length(testInd))

%% plot confusion matrix
[CM, fig_handle] = confusionMatrix(trueLabel(testInd), prediction, categories);
fig = figure(fig_handle);
Accuracy = mean(trueLabel(testInd)==prediction);
fprintf('Accuracy = %.2f%%\n', Accuracy*100);
strAccu = sprintf('Confusion Matrix of the %s dataset, Accuracy %.2f%%', ...
    dataset{datasetInd}, Accuracy*100);
strAccu = strrep(strAccu, '_', '\_');
title(strAccu, 'fontsize', 16);
set(gcf, 'units','normalized','outerposition',[.1 .1 .8 .8])



