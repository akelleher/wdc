function [ output ] = huffman( input )
%HUFFMAN Summary of this function goes here
%   Detailed explanation goes here

%Part 1: generate random letters
n = length(input);
letters = input;
%disp(letters.')
frequency = zeros(4,1);
for i = 1:n
    frequency(letters(i)-'a' + 1) = 1 + frequency(letters(i)-'a' + 1);
end
indices = 0:3;
probability = [indices', frequency./n];
%sorted = sortrows(probability, 2)

%assign initial probability to nodes
huffNodes(1:4) = node(char(probability(:,1)+'a'), probability(:,2));
for i = 1:4
    huffNodes(i).letter = char(probability(i,1)+'a');
    huffNodes(i).prob = probability(i,2);
    huffNodes(i).parent = 0;
end

%Build tree
%Iterate through this section until tree is complete
topNodeIndex = 0;
while 1
    
    %If there is only one parentless node left, we're done
    parentlessNodes = 0;
    for i = 1:size(huffNodes, 2)
        if (huffNodes(i).parent == 0)
            parentlessNodes = parentlessNodes + 1;
        end
    end
    if parentlessNodes == 1;
        break
    end
    
    lowestProb = 1;
    lowestProbIndex = 0;
    %find lowest probability node with no parent
    for i = 1:size(huffNodes, 2)
        if (huffNodes(i).parent == 0) && (huffNodes(i).prob < lowestProb)
            lowestProb = huffNodes(i).prob;
            lowestProbIndex = i;
        end
    end
    
    %find second lowest probability node with no parent
    secondLowestProb = 1;
    secondLowestProbIndex = 0;
    for i = 1:size(huffNodes, 2)
        if (i ~= lowestProbIndex) && (huffNodes(i).parent == 0) && (huffNodes(i).prob < secondLowestProb)
            secondLowestProb = huffNodes(i).prob;
            secondLowestProbIndex = i;
        end
    end
    %disp([num2str(secondLowestProb) ' ' num2str(lowestProb)])
    
    %combine two nodes with parent node
    parentNode = node(' ',lowestProb + secondLowestProb );
    parentNode.rightChild = lowestProbIndex;
    parentNode.leftChild = secondLowestProbIndex;
    parentNode.prob = lowestProb + secondLowestProb;
    huffNodes = [huffNodes parentNode];
    huffNodes(lowestProbIndex).parent = size(huffNodes, 2);
    huffNodes(secondLowestProbIndex).parent = size(huffNodes, 2);
    
end

%traverse tree back for symbols
disp('Huffman coding:')
aggregateLength = 0;
codeWords = containers.Map;

for i = 1:4
    codeWord = [];
    childNode = i;
    while 1
        parentNode = huffNodes(childNode).parent;
        if parentNode == 0
            disp([huffNodes(i).letter '  ' num2str(probability(i, 2)) '  '  codeWord])
            codeWords(huffNodes(i).letter) = num2str(codeWord(codeWord~=' ')); %Track letter and codewords, removing spaces
            aggregateLength = aggregateLength + probability(i,2)*size(codeWord, 2);
            break
        else
            if huffNodes(parentNode).leftChild == childNode;
                codeWord = ['0' codeWord];
                %disp('Traverse left branch')
                childNode = parentNode;
            end
            if huffNodes(parentNode).rightChild == childNode;
                codeWord = ['1' codeWord];
                %disp('Traverse right branch')
                childNode = parentNode;
            end
        end
    end
end
disp(['Average Length: ' num2str(aggregateLength)])

output = cell(zeros(1,n)); %Cell array allows for codewords of arbitrary length
%Use map to encode output
for i = 1:n
    output{i} = codeWords(input(i)); %This is slow - could retool to get rid of map
end
    disp('still working...')
    output = [output{:}]; %Concatenate cell array elements to single char array
end

