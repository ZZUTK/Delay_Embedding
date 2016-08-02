function [ dist ] = HDist( points, Trans, Grid, alpha, beta, isGrid )
% compute the modified Hausdorff distance between the given trajectory 
% (points) and a learned model (Trans).
% Input:
%   points      a matrix, each row is a point 
%   Trans       an existing transition list 
%               each row records a transition formated as following
%               [ start point, end point ]
%   Grid        an existing Grid created by the function createGrid()
%   alpha, beta parameters of computing distance.
%   isGrid      a boolean value to indicate whether discretizing 
%               the embedding space
%
% Author:   Zhifei Zhang
% E-mail:   zzhang61@vols.utk.edu
% Date:     July 20th, 2016

if nargin < 6
    isGrid = true;
end
if nargin < 5
    beta = 1.0;
end
if nargin < 4
    alpha = 1.0;
end
if nargin < 3
    error('Not enough input arguments!')
end
if isempty(Trans) || isempty(Grid)
    error('Transition list or Grid is empty!')
end

[m, n] = size(points);
[p, ~] = size(Trans);

% approximate the points to the nearest grid cell
if isGrid
    gridCenter = Grid.center;
    gridSize = Grid.size;
    points = round((points-repmat(gridCenter,m,1)) ./ ...
        repmat(gridSize,m,1)) .* repmat(gridSize,m,1) + ...
        repmat(gridCenter,m,1);
end

% direction, location and length of transitions in the embedding space
vec_Trans = Trans(:, n+1:2*n) - Trans(:, 1:n);
loc_Trans = (Trans(:, n+1:2*n) + Trans(:, 1:n)) / 2;
len_Trans = sqrt(sum(vec_Trans.^2, 2));

% direction, location and length of the given trajectory
vec_points = points(2:end, :) - points(1:end-1, :);
loc_points = (points(2:end, :) + points(1:end-1, :)) / 2;
len_points = sqrt(sum(vec_points.^2, 2));

% normalized angle between learned transitions and given trajectory
norm_angle = exp( real(acos(vec_points*vec_Trans' ./ ...
    (len_points*len_Trans') )));
norm_angle(len_points==0, len_Trans==0) = 0;

% normalized lenght difference
norm_length = exp( (repmat(len_points, 1, p) - ...
    repmat(len_Trans', m-1, 1)).^2 ./ (repmat(len_points, 1, p).^2) );
norm_length(isnan(norm_length)) = 0;

% modified Hausdorff distance
norm_distance = zeros(m-1, p);
for i=1:m-1
    if len_points(i)>0
        norm_distance(i, :) = sqrt(sum((repmat(loc_points(i,:), p, 1)...
            - loc_Trans).^2, 2))' / len_points(i);
    else
        norm_distance(i, :) = sqrt(sum((repmat(loc_points(i,:), p, 1)...
            - loc_Trans).^2, 2))';
    end
end
norm_dist = norm_distance + alpha*norm_length + beta*norm_angle;
dist = min(norm_dist, [], 2);
dist = mean( dist(len_points > 0) );


