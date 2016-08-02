function [ Trans ] = add2Trans( points, Trans, Grid, isGrid )
% add points to an existing transition list
% Input:
%   points      a matrix, each row is a point 
%   Trans       an existing transition list 
%               each row records a transition formated as following
%               [ start point, end point ]
%   Grid        an existing Grid created by the function createGrid()
%   isGrid      a boolean value to indicate whether discretizing 
%               the embedding space
%
% Author:   Zhifei Zhang
% E-mail:   zzhang61@vols.utk.edu
% Date:     July 20th, 2016

if nargin < 3
    error('Not enough input arguments!')
end
if nargin < 4
    isGrid = false;
end

% approximate the points to the nearest grid cell
if isGrid
    gridCenter = Grid.center;
    gridSize = Grid.size;
    [m, n] = size(points);
    if length(gridCenter) ~= n
        gridCenter = repmat(gridCenter(1), 1, n);
    end
    if length(gridSize) ~= n
        gridSize = repmat(gridSize(1), 1, n);
    end
    temp = round((points-repmat(gridCenter,m,1)) ./ ...
        repmat(gridSize,m,1)) .* repmat(gridSize,m,1) + ...
        repmat(gridCenter,m,1);
else
    temp = points;
end

% append the new transitions to the end of the transition list
temp = [ temp(1:end-1, :), temp(2:end, :) ];
Trans = [ Trans ; temp ];



