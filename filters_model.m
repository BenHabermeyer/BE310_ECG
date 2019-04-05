%Find the transfer functions for part 2

%% Highpass filter

clear
close all
clc
R = 330E3; %Ohm
C = 0.01E-6; %Farads
s = tf('s');
%generate the transfer function
H = R*s*C / (R*s*C + 1)
options = bodeoptions;
options.FreqUnits = 'Hz'; % or 'rad/second', 'rpm', etc.
[mag, phase, wout] = bode(H, {4*2*pi, 1001*2*pi}, options);

raw = xlsread("Lab3_HP_Data.xlsx", 1);
freq = raw(:,1);
Vin = raw(:,2);
Vout = raw(:,3);
delT = raw(:,4);

close all
figure
subplot(2,1,1)
semilogx(squeeze(wout/(2*pi)), squeeze(20*log10(mag)), "LineWidth", 1.4)
hold on
semilogx(freq, 20*log10(Vout./Vin), '.', "MarkerSize", 20)
ylabel("Magnitude (dB)")
set(gca, "FontSize", 20)
legend("Passive highpass filter model", "Experimental data", "Location", "southeast")
hold off
subplot(2,1,2)
semilogx(squeeze(wout/(2*pi)), squeeze(phase), "LineWidth", 1.4)
hold on
semilogx(freq, 360*freq.*delT/1000, '.', "MarkerSize", 20)
xlabel("Frequency (Hz)")
ylabel("Phase (degrees)")
legend("Passive highpass filter model", "Experimental data", "Location", "northeast")
hold off
set(gca, "FontSize", 20)
set(gcf,'Position',[0 0 775 775])

%% Second-order lowpass butterworth filter

%use the online data sheet
clear
close all
clc
s = tf('s');

%constants
R1 = 50E3; %ohm
R2 = 50E3; %ohm
RF1 = 3.3E6; %ohm
RF2 = 3.3E6; %ohm
R4 = 50E3; %ohm
RG = 47E3; %ohm
RQ = 43E3; %ohm
C1 = 1000E-12; %farad
C2 = 1000E-12; %farad

%combined constants
Wn2 = R2 / (R1*RF1*RF2*C1*C2);
Alp = R1 / RG;
Q = (1 + R4/RQ) * (1 / ((1/R1)+(1/R2)+(1/RG))) * sqrt((RF1*C1 / (R1*R2*RF2*C2)));

%build the transfer function
H = (Alp * Wn2) / (s^2 + s*sqrt(Wn2)/Q + Wn2)
options = bodeoptions;
options.FreqUnits = 'Hz'; % or 'rad/second', 'rpm', etc.
[mag, phase, wout] = bode(H, {4*2*pi, 1001*2*pi}, options);

raw = xlsread("Lab3_HP_Data.xlsx", 2);
freq = raw(:,1);
Vin = raw(:,2);
Vout = raw(:,3);
delT = raw(:,4);

close all
figure
subplot(2,1,1)
semilogx(squeeze(wout/(2*pi)), squeeze(20*log10(mag)), "LineWidth", 1.4)
hold on
semilogx(freq, 20*log10(Vout./Vin), '.', "MarkerSize", 20)
ylabel("Magnitude (dB)")
set(gca, "FontSize", 20)
legend("Active lowpass filter model", "Experimental data", "Location", "southwest")
hold off
subplot(2,1,2)
semilogx(squeeze(wout/(2*pi)), squeeze(phase), "LineWidth", 1.4)
hold on
semilogx(freq, -360*freq.*delT/1000, '.', "MarkerSize", 20)
xlabel("Frequency (Hz)")
ylabel("Phase (degrees)")
legend("Active lowpass filter model", "Experimental data", "Location", "southwest")
hold off
set(gca, "FontSize", 20)
set(gcf,'Position',[0 0 775 775])

%{
figure
semilogx(squeeze(wout/(2*pi)), squeeze(20*log10(mag)))
hold on
semilogx(freq, 20*log10(Vout./Vin), 'o')
xlabel("Frequency (Hz)")
ylabel("Magnitude (dB)")
title("Active Lowpass Filter - Magnitude")
legend("Model", "Experimental Circuit", "Location", "northwest")

figure
semilogx(squeeze(wout/(2*pi)), squeeze(phase))
hold on
semilogx(freq, -1*360*freq.*delT/1000, 'o')
xlabel("Frequency (Hz)")
ylabel("Phase (degrees)")
title("Active Lowpass Filter - Phase")
legend("Model", "Experimental Circuit", "Location", "northwest")
%}

%% Second-order highpass butterworth filter

%use the online data sheet
clear
close all
clc
s = tf('s');

%constants
R1 = 50E3; %ohm
R2 = 50E3; %ohm
RF1 = 3.3E6; %ohm
RF2 = 3.3E6; %ohm
R4 = 50E3; %ohm
RG = 47E3; %ohm
RQ = 43E3; %ohm
C1 = 1000E-12; %farad
C2 = 1000E-12; %farad

%combined constants
Wn2 = R2 / (R1*RF1*RF2*C1*C2);
Ahp = R2 / RG;
Q = (1 + R4/RQ) * (1 / ((1/R1)+(1/R2)+(1/RG))) * sqrt((RF1*C1 / (R1*R2*RF2*C2)));

%build the transfer function
H = (Ahp * s^2) / (s^2 + s*sqrt(Wn2)/Q + Wn2)
options = bodeoptions;
options.FreqUnits = 'Hz'; % or 'rad/second', 'rpm', etc.
[mag, phase, wout] = bode(H, {4*2*pi, 1001*2*pi}, options);

raw = xlsread("Lab3_HP_Data.xlsx", 3);
freq = raw(:,1);
Vin = raw(:,2);
Vout = raw(:,3);
delT = raw(:,4);

close all
figure
subplot(2,1,1)
semilogx(squeeze(wout/(2*pi)), squeeze(20*log10(mag)), "LineWidth", 1.4)
hold on
semilogx(freq, 20*log10(Vout./Vin), '.', "MarkerSize", 20)
ylabel("Magnitude (dB)")
set(gca, "FontSize", 20)
legend("Active highpass filter model", "Experimental data", "Location", "southeast")
hold off
subplot(2,1,2)
semilogx(squeeze(wout/(2*pi)), squeeze(phase), "LineWidth", 1.4)
hold on
semilogx(freq, 360*freq.*delT/1000, '.', "MarkerSize", 20)
xlabel("Frequency (Hz)")
ylabel("Phase (degrees)")
legend("Active highpass filter model", "Experimental data", "Location", "northeast")
hold off
set(gca, "FontSize", 20)
set(gcf,'Position',[0 0 775 775])

%{
figure
semilogx(squeeze(wout/(2*pi)), squeeze(20*log10(mag)))
hold on
semilogx(freq, 20*log10(Vout./Vin), 'o')
xlabel("Frequency (Hz)")
ylabel("Magnitude (dB)")
title("Active Highpass Filter - Magnitude")
legend("Model", "Experimental Circuit", "Location", "northwest")

figure
semilogx(squeeze(wout/(2*pi)), squeeze(phase))
hold on
semilogx(freq, 360*freq.*delT/1000, 'o')
xlabel("Frequency (Hz)")
ylabel("Phase (degrees)")
title("Active Highpass Filter - Phase")
legend("Model", "Experimental Circuit", "Location", "northwest")
%}

