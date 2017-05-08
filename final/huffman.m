function [ output ] = huffman( inputBytestream )
%HUFFMAN Summary of this function goes here
%   Detailed explanation goes here
n = length(inputBytestream);

%Get frequency of each value
%Have to add in 0 and 255 so histogram is over (0,255) instead of just
%range of data in inputBytestream - then subtract out later
frequency = histcounts([inputBytestream, 0, 255], 'BinMethod', 'integers');
frequency(1) = frequency(1)-1;
frequency(256) = frequency(256)-1;

indices = (0:255)';
probability = [indices'; frequency./n];
%sorted = sortrows(probability, 2)

%assign initial probability to nodes
huffNodes(1:256) = node(uint8(probability(1,:)), probability(2,:));
for i = 1:256
    huffNodes(i).letter = uint8(probability(1,i));
    huffNodes(i).prob = probability(2,i);
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
codeWords = cell(256,1);

for i = 1:256
    codeWord = [];
    childNode = i;
    while 1
        parentNode = huffNodes(childNode).parent;
        if parentNode == 0
            disp([num2str(i-1) '  ' num2str(probability(2,i)) '  '  codeWord])
            codeWords{i} = codeWord; %Track letter and codewords
            aggregateLength = aggregateLength + probability(2,i)*size(codeWord, 2);
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
disp('Encoding data- takes a while...')
%Encode data using codewords
output = blanks(n*ceil(aggregateLength)); % preallocate output matrix
outputIndex = 1;
%output = cell(zeros(1,n)); %Cell array allows for codewords of arbitrary length
%Use map to encode output
tic
for i = 1:n
    appendWord = codeWords(inputBytestream(i)+1);
    wordLength = numel(char(appendWord));
    %disp(['appendWord: ' char(appendWord) '   wordLength: ' num2str(wordLength)])
    if outputIndex + wordLength > numel(output)
        output = [output blanks(1000)];
        disp('Buffer overflow! Expanding buffer')
    end
    output(outputIndex:outputIndex+wordLength-1) = char(appendWord);
    outputIndex = outputIndex + wordLength;
end
toc
output(output==' ') = []; %remove extra buffer values
bitsIn = numel(inputBytestream)*8;
bitsOut = numel(output);
disp([ num2str(bitsIn), ' bits in, ', num2str(bitsOut), ' bits out. Compression ratio: ', num2str(bitsOut/bitsIn)])
end

