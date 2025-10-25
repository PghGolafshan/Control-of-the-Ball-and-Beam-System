% Plotting the Bode diagram for the second controller
clear;
clc;
num = [112, 1.12];
den = [28, 89.74, 0.448, 0];
sys = tf(num, den);

% Nyquist plot
nyquist(sys);
grid on;