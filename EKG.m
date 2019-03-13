
%Change after comma for different sheets
data = xlsread('ECG_Data.xlsx', 2);

lead_peak_times = [];
lead_peak_rates = zeros(1, 5);

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

%Find location of peaks
[peaks3, locs3] = findpeaks(data(30000:90000, 3), 'MinPeakProminence', 0.4);
lead_peak_times3 = locs3/500/60;
lead_peak_rates3 = 1./(diff(lead_peak_times3));
avg3 = mean(lead_peak_rates3);
std3 = std(lead_peak_rates3);

