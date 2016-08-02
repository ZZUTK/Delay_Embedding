function [ Grid ] = createGrid( gridSize, gridCenter )
% create an N-dimensional grid 
% Input:
%   stepSize    a vector of N elements, each of which denotes the cell 
%               size of the corresponding dimension
%   center      a vector of N elements, denoting the center of grid
%
% Author:   Zhifei Zhang
% E-mail:   zzhang61@vols.utk.edu
% Date:     July 20th, 2016

if nargin < 2
    error('Not enough input arguments!')
end

Grid.size = gridSize;
Grid.center = gridCenter;
Grid.coord = [];
Grid.value  = [];


