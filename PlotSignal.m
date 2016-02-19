function [  ] = PlotSignal( Signals , Name )
%PLOTSIGNAL Summary of this function goes here
%   Detailed explanation goes here
NumSignals = size(Signals, 1);
figure;
title('sadsad');
for i = 1:NumSignals
    subplot(NumSignals, 1, i);
    plot((Signals(i,:))', 'color', [0 0.2*i 0]);
    t = strcat(Name, int2str(i));
    title(t);
end
end

