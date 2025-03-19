clear
close all
clc

%% Load data from main0.m
load main0

%% Export data to CSV
writematrix(redprec(W, 2)', '../../Data/w_1_2.csv')