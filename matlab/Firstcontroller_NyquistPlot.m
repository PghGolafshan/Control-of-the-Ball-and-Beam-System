% Plotting the Bode diagram for the first controller
clear;
clc;
num = [63];
den = [28, 67.2, 0];
sys = tf(num, den);

% Nyquist plot
nyquist(sys);
grid on;
