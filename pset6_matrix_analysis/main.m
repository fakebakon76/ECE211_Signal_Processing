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

S1_MUSIC = sum(eye(sum(size(theta_sweep))-1) .* real(ones([1, sum(size(theta_sweep))-1])./(S'*Pn1*S)));
S2_MUSIC = sum(eye(sum(size(theta_sweep))-1) .* real(ones([1, sum(size(theta_sweep))-1])./(S'*Pn2*S)));
S1_MVDR  = sum(eye(sum(size(theta_sweep))-1) .* real(ones([1, sum(size(theta_sweep))-1])./(S'*inv(R1)*S)));
S2_MVDR  = sum(eye(sum(size(theta_sweep))-1) .* real(ones([1, sum(size(theta_sweep))-1])./(S'*inv(R2)*S)));

fig = figure;
sgtitle('Matrix Analysis');
subplot(2,2,1);
plot(S1_MUSIC);
title('MUSIC: Experiment 1');

subplot(2,2,3);
plot(S2_MUSIC);
title('MUSIC: Experiment 2');

subplot(2,2,2);
plot(S1_MVDR);
title('MVDR: Experiment 1');

subplot(2,2,4);
plot(S2_MVDR);
title('MVDR: Experiment 2');


SMUSIC_3 = zeros(size(theta_sweep));
for i = 1:length(theta_sweep)
    AOA_1 = theta_sweep(i) * pi / 180;
    s_1 = exp(-1j * 2 * pi * d/lambda * cos(AOA_1) * (0:M-1).') / sqrt(M);
    SMUSIC_3(i) = 1 / (s_1' * Pn1 * s_1);
end
