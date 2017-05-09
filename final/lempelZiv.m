function [ output_args ] = lempelZiv( inputBitstream )
%LEMPELZIV Summary of this function goes here
%   Detailed explanation goes here
letters = inputBitstream;
disp('Lempel-Ziv:')
pointer = 1;
maxDictionaryLength = 255;
wordLength = 1;
letters = [letters, NaN]; %Add terminator
dictionary = {};
while 1
    if ISNAN(letters(pointer))
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
end

