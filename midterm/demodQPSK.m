function [ output ] = demodQPSK( input )
%DEMODQPSK Summary of this function goes here
%   Detailed explanation goes here
phase = angle(input);
output = char(zeros(2*numel(phase), 2));
for i = 1:length(phase)
   if phase(i) >= pi/2
       output(i,:) = '01';
   elseif phase(i) >= 0
       output(i,1) = '1';
       output(i,2) = '1';
   elseif phase(i) >= -pi/2
       output(i,1) = '1';
       output(i,2) = '0';
   else
       output(i,1) = '0';
       output(i,2) = '0';
   end
end
output = reshape(output', 1, numel(output)); %Make matrix into a vector
output = output(1:numel(input)*2) %remove trailing whitespace
end

