clear; clc; close all

Vera_normal = xlsread('vera1.xlsx',1);
Vera_exercise = xlsread('vera1.xlsx',4);

Vera_normal_breath = squeeze(Vera_normal(:,2));
Vera_normal_HR = -1*squeeze(Vera_normal(:,3));
Vera_exercise_breath = squeeze(Vera_exercise(:,2));
Vera_exercise_HR = -1*squeeze(Vera_exercise(:,3));

%%

Fs = 500;

time = 1/Fs:1/Fs:60;

subplot(2,1,1)

[pks1,locs1] = findpeaks(Vera_normal_breath,'MinPeakDistance',2.5/60*length(Vera_normal_breath)....
    ,'MinPeakProminence',0.125);
plot(time,Vera_normal_breath);

hold on
plot(time(locs1),pks1,'o');
hold off

subplot(2,1,2)

plot(time,Vera_normal_HR);
[pks,locs,w,p] = findpeaks(Vera_normal_HR,'MinPeakHeight',2.6);
hold on
plot(time(locs),pks,'o');
hold off

%%

%%

Fs = 500;

time = 1/Fs:1/Fs:60;

subplot(2,1,1)

[pks1,locs1] = findpeaks(Vera_exercise_breath,'MinPeakDistance',1.5/60*length(Vera_exercise_breath)....
    ,'MinPeakProminence',0.125);
plot(time,Vera_exercise_breath);

hold on
plot(time(locs1),pks1,'o');
hold off

subplot(2,1,2)

plot(time,Vera_exercise_HR);
[pks,locs,w,p] = findpeaks(Vera_exercise_HR,'MinPeakHeight',2.6);
hold on
plot(time(locs),pks,'o');
hold off



