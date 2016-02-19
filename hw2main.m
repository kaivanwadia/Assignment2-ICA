close all;
clear;
clc;

load('icaTest');
load('sounds');

% VaryingArray = [0.01, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3, 1.5, 2.0, 3.0];
VaryingArray = [1];
AccuracyArray = [];
CompleteSoundData = sounds;
SignalsUsed = [1, 2, 3];
StartTime = -1;
EndTime = -1;
% SignalsUsed = [];
AMatConst = rand(3, 3);
for indexI = 1:size(VaryingArray,2)
    rng('default');
    UMatrix = GetSoundData(CompleteSoundData, SignalsUsed, StartTime, EndTime);

    NumOriginalSignalsN = size(UMatrix, 1); %The number of signals being used as input
    TimeSpanT = size(UMatrix, 2); %The time span of the signals
    
    NumMixedSignalsM = size(AMatConst, 1);
    % NumMixedSignalsM = 3; %The number of mixed signals to generate

    % AMatrix = rand(NumMixedSignalsM, NumOriginalSignalsN); %Generating a random mixing matrix
    % AMatrix = [];
    AMatrix = AMatConst;
    
    LearningRate = 0.01;
    % LearningRate = VaryingArray(1, indexI);
    
    RMaxIterations = 100000;
    
    ConvergenceThreshold = 10^-10;
    
    Converge = 0;
    
    [RecoveredSignals , MixedSignals] = PerformICA(UMatrix, AMatrix, NumMixedSignalsM, LearningRate, RMaxIterations, ConvergenceThreshold, Converge);
    RecoveredSignalsScaled = 2*(RecoveredSignals-min(RecoveredSignals(:))) ./ (max(RecoveredSignals(:)-min(RecoveredSignals(:)))) - 1;

    PlotSignal(UMatrix, 'Original');
    PlotSignal(MixedSignals, 'Mixed');
    PlotSignal(RecoveredSignals, 'Recovered');
    PlotSignal(RecoveredSignalsScaled, 'RecoveredScaled');

    Corr_Matrix = CalculateCorrelationMatrix(RecoveredSignals, UMatrix);
    Accuracy = mean(max(abs(Corr_Matrix)));
    AccuracyArray = [AccuracyArray Accuracy];
end

AccuracyArray
% plot(VaryingArray, AccuracyArray);