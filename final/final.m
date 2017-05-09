%Alex Kelleher
%WDC Final

%Import picture
imageValues = imread('small.jpg');
uncompressedBytestream = reshape(imageValues, 1, []);

%Convert bytes to bits. Probably a better way to do this
uncompressedBitstream = dec2bin(uncompressedBytestream).';
uncompressedBitstream = uncompressedBitstream(:);
uncompressedBitstream = uncompressedBitstream.';

showImage(imageValues, uncompressedBitstream, 'Original Image')

%Huffman encode
%huffmanBitstream = huffman(uncompressedBytestream);

%Lempel-Ziv encode


disp('Modulating QPSK')
noiselessQPSK = modQPSK(uncompressedBitstream);

errorData = [];
for SNR = -10:10
    %disp('Creating noise')
    noisy = AWGN(noiselessQPSK, SNR);
    
    %disp('Demodulating QPSK')
    demod = demodQPSK(noisy);
    
    %Display images
    if mod(SNR,5) == 0
        showImage(imageValues, demod, ['Uncoded Transmission, SNR = ' num2str(SNR)])
    end
    
    %disp('Error:')
    errors = nnz(uncompressedBitstream-demod);
    BER = double(errors)/numel(demod);
    errorData = [errorData; SNR BER];
    
    disp(['SNR: ', num2str(SNR), '   BER: ', num2str(BER)]);
end
figure
plot(errorData(:,1), errorData(:,2))
title('Uncoded Transmission')
xlabel('SNR')
ylabel('Bit error rate')

%Demodulate QPSK
%demoddedQPSK = demodQPSK(noiselessQPSK);