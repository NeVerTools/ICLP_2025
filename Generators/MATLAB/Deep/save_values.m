clear
close all
clc

%% Load data from main0.m
load main0

%% Export data to CSV
% First layer
writematrix(redprec(R, 3)', '../Data/fc1_2_3.csv')

% Output layer
writematrix(redprec(w, 3)', '../Data/fc2_2_3.csv')