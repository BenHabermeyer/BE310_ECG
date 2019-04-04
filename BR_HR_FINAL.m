%Vera's final breathing and HR analysis

%% Breathing rate example
%Vera breathed for 1 minute each of 10, 15, 20 breaths/min

raw = xlsread("vera_breath1.xlsx", 1);
BR = raw(:,2);
clear raw

Fs = 500;
tmax = 180;
time = 1/Fs:1/Fs:tmax;

mindist = 2*Fs;
[pks1,locs1] = findpeaks(BR,'MinPeakDistance',mindist....
    ,'MinPeakProminence',0.05);
close all
figure
plot(time,BR);
hold on
plot(time(locs1),pks1,'o');
hold off

%calculate the breathing rates in each segment in breaths/min
BR1_1 = 2*sum(locs1/500 <= 30);
BR1_2 = 2*sum(locs1/500 > 30 & locs1/500 <= 60);
BR2_1 = 2*sum(locs1/500 > 60 & locs1/500 <= 90);
BR2_2 = 2*sum(locs1/500 > 90 & locs1/500 <= 120);
BR3_1 = 2*sum(locs1/500 > 120 & locs1/500 <= 150);
BR3_2 = 2*sum(locs1/500 > 150);

%% Breathing rate trial 2
raw3 = xlsread("vera_breath1.xlsx", 3);
BR2 = raw3(:,2);
clear raw3

Fs = 500;
tmax = 180;
time = 1/Fs:1/Fs:tmax;

mindist = 2*Fs;
[pks2,locs2] = findpeaks(BR2,'MinPeakDistance',mindist....
    ,'MinPeakProminence',0.05);
figure
plot(time,BR2);
hold on
plot(time(locs2),pks2,'o');
hold off

%calculate the breathing rates in each segment in breaths/min
BR1_3 = 2*sum(locs2/500 <= 30);
BR1_4 = 2*sum(locs2/500 > 30 & locs2/500 <= 60);
BR2_3 = 2*sum(locs2/500 > 60 & locs2/500 <= 90);
BR2_4 = 2*sum(locs2/500 > 90 & locs2/500 <= 120);
BR3_3 = 2*sum(locs2/500 > 120 & locs2/500 <= 150);
BR3_4 = 2*sum(locs2/500 > 150);


%% Find the difference between actual and predicted BR
%idk this looks ugly but we can figure out another way to do it

%{
%actual breaths per min
BR1_actual = 10;
BR2_actual = 15;
BR3_actual = 20;

%second set of data looks the best - show breathing rate over time with
%error bars of percent error
BR = [BR1_3, BR1_4, BR2_3, BR2_4, BR3_3, BR3_4,];
times = [30, 60, 90, 120, 150, 180];
bpm = [BR1_actual, BR1_actual, BR2_actual, BR2_actual, BR3_actual, ...
    BR3_actual];
pct_error = bpm .* abs(BR - bpm)./bpm;
errorbar(times, BR, pct_error, 's')
%}

%% ok that sucked use the instantaneous BR instead

%first bin data into 30 second windows. Then calculate the instantaneous HR
%for the breaths in each bin. Then compute average and SE. plot vs.
%predicted?

%each bin contains 4 matrices with the locs of the breaths for a 30 second
%window. First cel is the 4 trials of 10bpm, then 15bpm, then 20bpm
BR_first60 = cell(1,4);
BR_second60 = cell(1,4);
BR_third60 = cell(1,4);

%fill the cells appropriately 
BR_first60{1,1} = locs1(locs1/500 <= 30);
BR_first60{1,2} = locs1(locs1/500 > 30 & locs1/500 <= 60);
BR_second60{1,1} = locs1(locs1/500 > 60 & locs1/500 <= 90);
BR_second60{1,2} = locs1(locs1/500 > 90 & locs1/500 <= 120);
BR_third60{1,1} = locs1(locs1/500 > 120 & locs1/500 <= 150);
BR_third60{1,2} = locs1(locs1/500 > 150);
BR_first60{1,3} = locs2(locs2/500 <= 30);
BR_first60{1,4} = locs2(locs2/500 > 30 & locs2/500 <= 60);
BR_second60{1,3} = locs2(locs2/500 > 60 & locs2/500 <= 90);
BR_second60{1,4} = locs2(locs2/500 > 90 & locs2/500 <= 120);
BR_third60{1,3} = locs2(locs2/500 > 120 & locs2/500 <= 150);
BR_third60{1,4} = locs2(locs2/500 > 150);

%to find the instantaneous breathing rate in beats per minute, take the
%difference between the peak times. then convert this to a time in
%minutes. Then to get the rate take the inverse
BR_first60_instant = cell(1,4);
BR_second60_instant = cell(1,4);
BR_third60_instant = cell(1,4);
Fs = 500; %Hz
for i = 1 : 4
    BR_first60_instant{1,i} = ...
    ((BR_first60{1,i}(2:end) - BR_first60{1,i}(1:end-1)) / Fs / 60).^(-1);
    BR_second60_instant{1,i} = ...
    ((BR_second60{1,i}(2:end) - BR_second60{1,i}(1:end-1)) / Fs / 60).^(-1);
    BR_third60_instant{1,i} = ...
    ((BR_third60{1,i}(2:end) - BR_third60{1,i}(1:end-1)) / Fs / 60).^(-1);
end

