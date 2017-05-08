%Alex Kelleher
%WDC Final

%Import picture
image = imread('DSC_0924.jpg');
uncompressedBitstream = reshape(image, 1, []);

%Huffman encode
huffmanBitstream = huffman(uncompressedBitstream);