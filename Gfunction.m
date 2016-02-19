function [ Z ] = Gfunction( Y )
%GFUNCTION Summary of this function goes here
%   Function to calculate the G Function 1/(1 + e^(-Y))
Z = zeros(size(Y));
Z = 1.0 ./ (1.0 + exp(-Y));

end

