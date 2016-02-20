function [  ] = PlotSignal( Signals , Name )
%PLOTSIGNAL Summary of this function goes here
%   Function to plot a number of sound signals in a matrix.
% The Name is the prefix to give each signal to be plotted.
NumSignals = size(Signals, 1);
figure;
title('sadsad');
for i = 1:NumSignals
    subplot(NumSignals, 1, i);
    plot((Signals(i,:))', 'color', [0 0.6 0]);
    t = strcat(Name, int2str(i));
    title(t);
end
end

