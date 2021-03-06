close all;
clear;
clc;

load('icaTest');
load('sounds');

% VaryingArray is the array you want to use to vary a certain parameter. 
% Each entry of the array contains the value of the parameter to use for
% individual tests.
% VaryingArray = [0.01, 0.03, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.5, 0.7, 0.8, 1.0, 1.2, 1.4, 1.6, 1.8];
% VaryingArray = [0.3, 0.5, 0.7, 0.8, 1.0, 1.2, 1.4, 1.6, 1.8];
% VaryingArray = [10^-3, 10^-4, 10^-5, 10^-6, 10^-7, 10^-8, 10^-9, 10^-10];
% VaryingArray = [3, 4, 5, 6, 7, 8];
VaryingArray = [1];

% AccuracyArray is the average accuracy for every test performed.
AccuracyArray = [];

% The sound signal data to use
CompleteSoundData = sounds;
% StartTime and EndTime is the time span of smaples to use. If set to -1
% the entire sample is used.
StartTime = -1;
EndTime = -1;

% SignalsUsed is an array of the signal indexes of the signals used for the test
% If left empty all the signals are used.
% SignalsUsed = [1, 2, 3];
SignalsUsed = [];

% AMatConst is the mixing matrix A that is used for the tests
AMatConst = rand(8, 5) * 0.1;
% AMatConst = A;

% The for loop performs the test.
for indexI = 1:size(VaryingArray,2)
    fprintf(int2str(indexI));
    rng('default'); % This is to ensure that the W matrix is the same everytime for each test.
    
    UMatrix = GetSoundData(CompleteSoundData, SignalsUsed, StartTime, EndTime);

    NumOriginalSignalsN = size(UMatrix, 1); %The number of signals being used as input
    TimeSpanT = size(UMatrix, 2); %The time span of the signals
    
    NumMixedSignalsM = size(AMatConst, 1);

    AMatrix = AMatConst;
    
    LearningRate = 0.25;
    
    RMaxIterations = 250000;
    
    ConvergenceThreshold = 10^(-5);
    
    Converge = 1;
    
    [RecoveredSignals , MixedSignals] = PerformICA(UMatrix, AMatrix, NumMixedSignalsM, LearningRate, RMaxIterations, ConvergenceThreshold, Converge);
    RecoveredSignalsScaled = 2*(RecoveredSignals-min(RecoveredSignals(:))) ./ (max(RecoveredSignals(:)-min(RecoveredSignals(:)))) - 1;
    
    % Plotting the various signals
%     PlotSignal(UMatrix, 'Original');
%     PlotSignal(MixedSignals, 'Mixed');
%     PlotSignal(RecoveredSignals, 'Recovered');
%     PlotSignal(RecoveredSignalsScaled, 'RecoveredScaled');

    Corr_Matrix = CalculateCorrelationMatrix(RecoveredSignals, UMatrix);
    Accuracy = mean(max(abs(Corr_Matrix)));
    AccuracyArray = [AccuracyArray Accuracy];
end

% Corr_Matrix
% Accuracy
% plot(VaryingArray, AccuracyArray);