%Alex Kelleher
%WDC take-home midterm

%Generate random symbols
n = 1000000;
disp('Generating symbols')
tic
symbols = char(randi([0,3], n, 1)+'a');
toc
%disp(symbols.')

disp('Compressing with Huffman')
tic
huff = huffman(symbols);
toc

disp('Encoding with Hamming')
tic
hamming = huff;
toc

disp('Modulating with QPSK')
tic
q = modQPSK(hamming);
toc

