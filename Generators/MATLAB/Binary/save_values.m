clear
close all
clc

%% Execute main0.m and main1.m

%% Load data from main0.m
load main0

%% Export data to CSV
writematrix(redprec(w, 2)', '../../Data/w_0_2.csv')
writematrix(redprec(w, 4)', '../../Data/w_0_4.csv')

%% Load data from main1.m
load main1

%% Export data to CSV
writematrix(X_v, '../../Data/xv_0_2.csv')