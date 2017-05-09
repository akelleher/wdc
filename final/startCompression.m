%Alex Kelleher
%WDC Final
%Compression


%Import picture
imageValues = imread('small.jpg');
uncompressedBytestream = reshape(imageValues, 1, []);

%Convert bytes to bits. Probably a better way to do this
uncompressedBitstream = dec2bin(uncompressedBytestream).';
uncompressedBitstream = uncompressedBitstream(:);
uncompressedBitstream = uncompressedBitstream.';

%Huffman encode
huffmanBitstream = huffman(uncompressedBytestream);

%Lempel-Ziv encode
%lempelZiv(uncompressedBytestream)