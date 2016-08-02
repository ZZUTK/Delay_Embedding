%% setting for delay embedding (DE)
% delay step, depend on frequency of the signal
DE_step = 3; 
% delay dimension
DE_dim = 2;
% sliding step
DE_slid = 2; 

%% setting for the grid 
% size of each cell in the grid, depend on amplitude of the signal
gridSize = 2/20; 
% whether use the grid (discretized embedding space)
% higher accuracy without grid, but run slower and cost more memory
isGrid = false; 

%% setting for computing distance
% weight of length difference
alpha = 2;
% weight of angle difference
beta = 3; 

%% setting for print
% print per 50 samples
print_period = 50;

%% filter parameter
filter_param = 0.5;

