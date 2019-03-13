%Frequency Domain Analysis Question 5

%Loading Data (change number after comma for different sheet)
%Using Ben's Trial 2
data = xlsread('ECG_Data2.xlsx', 2);

lead_peak_times = [];
lead_peak_rates = zeros(1, 5);

%average for each lead
smooth_level = 1001;
lead1_s = smooth(data(:,1),smooth_level);
lead2_s = smooth(data(:,2),smooth_level);
lead3_s = smooth(data(:,3),smooth_level);

%subtract that average for each lead
lead1noDC = data(:,1) - lead1_s;
lead2noDC = data(:,2) - lead2_s;
lead3noDC = data(:,3) - lead3_s;

length1 = length(lead1noDC);
length2 = length(lead2noDC);
length3 = length(lead3noDC);

lead1FFT = fft(lead1noDC,length1);
lead2FFT = fft(lead2noDC,length2);
lead3FFT = fft(lead3noDC,length3);

lead1FFT = lead1FFT(1:length1/2);
lead1magnitude = abs(lead1FFT);

lead2FFT = lead2FFT(1:length2/2);
lead2magnitude = abs(lead2FFT);

lead3FFT = lead3FFT(1:length3/2);
lead3magnitude = abs(lead3FFT);

figure
subplot(3,1,1)
plot(lead1magnitude)

subplot(3,1,2)
plot(lead2magnitude)

subplot(3,1,3)
plot(lead3magnitude)