%Find the QT time

%Change after comma for different sheets
data = xlsread('ECG_Data.xlsx', 2);

%% analysis 
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
plot(lead2)
figure
plot(-1*lead2)
%}

%fnind the T wave peaks - set just take the width at half prominance
[pksT,locsT,wT,pT] = findpeaks(lead2, 'MinPeakHeight', 0.25,  ...
    'MinPeakWidth', 15, 'MinPeakProminance', 0.1,...
    'Annotate', 'peaks', 'Annotate', 'extent');

%now find the Q wave peaks
findpeaks(-1*lead2, 'MinPeakHeight', 0.2, ...
    'Annotate', 'peaks', 'Annotate', 'extent');


%{
%Find location of peaks
[peaks3, locs3] = findpeaks(data(30000:90000, 3), 'MinPeakProminence', 0.4);
lead_peak_times3 = locs3/500/60;
lead_peak_rates3 = 1./(diff(lead_peak_times3));
avg3 = mean(lead_peak_rates3);
std3 = std(lead_peak_rates3);
%}