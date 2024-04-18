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
thetas1 = [10 25 70];
thetas2 = [10 12 70];

A1 = generateA(M, N, thetas1*pi/180, d/lambda, PdB, PndB);
A2 = generateA(M, N, thetas2*pi/180, d/lambda, PdB, PndB);

R1 = A1*A1'/N;
R2 = A2*A2'/N;

%% Part 2
[svals1, evals1, U1] = analyze(A1,R1);
[svals2, evals2, U2] = analyze(A2,R2);

plotThis(svals1, evals1, 'Plots for Experiment 1');
plotThis(svals2, evals2, 'Plots for Experiment 2');

svals1 = diag(svals1);
svals2 = diag(svals2);

sval_ratios = [svals1(3)/svals1(4) svals2(3)/svals2(4)];
eval_ratios = [evals1(3)/evals1(4) evals2(3)/evals2(4)];

Pn1 = eye(M) - U1(:, [1:3])*U1(:, [1:3])';
Pn2 = eye(M) - U2(:, [1:3])*U2(:, [1:3])';

R1 = (A1*A1')/N;
R2 = (A2*A2')/N;

theta_sweep = 0:.2:180;
S = exp(-1j*2*pi*(d/lambda)*(0:M-1)'.*cos(theta_sweep*(pi/180)))/sqrt(M);

S1_MUSIC = zeros(size(theta_sweep));
S2_MUSIC = zeros(size(theta_sweep));
S1_MUSIC = zeros(size(theta_sweep));
S2_MUSIC = zeros(size(theta_sweep));

R1_inv = inv(R1);
R2_inv = inv(R2);

for i = 1:length(theta_sweep)
    S1_MUSIC(i) = real(1/(S(:,i)'*Pn1*S(:,i)));
    S2_MUSIC(i) = real(1/(S(:,i)'*Pn2*S(:,i)));
    S1_MVDR(i)  = real(1/(S(:,i)'*R1_inv*S(:,i)));
    S2_MVDR(i)  = real(1/(S(:,i)'*R2_inv*S(:,i)));
end

fig = figure;
sgtitle('Matrix Analysis');

subplot(2,2,1);
plot(theta_sweep, S1_MUSIC);
title('MUSIC: Experiment 1');
xlabel('Angle of Arrival [deg]');
ylabel('S_{MUSIC}');
for i = 1:length(thetas1)
    xline(thetas1(i), 'r--', thetas1(i));
end

subplot(2,2,3);
plot(theta_sweep, S2_MUSIC);
title('MUSIC: Experiment 2');
xlabel('Angle of Arrival [deg]');
ylabel('S_{MUSIC}');
for i = 1:length(thetas2)
    xline(thetas2(i), 'r--', thetas2(i));
end

subplot(2,2,2);
plot(theta_sweep, S1_MVDR);
title('MVDR: Experiment 1');
xlabel('Angle of Arrival [deg]');
ylabel('S_{MVDR}');
for i = 1:length(thetas1)
    xline(thetas1(i), 'r--', thetas1(i));
end

subplot(2,2,4);
plot(theta_sweep, S2_MVDR);
title('MVDR: Experiment 2');
xlabel('Angle of Arrival [deg]');
ylabel('S_{MVDR}');
for i = 1:length(thetas2)
    xline(thetas2(i), 'r--', thetas2(i));
end
