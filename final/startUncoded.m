%Alex Kelleher
%WDC Final
%Uncoded transmission

%Import picture
imageValues = imread('small.jpg');
imageBytestream = reshape(imageValues, 1, []);

%Convert bytes to bits. Probably a better way to do this
imageBitstream = dec2bin(imageBytestream).';
imageBitstream = imageBitstream(:);
imageBitstream = imageBitstream.';

showImage(imageValues, imageBitstream, 'Original Image')

disp('Modulating QPSK')
noiselessQPSK = modQPSK(imageBitstream);

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
    errors = nnz(imageBitstream-demod);
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