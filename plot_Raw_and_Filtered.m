%% Plot an example signal for lab report
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