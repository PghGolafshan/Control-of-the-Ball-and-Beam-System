%Plotting the Bode diagram for original system
clear ;
clc ;
num = [5];
den = [28, 0, 0];

sys = tf(num, den);

% Plotting the Nyquist diagram
figure;
nyquist(sys);
grid on;

% Labeling the plot
title('Nyquist Diagram');
xlabel('Real Axis');
ylabel('Imaginary Axis');