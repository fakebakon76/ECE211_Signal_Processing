% filters.m
% Copywrite (C) 2024 Noam Schuck <noam.schuck@gmail.com>
% ECE211 Homework 5

clc;
clear;
close all;

%% Question 1

% Filter Setup
fs = 10e6; % Sampling frequency 10 MHz
fn = fs/2;

% Passband
Wp  = [1.5e6, 2e6]; % Analog passband
Wpd = Wp / fn; % Digital passband
Rp = 2; % passband ripple

% Stopband
Ws = [1.4e6, 2.2e6]; % Analog Stopband
Wsd = Ws / fn; % Digital Stopband
Rs = 40; % stopband ripple

% Analog elliptical filter
[n_ea, Wn_ea] = ellipord(Wp, Ws, Rp, Rs, 's');
[z_ea,p_ea,k_ea] = ellip(n_ea, Rp, Rs, Wn_ea, 's');
[b_ea, a_ea] = zp2tf(z_ea, p_ea, k_ea);
order_eliptical_analog= n_ea*2

% Analog chebychev I filter
[n_ca, Wn_ca] = cheb1ord(Wp, Ws, Rp, Rs, 's');
[z_ca, p_ca, k_ca] = cheby1(n_ca, Rp, Wn_ca, 's');
[b_ca, a_ca] = zp2tf(z_ca, p_ca, k_ca);
order_chebychev1_analog = n_ca*2

% Digital elliptical filter
[n_ed, Wn_ed] = ellipord(Wpd, Wsd, Rp, Rs);
[z_ed,p_ed,k_ed] = ellip(n_ed, Rp, Rs, Wn_ed);
[b_ed, a_ed] = zp2tf(z_ed, p_ed, k_ed);
order_eliptical_digital = n_ed*2

% Digital chebychev I filter
[n_cd, Wn_cd] = cheb1ord(Wpd, Wsd, Rp, Rs);
[z_cd,p_cd,k_cd] = cheby1(n_cd, Rp, Wn_cd);
[b_cd, a_cd] = zp2tf(z_cd, p_cd, k_cd);
order_chebychev1_digital = n_cd*2

% Plotting Filter
plotFilter(a_ea, b_ea, z_ea, p_ea, 0, 'Eliptical Analog Filter');
plotFilter(a_ca, b_ca, z_ca, p_ca, 0, 'Chebychev I Analog Filter');
plotFilter(a_ed, b_ed, z_ed, p_ed, 1, 'Eliptical Digital Filter');
plotFilter(a_cd, b_cd, z_cd, p_cd, 1, 'Chebychev I Digital Filter');


