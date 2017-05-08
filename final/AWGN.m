function [ noisy ] = AWGN( noiseless, SNR )
%ADDNOISE Summary of this function goes here
%   Detailed explanation goes here

var_e = 10.^(SNR/10);
pd = makedist('Normal');
realNoise = random(pd, 1, numel(noiseless)).'; %Real noise
imagNoise = random(pd, 1, numel(noiseless)).'; %Imaginary noise
realNoise = (realNoise / norm(realNoise)) * norm(noiseless) / 10.0^(0.05*SNR); %Scale to proper SNR
imagNoise = imagNoise / norm(imagNoise) * norm(noiseless) / 10.0^(0.05*SNR);
%disp('Adding noise')
noisy = noiseless + realNoise + 1i*imagNoise;
end

