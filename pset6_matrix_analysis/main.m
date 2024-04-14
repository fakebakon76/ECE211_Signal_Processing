% main.m
% Copywrite (C) Noam Schuck <noam.schuck@gmail.com>

clc;
clear;
close all;

%% Part 1
M      = 100;
N      = 200;
L      = 3;
d      = 1;
lambda = 2;

PdB     = [0 -2 -4];
PndB    = 10;
thetas1 = [10 25 70] * 2*pi/180;
thetas2 = [10 12 70] * 2*pi/180;

A1 = generateA(M, N, thetas1, d/lambda, PdB, PndB);
A2 = generateA(M, N, thetas2, d/lambda, PdB, PndB);

R1 = A1*A1'/N;
R2 = A2*A2'/N;

%% Part 2
[svals1, evals1] = analyze(A1,R1);
[svals2, evals2] = analyze(A2,R2);

plotThis(svals1, evals1, 'Plots for Experiment 1');
plotThis(svals2, evals2, 'Plots for Experiment 2');
   

