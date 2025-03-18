clear
close all
clc

%% Load data from main0.m
load main0

%% Export data to CSV
writematrix(redprec(w, 2)', 'W_binary_p2.csv')
writematrix(redprec(w, 5)', 'W_binary_p5.csv')