clear; clc; close all


%ECG data for Matt

data1 = xlsread('ECG_Data.xlsx',2);
data2 = xlsread('ECG_Data.xlsx',3);

%ECG data for Evan

data3 = xlsread('ECG_Data.xlsx',4);
data4 = xlsread('ECG_Data.xlsx',5);

%ECG data for Vera

data5 = xlsread('ECG_Data2.xlsx',3);
data6 = xlsread('ECG_Data2.xlsx',4);

%ECG data for Ben

data7 = xlsread('ECG_Data2.xlsx',1);
data8 = xlsread('ECG_Data2.xlsx',2);

C = cell(1,8);
C{1} = data1;
C{2} = data2;
C{3} = data3;
C{4} = data4;
C{5} = data5;
C{6} = data6;
C{7} = data7;
C{8} = data8;


%%
minPeak = 0.6;
count = 0;
matrix(1:4,1:4,1:3) = 0;
for jj = 1:4 %4 subjects
    for kk = 1:2 %2 trials
        count = count + 1;
        for ll = 1:3 %number of lead configurations
            
            data = C{count};
            [matrix(jj,kk,ll), matrix(jj,kk+2,ll)] = beatDuration(data(:,ll),minPeak);
            
        end
    end
end


% %%
% subplot(1,3,1)
% 
% plot(Subject1_trial1_L1)
% title('Lead 1');
% ylim([-1.2 1.2]);
% 
% subplot(1,3,2)
% 
% plot(Subject1_trial1_L2)
% title('Lead 2');
% ylim([-1.5 1.5]);
% 
% subplot(1,3,3)
% 
% plot(Subject1_trial1_L3)
% title('Lead 3');
% ylim([-1.5 1.5]);
% 
% %Search through the peaks using the findpeaks function. Using the
% %MinPeakDistance parameter set to ignore any peaks whose distance in the
% %time domain are less than 0.6s (this corresponds to a heart rate of 100
% %bpm). This should prevent the peaks function from locating any non R-R
% %peak distances.
% 
% [peaks, locs] = findpeaks(Subject1_trial1_L1,'MinPeakDistance',0.60*500);
% [peaks2, locs2] = findpeaks(Subject1_trial1_L2,'MinPeakDistance',0.60*500);
% [peaks3, locs3] = findpeaks(Subject1_trial1_L3,'MinPeakDistance',0.60*500);
% 
% %Convert the peak locations to times in seconds
% R_peaks = locs/500;
% R_peaks2 = locs2/500;
% R_peaks3 = locs3/500;
% 
% %Calculate the difference in time between each beat and calculate its
% %average and standard deviation.
% 
% peak_lengths = diff(R_peaks);
% mean_duration = mean(peak_lengths);
% std_duration = std(peak_lengths);
% 
% figure()
% 
% plot(Subject1_trial1_L1)
% 
% hold on
% 
% plot(locs,peaks,'o')
% 
% hold off




