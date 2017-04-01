%Alex Kelleher
%WDC take-home midterm

%Generate random symbols
n = 100;
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
mod = modQPSK(hamming);
toc

disp('Add noise')

disp('Demodulating QPSK')
tic
demod = demodQPSK(mod);
toc