%Analysis questions 1, 2, 3

%Initialize cell to hold data: each row is different trial
EKG_data = cell(8, 7);

%% Matt Trial 1

%Read in data
data = xlsread('ECG_Data.xlsx', 1);

%Smooth the data to put baseline at zero
a = smooth(data(:, 1), 1001);
data(:, 1) = data(:, 1)-a;
b = smooth(data(:, 2), 1001);
data(:, 2) = data(:, 2)-b;
c = smooth(data(:, 3), 1001);
data(:, 3) = data(:, 3)-c;

%Plot smoothed data
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

%Excluding first lead from this analysis (T waves too high)
%Excluding second lead from analysis (third lead was better)

%Find location of peaks for lead 3
[peaks3, locs3] = findpeaks(data(:, 3), 'MinPeakProminence', 0.4, 'MinPeakDistance', 0.6);
%Find duration of heartbeat in minutes (divide by sampling rate in seconds)
lead_peak_times3 = diff(locs3/500/60);
%Remove outliers (impossible high or low heart rates)
outliers3 = lead_peak_times3 < 0.0083 | lead_peak_times3 > 0.02;
lead_peak_times3(outliers3) = [];
%Find average and standard deviation heartbeat duration (min)
dur_3 = mean(lead_peak_times3);
std_dur_3 = std(lead_peak_times3);

%Find instantaneous heart rates in beats per minute
lead_peak_rates3 = 1./(lead_peak_times3);
%Average instantaneous heart rate and standard deviation
inst_avg3 = mean(lead_peak_rates3);
inst_std3 = std(lead_peak_rates3);

