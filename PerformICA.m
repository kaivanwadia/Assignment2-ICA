function [ RecoveredSignals, MixedSignals ] = PerformICA( UMatrix, AMatrix, NumMixedSignalsM, LearningRate, RMaxIterations, ConvergenceThreshold, Converge)
%PERFORMICA Summary of this function goes here
%   Function to perform the ICA. Input is the mixed signals

NumOriginalSignalsN = size(UMatrix, 1); %The number of signals being used as input
TimeSpanT = size(UMatrix, 2); %The time span of the signals
if size(AMatrix, 1) == 0
    AMatrix = rand(NumMixedSignalsM, NumOriginalSignalsN); %Generating a random mixing matrix
end

XMatrix = AMatrix * UMatrix; %Generating the mixed signals matrix
MixedSignals = XMatrix;
WMatrix = 0.0 + (0.1 - 0.0) * rand(NumOriginalSignalsN, NumMixedSignalsM); %Initializing the initial weights matrix W

for i = 1:RMaxIterations
    Y = WMatrix * XMatrix;
    Z = Gfunction(Y);
    I = eye(NumOriginalSignalsN);
    DeltaW = LearningRate * (( I + (1 - 2 * Z) * Y') * WMatrix);
    WMatrix = WMatrix + DeltaW;
    dW = norm(DeltaW, 'fro');
    if dW < ConvergenceThreshold && Converge == 1
        fprintf('Convergence Reached');
        break;
    end
end

RecoveredSignals = Y;
end

