function [ FinalSounds ] = GetSoundData( CompleteSoundData, SoundSources, StartTime, EndTime )
%GETSOUNDDATA Summary of this function goes here
%   Given the complete sound data return only the signals mentioned in the
%   SoundSources Array and the time between StartTime and EndTime.

SelectedSounds = CompleteSoundData;
if size(SoundSources, 2) ~= 0
    SelectedSounds = CompleteSoundData(SoundSources, :);
end

if StartTime == -1 || EndTime == -1
    FinalSounds = SelectedSounds;
else
    FinalSounds = SelectedSounds(:, StartTime:EndTime);
end
end

