clear
close all
clc

%% Load data from main0.m
load main0

%% Export data to CSV
writematrix(redprec(w, 2)', '../Data/w_0_2.csv')
writematrix(redprec(w, 5)', '../Data/w_0_5.csv')