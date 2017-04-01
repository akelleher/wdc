%Alex Kelleher
%WDC take-home midterm

%Generate random symbols
n = 1000000;
symbols = char(randi([0,3], n, 1)+'a');
disp(symbols.')
tic
huff = huffman(symbols);
toc