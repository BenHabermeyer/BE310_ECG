%Frequency Domain Analysis Question 5

%Loading Data (change number after comma for different sheet)
%Using Ben's Trial 2
data = xlsread('ECG_Data2.xlsx', 2);

lead_peak_times = [];
lead_peak_rates = zeros(1, 5);

Fs = 500; %Define sampling frequency of EKG
time = 0:1/Fs:300;

subplot(4,3,1)

%Plot Lead 1 original signal over representative 5s period

signal1 = plot(time(1:2501),data(1:2501,1));
title('Original Lead1 Signal');
xlabel('Time (s)');
ylabel('Voltage (mV)');

subplot(4,3,2)

%Plot Lead 2 original signal over representative 5s period

signal2 = plot(time(1:2501),data(1:2501,2));
title('Original Lead2 Signal');
xlabel('Time (s)');
ylabel('Voltage (mV)');

subplot(4,3,3)

%Plot Lead 3 original signal over representative 5s period

signal3 = plot(time(1:2501),data(1:2501,3));
title('Original Lead2 Signal');
xlabel('Time (s)');
ylabel('Voltage (mV)');

%Smooth data over windows of length smooth_level, then subtract this
%baseline level from the original signal.

smooth_level = 1001;
lead1_s = smooth(data(:,1),smooth_level);
lead2_s = smooth(data(:,2),smooth_level);
lead3_s = smooth(data(:,3),smooth_level);

%subtract that average for each lead
lead1noDC = data(:,1) - lead1_s;
lead2noDC = data(:,2) - lead2_s;
lead3noDC = data(:,3) - lead3_s;

subplot(4,3,4)

%Plot Lead 1 DC mean subtracted signal over representative 5s period

signal1_smooth = plot(time(1:2501),lead1noDC(1:2501));
title('DC Mean Subtracted Signal for Lead1');
xlabel('Time (s)');
ylabel('Voltage (mV)');

subplot(4,3,5)

%Plot Lead 2 DC mean subtracted signal over representative 5s period

signal2_smooth = plot(time(1:2501),lead2noDC(1:2501));
title('DC Mean Subtracted Signal for Lead2');
xlabel('Time (s)');
ylabel('Voltage (mV)');

subplot(4,3,6)

%Plot Lead 3 DC mean subtracted signal over representative 5s period

signal3_smooth = plot(time(1:2501),lead3noDC(1:2501));
title('DC Mean Subtracted Signal for Lead3');
xlabel('Time (s)');
ylabel('Voltage (mV)');

length1 = length(lead1noDC);
length2 = length(lead2noDC);
length3 = length(lead3noDC);

%Create the time vector for the signal based on 500 Hz sampling rate and signal length.

Fs = 500;             % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length1;          % Length of signal
t = (0:L-1)*T;        % Time vector

%Calculate Fourier transform for each signal. 
Y1 = fft(lead1noDC);
Y2 = fft(lead2noDC);
Y3 = fft(lead3noDC);

%Calculate the two sided amplitude spectrum for each signal
P2_L1 = abs(Y1/L);
P1_L1 = P2_L1(1:L/2+1);
P1_L1(2:end-1) = 2*P1_L1(2:end-1);

P2_L2 = abs(Y2/L);
P1_L2 = P2_L2(1:L/2+1);
P1_L2(2:end-1) = 2*P1_L2(2:end-1);

P2_L3 = abs(Y3/L);
P1_L3 = P2_L3(1:L/2+1);
P1_L3(2:end-1) = 2*P1_L3(2:end-1);

%Generate vector of freuqnecies scaled buy the sampling rate and the length
%of the signal, L.

f = Fs*(0:(L/2))/L;

subplot(4,3,7)

%Plot values of the amplitude spectrum from 1 to 125 Hz (after which the
%ampltude value is negligible)

mag1 = semilogx(f,P1_L1);
title('One-Sided Amplitude Spectrum for Lead1');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(4,3,8)

