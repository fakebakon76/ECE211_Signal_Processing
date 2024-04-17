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
[svals1, evals1, U1] = analyze(A1,R1);
[svals2, evals2, U2] = analyze(A2,R2);

%plotThis(svals1, evals1, 'Plots for Experiment 1');
%plotThis(svals2, evals2, 'Plots for Experiment 2');

svals1 = diag(svals1);
svals2 = diag(svals2);

sval_ratios = [svals1(3)/svals1(4) svals2(3)/svals2(4)];
eval_ratios = [evals1(3)/evals1(4) evals2(3)/evals2(4)];

Pn1 = eye(M) - U1*U1';
Pn2 = eye(M) - U2*U2';

R1 = (A1*A1')/N;
R2 = (A2*A2')/N;

theta_sweep = 0:.2:180;
S = exp(-j*2*pi*(d/lambda)*(0:M-1)'.*cos(theta_sweep*(2*pi/180)+zeros(M,1)))/sqrt(M);
S1_MUSIC = ones([1, sum(size(theta_sweep))-1])./(S'*Pn1*S);
S2_MUSIC = ones([1, sum(size(theta_sweep))-1])./(S'*Pn2*S);
