% homework3.m
% Copywrite (C) 2024 Noam Schuck <noam.schuck@gmail.com>
% ECE211 Signal Processing

clc;
close all;
clear;

h = DiscreteVector(-1, [2 3 4 2 5]);
x = DiscreteVector(-2, [3 4 5 1 2]);
y = convolve(h,x);

createPlot(h, 'hPlot');
createPlot(x, 'xPlot');
createPlot(y, 'convolutionPlot');
