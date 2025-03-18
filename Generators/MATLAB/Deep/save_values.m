clear
close all
clc

%% Load data from main0.m
load main0

%% Export data to CSV
% First layer
writematrix(redprec(R, 3)', 'fc_1.csv')

% Output layer
writematrix(redprec(w, 3)', 'fc_2.csv')