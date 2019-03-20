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
bode(H, options)



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
bode(H, options)


