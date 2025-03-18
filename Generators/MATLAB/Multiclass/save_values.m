clear
close all
clc

%% Load data from main0.m
load main0

%% Export data to CSV
writematrix(redprec(w, 2)', 'W_multi_p2.csv')