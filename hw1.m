%Alex Kelleher
%WDC HW 1
clear

%Part 1: generate random letters
n = 10000;
letters = char(randi([0,25], n, 1)+'a');
%disp(letters.')
%Part 2 Huffman:
frequency = zeros(26,1);
for i = 1:n
    frequency(letters(i)-'a' + 1) = 1 + frequency(letters(i)-'a' + 1);
end
indices = 0:25;
probability = [indices', frequency./n];
%sorted = sortrows(probability, 2)

%assign initial probability to nodes
huffNodes(1:26) = node(char(probability(:,1)+'a'), probability(:,2));
for i = 1:26
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
for i = 1:26
    codeWord = [];
    childNode = i;
    while 1
        parentNode = huffNodes(childNode).parent;
        if parentNode == 0
            disp([huffNodes(i).letter '  ' num2str(probability(i, 2)) '  '  num2str(codeWord)])
            aggregateLength = aggregateLength + probability(i,2)*size(codeWord, 2);
            break
        else
            if huffNodes(parentNode).leftChild == childNode;
                codeWord = [0 codeWord];
                %disp('Traverse left branch')
                childNode = parentNode;
            end
            if huffNodes(parentNode).rightChild == childNode;
                codeWord = [1 codeWord];
                %disp('Traverse right branch')
                childNode = parentNode;
            end
        end
    end
end
disp(['Average Length: ' num2str(aggregateLength)])

disp('Lempel-Ziv:')
pointer = 1;
maxDictionaryLength = 255;
wordLength = 1;
letters = [letters; '#']; %Add terminator
dictionary = {};
while 1
    if strcmp(letters(pointer), '#')
        %End of message
        break
    end
        
    %if dictionary is not full, insert new word
    if size(dictionary, 1) < maxDictionaryLength
        while 1
            location = strmatch(letters(pointer:pointer+wordLength-1), dictionary, 'exact');
            %disp(['looking for ' letters(pointer:pointer+wordLength-1)'])
            if any(location) && pointer+wordLength < size(letters, 1)
               %We found it - so look for characters that are one longer
                wordLength = wordLength + 1;
            else
               %append new word to dictionary
               letters(pointer:pointer+wordLength-1);
               dictionary = [dictionary; letters(pointer:pointer+wordLength-1)]; 
               break
            end
    
        end
        
        
            
        
    end    
    
    pointer = pointer + wordLength;
    if pointer > size(letters, 1)
        break
    end
end
disp('Dictionary:')
disp('Note: Codewords should be padded with leading zeros to be constant length of log2 of the dictionary size.')
disp('Codeword    Message')
for i = 1:size(dictionary, 1)
    disp([dec2bin(i) '   ' char(dictionary{i})'])
end