%Shift outliers over to remove from peaks for typical heart rate
outliers3_new = [0, outliers3'];
outliers3_new = logical(outliers3_new);
locs3(outliers3_new) = [];
%Bin in groups of 15000 (30 seconds each bin * 500 samples/sec)
[bins, inds] = histc(locs3, 0:15000:150000);
bins(end) = [];
%Get typical heart rate and uncertainty
typ_heart_rate = sum(bins*2)/length(bins);
std_typ_HR = std(bins*2);

EKG_data{1, 1} = 'Matt Trial 1';
EKG_data{1, 2} = dur_3;
EKG_data{1, 3} = std_dur_3;
EKG_data{1, 4} = typ_heart_rate;
EKG_data{1, 5} = std_typ_HR;
EKG_data{1, 6} = inst_avg3;
EKG_data{1, 7} = inst_std3;

%% Matt Trial 2

%Read in data
data = xlsread('ECG_Data.xlsx', 2);

%Smooth the data to put baseline at zero
a = smooth(data(:, 1), 1001);
data(:, 1) = data(:, 1)-a;
b = smooth(data(:, 2), 1001);
data(:, 2) = data(:, 2)-b;
c = smooth(data(:, 3), 1001);
data(:, 3) = data(:, 3)-c;

%Plot smoothed data
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

%Excluding first lead from this analysis (T waves too high)
%Excluding second lead from analysis (third lead was better)

%Find location of peaks for lead 3
[peaks3, locs3] = findpeaks(data(:, 3), 'MinPeakProminence', 0.6, 'MinPeakDistance', 0.6);
%Find duration of heartbeat in minutes (divide by sampling rate in seconds)
lead_peak_times3 = diff(locs3/500/60);
%Remove outliers (impossible high or low heart rates)
outliers3 = lead_peak_times3 < 0.0083 | lead_peak_times3 > 0.02;
lead_peak_times3(outliers3) = [];
%Find average and standard deviation heartbeat duration (min)
dur_3 = mean(lead_peak_times3);
std_dur_3 = std(lead_peak_times3);

%Find instantaneous heart rates in beats per minute
lead_peak_rates3 = 1./(lead_peak_times3);
%Average instantaneous heart rate and standard deviation
inst_avg3 = mean(lead_peak_rates3);
inst_std3 = std(lead_peak_rates3);

%Shift outliers over to remove from peaks for typical heart rate
outliers3_new = [0, outliers3'];
outliers3_new = logical(outliers3_new);
locs3(outliers3_new) = [];
%Bin in groups of 15000 (30 seconds each bin * 500 samples/sec)
[bins, inds] = histc(locs3, 0:15000:150000);
bins(end) = [];
%Get typical heart rate and uncertainty
typ_heart_rate = sum(bins*2)/length(bins);
std_typ_HR = std(bins*2);

EKG_data{2, 1} = 'Matt Trial 2';
EKG_data{2, 2} = dur_3;
EKG_data{2, 3} = std_dur_3;
EKG_data{2, 4} = typ_heart_rate;
EKG_data{2, 5} = std_typ_HR;
EKG_data{2, 6} = inst_avg3;
EKG_data{2, 7} = inst_std3;

%% Evan Trial 1

%Read in data
data = xlsread('ECG_Data.xlsx', 3);

%Smooth the data to put baseline at zero
a = smooth(data(:, 1), 1001);
data(:, 1) = data(:, 1)-a;
b = smooth(data(:, 2), 1001);
data(:, 2) = data(:, 2)-b;
c = smooth(data(:, 3), 1001);
data(:, 3) = data(:, 3)-c;

%Plot smoothed data
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

%Excluding first lead from this analysis (T waves too high)
%Excluding second lead from analysis (third lead was better)

%Find location of peaks for lead 3
[peaks3, locs3] = findpeaks(data(:, 3), 'MinPeakProminence', 0.3, 'MinPeakDistance', 0.6);
%Find duration of heartbeat in minutes (divide by sampling rate in seconds)
lead_peak_times3 = diff(locs3/500/60);
%Remove outliers (impossible high or low heart rates)
outliers3 = lead_peak_times3 < 0.0083 | lead_peak_times3 > 0.02;
lead_peak_times3(outliers3) = [];
%Find average and standard deviation heartbeat duration (min)
dur_3 = mean(lead_peak_times3);
std_dur_3 = std(lead_peak_times3);

%Find instantaneous heart rates in beats per minute
lead_peak_rates3 = 1./(lead_peak_times3);
%Average instantaneous heart rate and standard deviation
inst_avg3 = mean(lead_peak_rates3);
inst_std3 = std(lead_peak_rates3);

%Shift outliers over to remove from peaks for typical heart rate
outliers3_new = [0, outliers3'];
outliers3_new = logical(outliers3_new);
locs3(outliers3_new) = [];
%Bin in groups of 15000 (30 seconds each bin * 500 samples/sec)
[bins, inds] = histc(locs3, 0:15000:150000);
bins(end) = [];
%Get typical heart rate and uncertainty
typ_heart_rate = sum(bins*2)/length(bins);
std_typ_HR = std(bins*2);

EKG_data{3, 1} = 'Evan Trial 1';
EKG_data{3, 2} = dur_3;
EKG_data{3, 3} = std_dur_3;
EKG_data{3, 4} = typ_heart_rate;
EKG_data{3, 5} = std_typ_HR;
EKG_data{3, 6} = inst_avg3;
EKG_data{3, 7} = inst_std3;

%% Evan Trial 2

%Read in data
data = xlsread('ECG_Data.xlsx', 4);

%Smooth the data to put baseline at zero
a = smooth(data(:, 1), 1001);
data(:, 1) = data(:, 1)-a;
b = smooth(data(:, 2), 1001);
data(:, 2) = data(:, 2)-b;
c = smooth(data(:, 3), 1001);
data(:, 3) = data(:, 3)-c;

%Plot smoothed data
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

%Excluding first lead from this analysis (T waves too high)
%Excluding second lead from analysis (third lead was better)

%Find location of peaks for lead 3
[peaks3, locs3] = findpeaks(data(:, 3), 'MinPeakProminence', 0.35, 'MinPeakDistance', 0.6);
%Find duration of heartbeat in minutes (divide by sampling rate in seconds)
lead_peak_times3 = diff(locs3/500/60);
%Remove outliers (impossible high or low heart rates)
outliers3 = lead_peak_times3 < 0.0083 | lead_peak_times3 > 0.02;
lead_peak_times3(outliers3) = [];
%Find average and standard deviation heartbeat duration (min)
dur_3 = mean(lead_peak_times3);
std_dur_3 = std(lead_peak_times3);

%Find instantaneous heart rates in beats per minute
lead_peak_rates3 = 1./(lead_peak_times3);
%Average instantaneous heart rate and standard deviation
inst_avg3 = mean(lead_peak_rates3);
inst_std3 = std(lead_peak_rates3);

%Shift outliers over to remove from peaks for typical heart rate
outliers3_new = [0, outliers3'];
outliers3_new = logical(outliers3_new);
locs3(outliers3_new) = [];
%Bin in groups of 15000 (30 seconds each bin * 500 samples/sec)
[bins, inds] = histc(locs3, 0:15000:150000);
bins(end) = [];
%Get typical heart rate and uncertainty
typ_heart_rate = sum(bins*2)/length(bins);
std_typ_HR = std(bins*2);

EKG_data{4, 1} = 'Evan Trial 2';
EKG_data{4, 2} = dur_3;
EKG_data{4, 3} = std_dur_3;
EKG_data{4, 4} = typ_heart_rate;
EKG_data{4, 5} = std_typ_HR;
EKG_data{4, 6} = inst_avg3;
EKG_data{4, 7} = inst_std3;

%% Ben Trial 1

%Read in data
data = xlsread('ECG_Data2.xlsx', 1);

%Smooth the data to put baseline at zero
a = smooth(data(:, 1), 1001);
data(:, 1) = data(:, 1)-a;
b = smooth(data(:, 2), 1001);
data(:, 2) = data(:, 2)-b;
c = smooth(data(:, 3), 1001);
data(:, 3) = data(:, 3)-c;

%Plot smoothed data
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

%Excluding first lead from this analysis (T waves too high)
%Excluding second lead from analysis (third lead was better)

%Find location of peaks for lead 3
[peaks3, locs3] = findpeaks(data(:, 3), 'MinPeakProminence', 0.5, 'MinPeakDistance', 0.6);
%Find duration of heartbeat in minutes (divide by sampling rate in seconds)
lead_peak_times3 = diff(locs3/500/60);
%Remove outliers (impossible high or low heart rates)
outliers3 = lead_peak_times3 < 0.0083 | lead_peak_times3 > 0.02;
lead_peak_times3(outliers3) = [];
%Find average and standard deviation heartbeat duration (min)
dur_3 = mean(lead_peak_times3);
std_dur_3 = std(lead_peak_times3);

%Find instantaneous heart rates in beats per minute
lead_peak_rates3 = 1./(lead_peak_times3);
%Average instantaneous heart rate and standard deviation
inst_avg3 = mean(lead_peak_rates3);
inst_std3 = std(lead_peak_rates3);

%Shift outliers over to remove from peaks for typical heart rate
outliers3_new = [0, outliers3'];
outliers3_new = logical(outliers3_new);
locs3(outliers3_new) = [];
%Bin in groups of 15000 (30 seconds each bin * 500 samples/sec)
[bins, inds] = histc(locs3, 0:15000:150000);
bins(end) = [];
%Get typical heart rate and uncertainty
typ_heart_rate = sum(bins*2)/length(bins);
std_typ_HR = std(bins*2);

EKG_data{5, 1} = 'Ben Trial 1';
EKG_data{5, 2} = dur_3;
EKG_data{5, 3} = std_dur_3;
EKG_data{5, 4} = typ_heart_rate;
EKG_data{5, 5} = std_typ_HR;
EKG_data{5, 6} = inst_avg3;
EKG_data{5, 7} = inst_std3;

%% Ben Trial 2

%Read in data
data = xlsread('ECG_Data2.xlsx', 2);

%Smooth the data to put baseline at zero
a = smooth(data(:, 1), 1001);
data(:, 1) = data(:, 1)-a;
b = smooth(data(:, 2), 1001);
data(:, 2) = data(:, 2)-b;
c = smooth(data(:, 3), 1001);
data(:, 3) = data(:, 3)-c;

%Plot smoothed data
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

%Excluding first lead from this analysis (T waves too high)
%Excluding second lead from analysis (third lead was better)

%Find location of peaks for lead 3
[peaks3, locs3] = findpeaks(data(:, 3), 'MinPeakProminence', 1, 'MinPeakDistance', 0.6);
%Find duration of heartbeat in minutes (divide by sampling rate in seconds)
lead_peak_times3 = diff(locs3/500/60);
%Remove outliers (impossible high or low heart rates)
outliers3 = lead_peak_times3 < 0.0083 | lead_peak_times3 > 0.02;
lead_peak_times3(outliers3) = [];
%Find average and standard deviation heartbeat duration (min)
dur_3 = mean(lead_peak_times3);
std_dur_3 = std(lead_peak_times3);

%Find instantaneous heart rates in beats per minute
lead_peak_rates3 = 1./(lead_peak_times3);
%Average instantaneous heart rate and standard deviation
inst_avg3 = mean(lead_peak_rates3);
inst_std3 = std(lead_peak_rates3);

%Shift outliers over to remove from peaks for typical heart rate
outliers3_new = [0, outliers3'];
outliers3_new = logical(outliers3_new);
locs3(outliers3_new) = [];
%Bin in groups of 15000 (30 seconds each bin * 500 samples/sec)
[bins, inds] = histc(locs3, 0:15000:150000);
bins(end) = [];
%Get typical heart rate and uncertainty
typ_heart_rate = sum(bins*2)/length(bins);
std_typ_HR = std(bins*2);

EKG_data{6, 1} = 'Ben Trial 2';
EKG_data{6, 2} = dur_3;
EKG_data{6, 3} = std_dur_3;
EKG_data{6, 4} = typ_heart_rate;
EKG_data{6, 5} = std_typ_HR;
EKG_data{6, 6} = inst_avg3;
EKG_data{6, 7} = inst_std3;

%% Vera Trial 1

%Read in data
data = xlsread('ECG_Data2.xlsx', 3);

%Smooth the data to put baseline at zero
a = smooth(data(:, 1), 1001);
data(:, 1) = data(:, 1)-a;
b = smooth(data(:, 2), 1001);
data(:, 2) = data(:, 2)-b;
c = smooth(data(:, 3), 1001);
data(:, 3) = data(:, 3)-c;

%Plot smoothed data
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

%Excluding first lead from this analysis (T waves too high)
%Excluding second lead from analysis (third lead was better)

%Find location of peaks for lead 3
[peaks3, locs3] = findpeaks(data(:, 3), 'MinPeakProminence', 0.4, 'MinPeakDistance', 0.6);
%Find duration of heartbeat in minutes (divide by sampling rate in seconds)
lead_peak_times3 = diff(locs3/500/60);
%Remove outliers (impossible high or low heart rates)
outliers3 = lead_peak_times3 < 0.0083 | lead_peak_times3 > 0.02;
lead_peak_times3(outliers3) = [];
%Find average and standard deviation heartbeat duration (min)
dur_3 = mean(lead_peak_times3);
std_dur_3 = std(lead_peak_times3);

%Find instantaneous heart rates in beats per minute
lead_peak_rates3 = 1./(lead_peak_times3);
%Average instantaneous heart rate and standard deviation
inst_avg3 = mean(lead_peak_rates3);
inst_std3 = std(lead_peak_rates3);

%Shift outliers over to remove from peaks for typical heart rate
outliers3_new = [0, outliers3'];
outliers3_new = logical(outliers3_new);
locs3(outliers3_new) = [];
%Bin in groups of 15000 (30 seconds each bin * 500 samples/sec)
[bins, inds] = histc(locs3, 0:15000:150000);
bins(end) = [];
%Get typical heart rate and uncertainty
typ_heart_rate = sum(bins*2)/length(bins);
std_typ_HR = std(bins*2);

EKG_data{7, 1} = 'Vera Trial 1';
EKG_data{7, 2} = dur_3;
EKG_data{7, 3} = std_dur_3;
EKG_data{7, 4} = typ_heart_rate;
EKG_data{7, 5} = std_typ_HR;
EKG_data{7, 6} = inst_avg3;
EKG_data{7, 7} = inst_std3;

%% Vera Trial 2

%Read in data
data = xlsread('ECG_Data2.xlsx', 4);

%Smooth the data to put baseline at zero
a = smooth(data(:, 1), 1001);
data(:, 1) = data(:, 1)-a;
b = smooth(data(:, 2), 1001);
data(:, 2) = data(:, 2)-b;
c = smooth(data(:, 3), 1001);
data(:, 3) = data(:, 3)-c;

%Plot smoothed data
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

%Excluding first lead from this analysis (T waves too high)
%Excluding second lead from analysis (third lead was better)

%Find location of peaks for lead 3
[peaks3, locs3] = findpeaks(data(:, 3), 'MinPeakProminence', 0.45, 'MinPeakDistance', 0.6);
%Find duration of heartbeat in minutes (divide by sampling rate in seconds)
lead_peak_times3 = diff(locs3/500/60);
%Remove outliers (impossible high or low heart rates)
outliers3 = lead_peak_times3 < 0.0083 | lead_peak_times3 > 0.02;
lead_peak_times3(outliers3) = [];
%Find average and standard deviation heartbeat duration (min)
dur_3 = mean(lead_peak_times3);
std_dur_3 = std(lead_peak_times3);

%Find instantaneous heart rates in beats per minute
lead_peak_rates3 = 1./(lead_peak_times3);
%Average instantaneous heart rate and standard deviation
inst_avg3 = mean(lead_peak_rates3);
inst_std3 = std(lead_peak_rates3);

%Shift outliers over to remove from peaks for typical heart rate
outliers3_new = [0, outliers3'];
outliers3_new = logical(outliers3_new);
locs3(outliers3_new) = [];
%Bin in groups of 15000 (30 seconds each bin * 500 samples/sec)
[bins, inds] = histc(locs3, 0:15000:150000);
bins(end) = [];
%Get typical heart rate and uncertainty
typ_heart_rate = sum(bins*2)/length(bins);
std_typ_HR = std(bins*2);

EKG_data{8, 1} = 'Vera Trial 2';
EKG_data{8, 2} = dur_3;
EKG_data{8, 3} = std_dur_3;
EKG_data{8, 4} = typ_heart_rate;
EKG_data{8, 5} = std_typ_HR;
EKG_data{8, 6} = inst_avg3;
EKG_data{8, 7} = inst_std3;

save('EKG_Data', 'EKG_data')