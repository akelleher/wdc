%Alex Kelleher
%WDC HW 1

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
sorted = sortrows(probability, 2)

%assign probability to nodes
huffNodes(1:26) = node(char(sorted(:,1)+'a'), sorted(:,2));
for i = 1:26
    huffNodes(i).letter = char(sorted(i,1)+'a');
    huffNodes(i).prob = sorted(i,2);
end


%while
end
%merge bottom nodes


%recalculate probability


end

%traverse tree back for symbols
