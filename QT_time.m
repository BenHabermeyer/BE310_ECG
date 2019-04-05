%Find the QT time

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

%{
figure
plot(lead1)
figure
plot(lead2)
figure
plot(lead3)
%}

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
clear
close all
clc

%Ben 1
data = xlsread('ECG_Data2.xlsx', 1);

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
    'MinPeakWidth', 13, 'MinPeakProminence', 0.1,...
    'MinPeakDistance', 300, 'WidthReference', 'halfheight',...
    'Annotate', 'peaks', 'Annotate', 'extent');

%now find the Q wave peaks from the inverse of lead 3
[pksQ,locsQ,wQ,pQ] = findpeaks(-1*lead3, 'MinPeakHeight', 0.06, ...
    'MinPeakProminence', 0.25, ...
    'MinPeakWidth', 5, 'MinPeakDistance', 275, 'Annotate', 'peaks', ...
    'Annotate', 'extent');

%remove the last Q
locsQ(end) = [];
locsQ(26:27) = [];
locsQ(28) = [];
locsT(26) = [];
wT(26) = [];
locsT(32) = [];
wT(32) = [];
locsT(40) = [];
wT(40) = [];
locsT(99) = [];
wT(99) = [];
locsT(167) = [];
wT(167) = [];
locsT(334:end) = [];
wT(334:end) = [];
locsQ(334:end) = [];
%pad with zeros
locsQ(length(locsQ) + 1 : length(locsT)) = 0;

peakwidths = locsT + ceil(wT/2) - locsQ;
%convert to milliseconds - we sampled at 500Hz which is 2ms per sample
peakms = peakwidths * 2;

peakms = peakms(peakms < 330);
histogram(peakms)
%find the mean and standard deviation
meanpeak = mean(peakms)
sdpeak = std(peakms)

%% Ben 2
clear
close all
clc

data = xlsread('ECG_Data2.xlsx', 2);

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
    'MinPeakWidth', 15, 'MinPeakProminence', 0.1,...
    'MinPeakDistance', 300, 'WidthReference', 'halfheight',...
    'Annotate', 'peaks', 'Annotate', 'extent');

%now find the Q wave peaks from the inverse of lead 3
[pksQ,locsQ,wQ,pQ] = findpeaks(-1*lead3, 'MinPeakHeight', 0.06, ...
    'MinPeakProminence', 0.25, ...
    'MinPeakWidth', 5, 'MinPeakDistance', 275, 'Annotate', 'peaks', ...
    'Annotate', 'extent');

locsQ(end) = [];

locsQ(length(locsQ) + 1 : length(locsT)) = 0;

peakwidths = locsT + ceil(wT/2) - locsQ;
%convert to milliseconds - we sampled at 500Hz which is 2ms per sample
peakms = peakwidths * 2;

histogram(peakms)
%find the mean and standard deviation
meanpeak = mean(peakms)
sdpeak = std(peakms)
