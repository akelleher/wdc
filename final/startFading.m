%Alex Kelleher
%WDC Final
%Hamming code, m = 4

%Import picture
imageValues = imread('medium_small.jpg');
uncompressedBytestream = reshape(imageValues, 1, []);

%Convert bytes to bits. Probably a better way to do this
uncompressedBitstream = dec2bin(uncompressedBytestream).';
uncompressedBitstream = uncompressedBitstream(:);
uncompressedBitstream = uncompressedBitstream.';

showImage(imageValues, uncompressedBitstream, 'Original Image')

%Hamming with m=4
hammingBitstream = Hamming4Encode(uncompressedBitstream);


disp('Modulating QPSK')
noiselessQPSK = modQPSK(hammingBitstream);

errorData = [];
for SNR = -10:10
    %disp('Creating noise')
    h = multNoise(numel(noiselessQPSK));
    
    %Model fading and AWGN
    noisy = AWGN(h.*noiselessQPSK, SNR);
    
    %disp('Demodulating QPSK')
    %h known at receiver
    demod = demodQPSK(noisy./h);
    decode = Hamming4Decode(demod);
    %Display images
    if mod(SNR,5) == 0
        showImage(imageValues, decode, ['Hamming w/ m = 4, SNR = ' num2str(SNR)])
    end
    
    %disp('Error:')
    errors = nnz(uncompressedBitstream-decode);
    BER = double(errors)/numel(decode);
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