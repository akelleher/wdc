%Alex Kelleher
%WDC take-home midterm
clear;
%Generate random symbols
n = 10000;
disp('Generating symbols')
tic
symbols = char(randi([0,3], n, 1)+'a');
toc
%disp(symbols.')

disp('Compressing with Huffman')
tic
huff = huffman(symbols);
toc

disp('Encoding with Hamming not implemented')
hamming = huff;

disp('Modulating with QPSK')
tic
mod = modQPSK(hamming);
toc
errorData = [];
for SNR = -20:20
    %disp('Add noise')
    var_e = 10.^(SNR/10);
    pd = makedist('Normal');
    noiser = random(pd, 1, numel(mod)).'; %Real noise
    noisei = random(pd, 1, numel(mod)).'; %Imaginary noise
    noiser = (noiser / norm(noiser)) * norm(mod) / 10.0^(0.05*SNR); %Scale to proper SNR
    noisei = noisei / norm(noisei) * norm(mod) / 10.0^(0.05*SNR);
    noisy = mod + noiser + 1i*noisei;
    
    
    %disp('Demodulating QPSK')
    %tic
    demod = demodQPSK(noisy);
    %toc

    %check error
    errors = nnz(hamming-demod);
    BER = double(errors)/numel(demod);
    errorData = [errorData; SNR BER];
    disp(['SNR: ', num2str(SNR), '   BER: ', num2str(BER)]);
end

plot(errorData(:,1),errorData(:,2))
xlabel('SNR (dB)')
ylabel('Bit error rate')