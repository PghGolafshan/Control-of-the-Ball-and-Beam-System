% Define plant transfer function
num = [5];
den = [28, 0, 0];
G = tf(num, den);

% Open the SISO Design Tool
sisotool

% Design the PD controller and adjust the parameters

% Implement the PD controller
Kp = 6.61421;
Kd = 8.4;
controller_num = [Kd, Kp];
controller_den = 1;
C = tf(controller_num, controller_den);

% Closed-loop system transfer function
T = feedback(C*G, 1);

% Step response of the closed-loop system
t = 0:0.01:5; % Time vector for simulation
step(T, t);