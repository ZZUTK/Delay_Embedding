function [ y ] = delayEmbedingND( x, dim, step, w)
% N-Dimensional delay embedding 
% 
% Input:
%   x       input signal, a matrix, each column is a dimension
%   dim     dimension
%   step    delay step 
%   w       slide step
%
% Output:
%   y       point cloud, each row is a point
%
%
% Author:   Zhifei Zhang
% Date:     Jan. 13, 2016
% Email:    zzhang61@vols.utk.edu
%

%% check input
if nargin < 1
    error('Not enough input arguments')
end
if nargin < 2
    dim = 2;
end
if nargin < 3
    step = 1;
end
if nargin < 4
    w = 1;
end
[n, n_dim] = size(x);

%% init output
if n < dim
    error('Too large dimention')
end
y = [];

% %% delay embedding
for i = 1:n_dim
    y = [ y delayEmbeding(x(:,i), dim, step, w)];
end

