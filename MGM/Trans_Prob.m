function [ Trans ] = Trans_Prob( Trans )
% combine the same transitions in the transition list
% and compute transition probability
% Input:
%   Trans       an existing transition list 
%               each row records a transition formated as following
%               [ start point, end point ]
%
% Author:   Zhifei Zhang
% E-mail:   zzhang61@vols.utk.edu
% Date:     July 20th, 2016

% find unique transitions
[C, ~, ic] = unique(Trans, 'rows');
l = size(C, 1);

% compute probabilities of unique transitions
counts = hist(ic, 1:l);
prob = counts' / sum(counts);

% format the new transition list 
% [start point, end point, transition probability]
Trans = [C prob];
