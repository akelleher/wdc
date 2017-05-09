function [ output ] = Hamming4Decode( input )
%HAMMINGDECODE Decode (7,4) Hamming code to binary vector

H = [1 0 0 1 0 1 1;0 1 0 1 1 1 0; 0 0 1 0 1 1 1];

input = input - '0'; %convert string of bits to array
%Switch 1xN vector to 7xceil(N/7)  matrix
neededLength = ceil(numel(input)/7)*7;
bitsNeeded = neededLength-numel(input);
%pad end with zeros to make it multiple of 7
input = padarray(input, [0 bitsNeeded], 0, 'post');
codewords = (reshape(input, 7, [])).';

[numCodewords, ~] = size(codewords);
output = [];
for i = 1:numCodewords;
    syndrome = mod(H*(codewords(i, :).'), 2).';
    
    %If syndrome is zero, no errors- append to output. Otherwise correct
    %error
    [~,indx]=ismember(syndrome,H.','rows');
    if(indx == 0)
        %No errors - append to output
        output = [output codewords(i, 4:7)];
    else
        %Correct errors
        codewords(i, indx) = mod(codewords(i, indx)+1, 2);
        output = [output codewords(i, 4:7)];
    end
end
output = mat2str(output);
output(output==' ') = [];
output = output(2:end-1);
%convert output to string


end

