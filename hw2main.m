close all;
clear;
clc;

load('icaTest');
load('sounds');

% VaryingArray = [0.01, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3, 1.5, 2.0, 3.0];
VaryingArray = [0.01];
AccuracyArray = [];
for indexI = 1:size(VaryingArray,2)
    rng('default');
    CompleteSoundData = U;
    % SignalsUsed = [1, 2, 3, 4, 5];
    SignalsUsed = [];
    UMatrix = GetSoundData(CompleteSoundData, SignalsUsed, -1, -1);

    NumOriginalSignalsN = size(UMatrix, 1); %The number of signals being used as input
    TimeSpanT = size(UMatrix, 2); %The time span of the signals
    NumMixedSignalsM = 3; %The number of mixed signals to generate

    % AMatrix = rand(NumMixedSignalsM, NumOriginalSignalsN); %Generating a random mixing matrix
    % AMatrix = [];
    AMatrix = A;
%     LearningRate = 0.01;
    LearningRate = VaryingArray(1, indexI);
    RMaxIterations = 1000000;
    ConvergenceThreshold = 10^-10;
    [RecoveredSignals , MixedSignals] = PerformICA(UMatrix, AMatrix, NumMixedSignalsM, LearningRate, RMaxIterations, ConvergenceThreshold, 0);
    RecoveredSignalsScaled = 2*(RecoveredSignals-min(RecoveredSignals(:))) ./ (max(RecoveredSignals(:)-min(RecoveredSignals(:)))) - 1;

    PlotSignal(UMatrix, 'Original');
    PlotSignal(MixedSignals, 'Mixed');
    PlotSignal(RecoveredSignals, 'Recovered');
    PlotSignal(RecoveredSignalsScaled, 'RecoveredScaled');

    Corr_Matrix = CalculateCorrelationMatrix(RecoveredSignals, UMatrix);
    Accuracy = mean(max(abs(Corr_Matrix)));
    AccuracyArray = [AccuracyArray Accuracy];
end

plot(VaryingArray, AccuracyArray);