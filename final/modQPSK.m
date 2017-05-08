function [ output ] = modQPSK( input )
%MODQPSK Summary of this function goes here
%   Detailed explanation goes here
    %pad to proper length - multiple of 2 bits
    if mod(numel(input), 2) ~= 0
        input = [input '0'];
    end
    split = reshape(input, 2, []).';
    output = zeros(size(split,1),1);
    for i = 1:size(split,1)
        if strcmp(split(i,:), '11') %Quadrant 1
            output(i) = 1+1i;
        end
        if strcmp(split(i,:), '01') %Quadrant 2
            output(i) = -1+1i;
        end
        if strcmp(split(i,:), '00') %Quadrant 3
            output(i) = -1-1i;
        end
        if strcmp(split(i,:), '10') %Quadrant 4
            output(i) = 1-1i;
        end
        
    end


end

