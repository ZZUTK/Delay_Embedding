function [ y ] = delayEmbeding( x, dim, step, w)
% delay embedding 
% 
% Input:
%   x       input signal, a vector
%   dim     dimension
%   step    delay step 
%   w       slide step
%
% Output:
%   y       point cloud, each row is a point
%
%
% Author:   Zhifei Zhang
% Date:     Feb. 6, 2015
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

%% init output
n = length(x);
if n < dim
    error('Too large dimention')
end
y = nan(round((n-step*(dim-1))/w),dim);

%% delay embedding
ind = 1:w:n;
for i=1:size(y,1)
    temp = x(ind(i):step:ind(i)+step*(dim-1)); 
   y(i,:) = reshape(temp, 1, length(temp));
end

