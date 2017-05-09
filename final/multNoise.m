function [ h ] = multNoise( length )
%multNoise Summary of this function goes here
%   Detailed explanation goes here

pd = makedist('Normal');
h = random(pd, 1, length).'; %Real noise
%realNoise = (realNoise / norm(realNoise)) * norm(noiseless) / 10.0^(0.05*SNR); %Scale to proper SNR
%disp('Adding noise')
%noisy = realNoise.*noiseless;
end

