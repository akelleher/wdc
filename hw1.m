%Alex Kelleher
%WDC HW 1
clear

%Part 1: generate random letters
n = 10000;
letters = char(randi([0,25], n, 1)+'a');

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


