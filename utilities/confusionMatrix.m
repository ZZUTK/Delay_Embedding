function [CM, fig_handle] = confusionMatrix(true_labels, prediction, categories, properties)
% create and plot the confusion matrix
%
% Input:
%   true_labels     a vector of true labels
%   prediction      a vector of predicted labels
%   categories      a cell array of names of each catigory, the order
%                   of categories corresponds to the ascending order 
%                   of the true labels
%   properties      properties of ploting the confusion matrix
%       .colorMap   colormap, default gray. It could be a string (the
%                   name of matlab default colormap, or a n-by-3 matrix
%                   (user defined colormap)
%       .flip       flip up down the colormap, default 1
%       .fontSize   font size of the tick labels, default 16
%       .grid       plot grid lines, default 1      
% 
%
% Output:
%   CM              the confusion matrix
%   fig_handle      the figure handle
%
%
% Author:   Zhifei Zhang
% Date:     Jan. 12, 2016
% E-mail:   zzhang61@vols.utk.edu
%

%% chech input
if nargin < 2
    error('Not enough input arguments!')
end

if length(true_labels) ~= length(prediction)
    error('Dimension mismatching of the inputs.')
end

true_labels = reshape(true_labels,1,[]);
prediction = reshape(prediction,1,[]);

if nargin < 3 || length(unique(true_labels)) ~= length(categories)
    labels = unique(true_labels);
    n = length(labels);
    categories = cell(n, 1);
    for i = 1:n
        categories{i} = num2str(labels(i));
    end
end

if nargin < 4
    properties.colorMap = 'gray';
    properties.flip = 1;
    properties.fontSize = 16;
    properties.grid = 1;
end

if ~isfield(properties, 'colorMap')
    properties.colorMap = 'gray';
end

if ~isfield(properties, 'flip')
    properties.flip = 1;
end

if ~isfield(properties, 'fontSize')
    properties.fontSize = 16;
end

if ~isfield(properties, 'grid')
    properties.grid = 1;
end
%% create confusion matrix
num_categories = length(categories);
[CM, GORDER] = confusionmat(true_labels, prediction);
% convert to percentage
CM = CM ./ repmat(sum(CM,2), 1, num_categories);
% check group order
labels = unique(true_labels);
if sum(abs(labels-GORDER'))
    disp('Rearrange group order.')
    temp = categories;
    for i = 1:num_categories
        categories{i} = temp{labels==GORDER(i)};
    end
end

%% plot confusion matrix
fig_handle = figure; 
imagesc(CM, [0 1]); 

%% select color map
default_colorMaps = {
    'parula'
    'jet'	
    'hsv'	
    'hot'	
    'cool'	  
    'spring'	
    'summer'	
    'autumn'	
    'winter'	
    'gray'	
    'bone'	
    'copper'	
    'pink'	
    'lines'	
    'colorcube'	
    'prism'	
    'flag'	
    'white'
    };

if ischar(properties.colorMap)
    properties.colorMap = strtrim(properties.colorMap);
    ind = cellfun(@(x) strcmp(x, properties.colorMap), default_colorMaps);
    if ind == 0
        error('Not an available colorMap!')
    end
    colormap(default_colorMaps{ind});
else
    colormap(properties.colorMap);
end

if properties.flip
    colormap(flipud(colormap));
end

%% text
textStrings = num2str(CM(:),'%0.2f'); 
textStrings = strtrim(cellstr(textStrings)); 
% remove zero strings
textStrings(strcmp(textStrings(:), '0.00')) = {'   '};
% create x and y coordinates for the strings
[x,y] = meshgrid(1:num_categories);   
% plot the strings
hStrings = text(x(:), y(:), textStrings(:), ...
    'HorizontalAlignment', 'center', ...
    'fontsize', properties.fontSize, ...
    'fontweight', 'bold');
% Get the middle value of the color range
midValue = mean(get(gca, 'CLim'));  
% choose white or black for the text color of the strings 
% so they can be easily seen over the background color
C = mean(colormap, 2);
if C(1) < C(end)
    textColors = repmat(CM(:) < midValue, 1, 3);
else
    textColors = repmat(CM(:) > midValue, 1, 3);
end
% change the text colors
set(hStrings, {'Color'}, num2cell(textColors,2));  
% axis labels
axis_handle = get(fig_handle, 'CurrentAxes');
set(axis_handle, ...
    'XTick', 1:num_categories, ...
    'XTickLabel', categories, ...
    'XTickLabelRotation', 45, ...
    'YTick', 1:num_categories, ...
    'YTickLabel', categories, ...
    'TickLength',[0 0], ...
    'fontsize', properties.fontSize)
if properties.grid
    grid on
    set(gca, 'gridlinestyle', '-')
end

