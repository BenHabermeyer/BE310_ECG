%use the online data sheet
%Breathing rate filter
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
wmin = 0.1*2*pi;
wmax = 500*2*pi;
[mag, phase, wout] = bode(H, {wmin, wmax}, options);
figure
semilogx(wout/(2*pi), 20*log10(squeeze(mag)))
xlabel("Frequency (Hz)")
xlim([0.1 0.4])
title("Breathing rate lowpass")
ylabel("Magnitude (dB)")
set(gca, "FontSize", 16)
cutoff = 0.3;% Hz

%% highpass filter
clear
close all
clc
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
H = (Ahp * s^2) / (s^2 + s*sqrt(Wn2)/Q + Wn2)
options = bodeoptions;
options.FreqUnits = 'Hz'; % or 'rad/second', 'rpm', etc.
wmin = 0.1*2*pi;
wmax = 500*2*pi;
[mag, phase, wout] = bode(H, {wmin, wmax}, options);
figure
semilogx(wout/(2*pi), 20*log10(squeeze(mag)))
xlabel("Frequency (Hz)")
xlim([0.6 2.5])
title("Heart Rate highpass")
ylabel("Magnitude (dB)")
set(gca, "FontSize", 16)

