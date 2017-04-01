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
            self.prob = inProb;
            self.letter = inLetter;
            self.parent = 0;
            self.leftChild = 0;
            self.rightChild = 0;
        end
    end
end

