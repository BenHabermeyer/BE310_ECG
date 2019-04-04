%use the online data sheet
%% Breathing rate filter
clear
close all
clc
s = tf('s');

%constants
R1 = 50E3; %ohm
R2 = 50E3; %ohm
RF1 = 560E3; %ohm
RF2 = 560E3; %ohm
R4 = 50E3; %ohm
RG = 51E3; %ohm
RQ = 44.5E3; %ohm
C1 = 1000E-12 + 1E-6; %farad
C2 = 1000E-12 + 1E-6; %farad

%combined constants
Wn2 = R2 / (R1*RF1*RF2*C1*C2);
Alp = R1 / RG;
Q = (1 + R4/RQ) * (1 / ((1/R1)+(1/R2)+(1/RG))) * sqrt((RF1*C1 / (R1*R2*RF2*C2)));

%build the transfer function
H = (Alp * Wn2) / (s^2 + s*sqrt(Wn2)/Q + Wn2)
options = bodeoptions;
options.FreqUnits = 'Hz'; % or 'rad/second', 'rpm', etc.
wmin = 0.2*2*pi;
wmax = 10*2*pi;
[mag, phase, wout] = bode(H, {wmin, wmax}, options);
figure
semilogx(wout/(2*pi), 20*log10(squeeze(mag)))
xlabel("Frequency (Hz)")
xlim([0.19, 10.1])
title("Breathing rate lowpass")
ylabel("Magnitude (dB)")
set(gca, "FontSize", 16)
cutoff = 0.3;% Hz

%% highpass filter
s = tf('s');

%constants
R1 = 50E3; %ohm
R2 = 50E3; %ohm
RF1 = 2E6; %ohm
RF2 = 2E6; %ohm
R4 = 50E3; %ohm
RG = 51E3; %ohm
RQ = 43E3; %ohm
C1 = 1000E-12 + 100E-9; %farad
C2 = 1000E-12 + 100E-9; %farad

%combined constants
Wn2 = R2 / (R1*RF1*RF2*C1*C2);
Ahp = R2 / RG;
Q = (1 + R4/RQ) * (1 / ((1/R1)+(1/R2)+(1/RG))) * sqrt((RF1*C1 / (R1*R2*RF2*C2)));

%build the transfer function
H2 = (Ahp * s^2) / (s^2 + s*sqrt(Wn2)/Q + Wn2)
options = bodeoptions;
options.FreqUnits = 'Hz'; % or 'rad/second', 'rpm', etc.
wmin = 0.2*2*pi;
wmax = 10*2*pi;
[maghp, phasehp, wouthp] = bode(H2, {wmin, wmax}, options);
figure
subplot(2,1,1)
semilogx(wouthp/(2*pi), 20*log10(squeeze(maghp)))
xlim([0.19 10.1])
title("Heart Rate highpass")
ylabel("Magnitude (dB)")
set(gca, "FontSize", 16)
subplot(2,1,2)
semilogx(wouthp/(2*pi), squeeze(phasehp))
ylabel("Phase (degrees)")
set(gca, "FontSize", 16)
xlabel("Frequency (Hz)")
xlim([0.19 10.1])

%% plot everything together 
close all
%read in the experimental data
raw1 = xlsread("final_filter_bode.xlsx",1);
frequency = raw1(:,1);
V = 2; %used 2 volt vpp for all
vlowpass = raw1(:,3);
tlowpass = raw1(:,4);
raw2 = xlsread("final_filter_bode.xlsx",2);
vhighpass = raw2(:,3);
thighpass = raw2(:,4);

close all
figure
subplot(2,2,1)
semilogx(wout/(2*pi), 20*log10(squeeze(mag)), "LineWidth", 1.4)
xlim([0.19, 10.1])
ylabel("Magnitude (dB)")
set(gca, "FontSize", 16)
hold on
plot(frequency, 20*log10(vlowpass / V),'.', 'MarkerSize', 20)
hold off
legend("Model Lowpass Filter", "Experimental data", "location", "northeast")
subplot(2,2,2)
semilogx(wouthp/(2*pi), 20*log10(squeeze(maghp)), "LineWidth", 1.4)
xlim([0.19 10.1])
ylabel("Magnitude (dB)")
set(gca, "FontSize", 16)
hold on
plot(frequency, 20*log10(vhighpass / V),'.', 'MarkerSize', 20)
hold off
legend("Model Highpass Filter", "Experimental data", "location", "southeast")
subplot(2,2,3)
semilogx(wout/(2*pi), squeeze(phase), "LineWidth", 1.4)
ylabel("Phase (degrees)")
set(gca, "FontSize", 16)
xlabel("Frequency (Hz)")
xlim([0.19 10.1])
hold on
plot(frequency, -360*frequency.*tlowpass/1000,'.', 'MarkerSize', 20)
hold off
legend("Model Lowpass Filter", "Experimental data", "location", "northeast")
subplot(2,2,4)
semilogx(wouthp/(2*pi), squeeze(phasehp), "LineWidth", 1.4)
ylabel("Phase (degrees)")
set(gca, "FontSize", 16)
xlabel("Frequency (Hz)")
xlim([0.19 10.1])
hold on
plot(frequency, 360*frequency.*thighpass/1000,'.', 'MarkerSize', 20)
hold off
legend("Model Highpass Filter", "Experimental data", "location", "northeast")


