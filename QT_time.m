%Find the QT time
%I tried 2 ways of doing this but I like the second better so ima stick
%with that one 


%% analysis - Starting with MATT Trial 1

%Change after comma for different sheets
data = xlsread('ECG_Data.xlsx', 2);
%Matt trial 1
close all

%{
%Plot 3 leads
figure()
subplot(1, 3, 1)
plot(data(:, 1))
title('Lead 1')
subplot(1, 3, 2)
plot(data(:, 2))
title('Lead 2')
subplot(1, 3, 3)
plot(data(:, 3))
title('Lead 3')
%}

%apply a local smooth ing average to subtract the DC
smooth_level = 1001;
lead1_s = smooth(data(:,1), smooth_level);
lead2_s = smooth(data(:,2), smooth_level);
lead3_s = smooth(data(:,3), smooth_level);

%subtract the dc
lead1 = data(:,1) - lead1_s;
lead2 = data(:,2) - lead2_s;
lead3 = data(:,3) - lead3_s;

%{
close all
figure
plot(lead1)
figure
plot(lead2)
figure
plot(lead3)
%}


%Use lead 2 since the Q and T waves are different sizes which are very
%different
%Method: find peaks twice - the first with a peak magnitude and large peak
%width to find the T wave - then take 1/2 of the t wave to find the later
%index. Then, invert the plot to find the q wave peak, again subtracting
%1/2 the peak width to find

%try inverting 2 to find the q wave peak
%{
figure
plot(lead3)
figure
plot(-1*lead3)
%}

%fnind the T wave peaks - set just take the width at half prominance from
%lead 2
[pksT,locsT,wT,pT] = findpeaks(lead2, 'MinPeakHeight', 0.2,  ...
    'MinPeakWidth', 14, 'MinPeakProminence', 0.1,...
    'MinPeakDistance', 250,...
    'Annotate', 'peaks', 'Annotate', 'extent');

%now find the Q wave peaks from the inverse of lead 3
[pksQ,locsQ,wQ,pQ] = findpeaks(-1*lead3, 'MinPeakHeight', 0.2, ...
    'MinPeakProminence', 0.4, ...
    'MinPeakWidth', 5, 'MinPeakDistance', 200, 'Annotate', 'peaks', ...
    'Annotate', 'extent');

%now take the difference in time between the peak of the T wave + 1/2 its
%width and the peak of the Q wave, then convert to milliseconds. Plot
%distribution, average, and standard deviation

peakwidths = locsT + ceil(wT/2) - locsQ(1:end-1);
%convert to milliseconds - we sampled at 500Hz which is 2ms per sample
peakms = peakwidths * 2;
histogram(peakms)

%remove any outliers (1)
peakms = peakms(peakms > 50);
histogram(peakms)

%find the mean and standard deviation
meanpeak = mean(peakms)
sdpeak = std(peakms)

%% try using dataset 1 instead of dataset 2 to get better T wave - I like
clear
close all
clc

data = xlsread('ECG_Data.xlsx', 2);

%apply a local smooth ing average to subtract the DC
smooth_level = 1001;
lead1_s = smooth(data(:,1), smooth_level);
lead2_s = smooth(data(:,2), smooth_level);
lead3_s = smooth(data(:,3), smooth_level);

%subtract the dc
lead1 = data(:,1) - lead1_s;
lead2 = data(:,2) - lead2_s;
lead3 = data(:,3) - lead3_s;

figure
plot(lead1)
figure
plot(lead2)
figure
plot(lead3)

%fnid the T wave peaks - set just take the width at half height from
%lead 1
[pksT,locsT,wT,pT] = findpeaks(lead1, 'MinPeakHeight', 0.2,  ...
    'MinPeakWidth', 16, 'MinPeakProminence', 0.1,...
    'MinPeakDistance', 250, 'WidthReference', 'halfheight',...
    'Annotate', 'peaks', 'Annotate', 'extent');

%now find the Q wave peaks from the inverse of lead 3
[pksQ,locsQ,wQ,pQ] = findpeaks(-1*lead3, 'MinPeakHeight', 0.2, ...
    'MinPeakProminence', 0.4, ...
    'MinPeakWidth', 5, 'MinPeakDistance', 200, 'Annotate', 'peaks', ...
    'Annotate', 'extent');

%remove errant points
locsQ(86) = [];
locsQ(end) = [];

peakwidths = locsT + ceil(wT/2) - locsQ;
%convert to milliseconds - we sampled at 500Hz which is 2ms per sample
peakms = peakwidths * 2;
histogram(peakms)

%find the mean and standard deviation
meanpeak = mean(peakms)
sdpeak = std(peakms)

%% ok now rinse and repeat with dataset 2 for Matt
clear
close all
clc

data = xlsread('ECG_Data.xlsx', 3);

%apply a local smooth ing average to subtract the DC
smooth_level = 1001;
lead1_s = smooth(data(:,1), smooth_level);
lead2_s = smooth(data(:,2), smooth_level);
lead3_s = smooth(data(:,3), smooth_level);

%subtract the dc
lead1 = data(:,1) - lead1_s;
lead2 = data(:,2) - lead2_s;
lead3 = data(:,3) - lead3_s;

figure
plot(lead1)
figure
plot(lead2)
figure
plot(lead3)

%fnid the T wave peaks - set just take the width at half height from
%lead 1
[pksT,locsT,wT,pT] = findpeaks(lead1, 'MinPeakHeight', 0.2,  ...
    'MinPeakWidth', 16, 'MinPeakProminence', 0.1,...
    'MinPeakDistance', 250, 'WidthReference', 'halfheight',...
    'Annotate', 'peaks', 'Annotate', 'extent');

%now find the Q wave peaks from the inverse of lead 3
[pksQ,locsQ,wQ,pQ] = findpeaks(-1*lead3, 'MinPeakHeight', 0.06, ...
    'MinPeakProminence', 0.3, ...
    'MinPeakWidth', 5, 'MinPeakDistance', 200, 'Annotate', 'peaks', ...
    'Annotate', 'extent');

peakwidths = locsT + ceil(wT/2) - locsQ;
%convert to milliseconds - we sampled at 500Hz which is 2ms per sample
peakms = peakwidths * 2;
histogram(peakms)

%find the mean and standard deviation
meanpeak = mean(peakms)
sdpeak = std(peakms)

%% now do the others yeet