mag2= semilogx(f,P1_L2);
title('One-Sided Amplitude Spectrum for Lead2');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(4,3,9)

mag3 = semilogx(f,P1_L3);
title('One-Sided Amplitude Spectrum for Lead3');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(4,3,10)

power1 = semilogx(f,P1_L1.^2);
title('One-Sided Power Spectrum for Lead1');
xlabel('Frequency (Hz)');
ylabel('Power');

subplot(4,3,11)

power2 = semilogx(f,P1_L2.^2);
title('One-Sided Power Spectrum for Lead2');
xlabel('Frequency (Hz)');
ylabel('Power');

subplot(4,3,12)

power3 = semilogx(f,P1_L3.^2);
title('One-Sided Power Spectrum for Lead3');
xlabel('Frequency (Hz)');
ylabel('Power');

%%

close all

figure(1)

subplot(2,2,1)

signal1 = plot(time(1:2501),data(1:2501,1));
title('Original Lead1 Signal');
xlabel('Time (s)');
ylabel('Voltage (mV)');

subplot(2,2,3)

signal1_smooth = plot(time(1:2501),lead1noDC(1:2501));
title('DC Mean Subtracted Signal for Lead1');
xlabel('Time (s)');
ylabel('Voltage (mV)');

subplot(2,2,2)
mag1 = semilogx(f,P1_L1);
title('One-Sided Amplitude Spectrum for Lead1');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(2,2,4)

power1 = semilogx(f,P1_L1.^2);
title('One-Sided Power Spectrum for Lead1');
xlabel('Frequency (Hz)');
ylabel('Power');

figure(2)

subplot(2,2,1)

signal2 = plot(time(1:2501),data(1:2501,2));
title('Original Lead2 Signal');
xlabel('Time (s)');
ylabel('Voltage (mV)');

subplot(2,2,3)

signal2_smooth = plot(time(1:2501),lead2noDC(1:2501));
title('DC Mean Subtracted Signal for Lead2');
xlabel('Time (s)');
ylabel('Voltage (mV)');

subplot(2,2,2)
mag2 = semilogx(f,P1_L2);
title('One-Sided Amplitude Spectrum for Lead2');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(2,2,4)

power1 = semilogx(f,P1_L2.^2);
title('One-Sided Power Spectrum for Lead2');
xlabel('Frequency (Hz)');
ylabel('Power');

figure(3)

subplot(2,2,1)

signal3 = plot(time(1:2501),data(1:2501,3));
title('Original Lead3 Signal');
xlabel('Time (s)');
ylabel('Voltage (mV)');

subplot(2,2,3)

signal3_smooth = plot(time(1:2501),lead3noDC(1:2501));
title('DC Mean Subtracted Signal for Lead3');
xlabel('Time (s)');
ylabel('Voltage (mV)');

subplot(2,2,2)
mag3 = semilogx(f,P1_L3);
title('One-Sided Amplitude Spectrum for Lead3');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(2,2,4)

power3 = semilogx(f,P1_L3.^2);
title('One-Sided Power Spectrum for Lead3');
xlabel('Frequency (Hz)');
ylabel('Power');














% lead1FFT = fft(lead1noDC,length1);
% lead2FFT = fft(lead2noDC,length2);
% lead3FFT = fft(lead3noDC,length3);
% 
% lead1FFT = lead1FFT(1:length1/2);
% lead1magnitude = abs(lead1FFT);
% 
% lead2FFT = lead2FFT(1:length2/2);
% lead2magnitude = abs(lead2FFT);
% 
% lead3FFT = lead3FFT(1:length3/2);
% lead3magnitude = abs(lead3FFT);
% 
% figure
% subplot(3,1,1)
% plot(lead1magnitude)
% 
% subplot(3,1,2)
% plot(lead2magnitude)
% 
% subplot(3,1,3)
% plot(lead3magnitude)