%Alex Kelleher
%WDC Final
%Compression


%Import picture
imageValues = imread('DSC_0924.jpg');
uncompressedBytestream = reshape(imageValues, 1, []);

%Convert bytes to bits. Probably a better way to do this
uncompressedBitstream = dec2bin(uncompressedBytestream).';
uncompressedBitstream = uncompressedBitstream(:);
uncompressedBitstream = uncompressedBitstream.';

showImage(imageValues, uncompressedBitstream, 'Original Image')

%Huffman encode
huffmanBitstream = huffman(uncompressedBytestream);

%Lempel-Ziv encode