%% Plot an example signal for lab report
%this is the filtered ECG signal
raw = xlsread("vera_breath1.xlsx", 3);
normal = raw(:,1);
lowpass = raw(:,2);
highpass = raw(:,3);
clear raw

tend = length(normal) / 500;
time = 0:(1/500):(tend-1/500);

t1 = 29.002*500;
t2 = 39.002*500;

close all
figure
subplot(3,1,1)
plot(time(t1:t2), normal(t1:t2))
xticks([29.002:2:39.002])
xticklabels({})
ylabel("Voltage (mV)")
set(gca, "FontSize", 16)
subplot(3,1,2)
plot(time(t1:t2), lowpass(t1:t2))
xticks([29.002:2:39.002])
xticklabels({})
ylabel("Voltage (mV)")
set(gca, "FontSize", 16)
subplot(3,1,3)
plot(time(t1:t2), highpass(t1:t2))
xlabel("Time (s)")
set(gca, "FontSize", 16)
xticks([29.002:2:39.002])
xticklabels({'0', '2' '4', '6', '8', '10'})
ylabel("Voltage (mV)")

%% plot the 3 lead signals from the interim report stuff
raw = xlsread("ECG_Data2.xlsx", 2);
%using Ben 2
lead1 = raw(:,1) - smooth(raw(:,1), 1001);
lead2 = raw(:,2) - smooth(raw(:,2), 1001);
lead3 = raw(:,3) - smooth(raw(:,3), 1001);
%{
lead1 = raw(:,1);
lead2 = raw(:,2);
lead3 = raw(:,3);
%}

close all
time = 0:(1/500):(length(lead1)/500 - 0.002);
t1 = 50.002*500;
t2 = 55.002*500;
figure
subplot(3,1,1)
plot(time(t1:t2), lead1(t1:t2))
xticklabels({})
ylabel("Voltage (mV)")
set(gca, "FontSize", 16)
subplot(3,1,2)
plot(time(t1:t2), lead2(t1:t2))
ylabel("Voltage (mV)")
set(gca, "FontSize", 16)
xticklabels({})
subplot(3,1,3)
plot(time(t1:t2), lead3(t1:t2))
xlabel("Time (s)")
ylabel("Voltage (mV)")
xticklabels({'0', '', '1', '', '2', '', '3', '', '4', '', '5'})
set(gca, "FontSize", 16)

