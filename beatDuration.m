function [mean_duration, std_duration] = beatDuration(data,minPeak)

%Search through the peaks using the findpeaks function. Using the
%MinPeakDistance parameter set to ignore any peaks whose distance in the
%time domain are less than 0.6s (this corresponds to a heart rate of 100
%bpm). This should prevent the peaks function from locating any non R-R
%peak distances.

[peaks, locs] = findpeaks(data,'MinPeakDistance',minPeak*500);

%Convert the peak locations to times in seconds
R_peaks = locs/500;

%Calculate the difference in time between each beat and calculate its
%average and standard deviation.
peak_lengths = diff(R_peaks);

mean_duration = mean(peak_lengths);

std_duration = std(peak_lengths);

end