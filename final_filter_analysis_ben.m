%Ben's data analysis for ECG

%first column is signal, second is breathing, third is HR
raw1 = xlsread("ben1.xlsx", 1);
normal_BR = raw1(:,2);
normal_HR = -raw1(:,3);
clear raw1
raw2 = xlsread("ben1.xlsx", 2);
sleeping_BR = raw2(:,2);
sleeping_HR = -raw2(:,3);
clear raw2
raw3 = xlsread("ben1.xlsx", 3);
running_BR = raw3(:,2);
running_HR = -raw3(:,3);
clear raw3
raw4 = xlsread("ben1.xlsx", 4);
hyperventilating_BR = raw4(:,2);
hyperventilating_HR = -raw4(:,3);
clear raw4

%{
figure
subplot(2,1,1)
plot(normal_BR)
subplot(2,1,2)
plot(normal_HR)

figure
subplot(2,1,1)
plot(sleeping_BR)
subplot(2,1,2)
plot(sleeping_HR)

figure
subplot(2,1,1)
plot(running_BR)
subplot(2,1,2)
plot(running_HR)

figure
subplot(2,1,1)
plot(hyperventilating_BR)
subplot(2,1,2)
plot(hyperventilating_HR)
%}



