classdef node
    %NODE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        letter
        leftChild
        rightChild
        parent
        prob
    
    end
    methods
        function self = node(inLetter, inProb)
            prob = inProb;
            letter = inLetter;
        end
    end
end

