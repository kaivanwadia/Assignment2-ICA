function [ CorrMatrix ] = CalculateCorrelationMatrix( RecoveredSignals, OriginalSignals )
%CALCULATECORRELATIONMATRIX Summary of this function goes here
%   Function to calculate the correlation matrix
N = size(OriginalSignals, 1);
CorrMatrix = zeros(N, N);
for i = 1:N
    for j = 1:N
        cor = corrcoef(RecoveredSignals(i,:), OriginalSignals(j,:));
        CorrMatrix(j,i) = cor(2);
    end
end
end

