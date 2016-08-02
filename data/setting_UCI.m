%% setting for delay embedding (DE)
% delay step, depend on frequency of the signal
DE_step = 8; 
% delay dimension
DE_dim = 5;
% sliding step
DE_slid = 10; 

%% setting for the grid 
% size of each cell in the grid, depend on amplitude of the signal
gridSize = 2/15; 
% whether use the grid (discretized embedding space)
% higher accuracy without grid, but run slower and cost more memory
isGrid = false; 

%% setting for computing distance
% weight of length difference
alpha = 0.0;
% weight of angle difference
beta = 1.0; 

%% setting for print
% print per 100 samples
print_period = 100;

%% filter parameter
filter_param = 0.5;