function [ ] = showImage( origImage, bitstream )
%SHOWIMAGE Summary of this function goes here
%   Detailed explanation goes here
    bytes = reshape(bitstream, 8, []).';
    decValues =bin2dec(bytes).';
    recoveredImage = uint8(reshape(decValues, size(origImage)));
    image(recoveredImage)
end

