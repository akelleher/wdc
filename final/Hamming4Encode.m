function [ output ] = Hamming4Encode( input )
%HAMMINGENCODE Encode binary vector as (7,4) Hamming code

G = [1 1 0 1 0 0 0; 0 1 1 0 1 0 0; 1 1 1 0 0 1 0; 1 0 1 0 0 0 1];

%Switch 1xN vector to 4xceil(N/4) nibble matrix
neededLength = ceil(numel(input)/4)*4;
bitsNeeded = neededLength-numel(input);
%pad end with zeros to make it multiple of 4
input = strcat(input, num2str(zeros(1, bitsNeeded)));
input(input==' ') = [];
nibbles = (reshape(input, 4, [])).';
nibbles = nibbles-'0'; %convert string of bits to array
[numNibbles, ~] = size(nibbles);
output = [];
for i = 1:numNibbles;
    codeword = mod(nibbles(i, :)*G, 2);
    output = [output codeword];
end
output = num2str(output);
output(output==' ') = [];
end

