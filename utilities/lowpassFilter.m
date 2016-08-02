function [ output, tag ] = lowpassFilter( input, param, tol )

if nargin < 3
    tol = 100;
end

output = input;

cnt = 0;
tag = true;
for i=2:length(input)
    if abs(output(i-1)-input(i)) > tol 
        cnt = cnt + 1;
        output(i) = output(i-1);
    else
        output(i) = param*output(i-1) + (1-param)*input(i);
    end
end

if cnt / length(input) > .5
    disp('Bad data!!!')
    waitforbuttonpress
    tag = false;
end



