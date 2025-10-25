clc; clear; close all;

  
        %modeling 

        % palnt dimensions.

       m = 0.1;       % [kg]
       R = 0.01;      % [m]
       J = 4*10^-6;   % [Kg.m^2]
       d = 0.025;     % [m]
       L = 1;         % [m]
       g = 10;        % [m/s^2]
           
        %%diffrent type of unit Inputs
        %unit Impulse
        disp('Unit Impulse Response :');
        impulse(BeamBall)
        grid on

        %unit Step
       disp('Unit Step Response :');
       step(BeamBall)
       grid on

       %unit amplitude Sinusoidal
       time = 0 : 0.001 : 50;
       SinusoidalInput = sin(time);
       SinusoidalOutput = lsim(BeamBall, SinusoidalInput, time);
       disp('Sinusoidal Response :');
       plot(time, SinusoidalOutput)
       grid on
       ylabel('Amplitude')
       xlabel('Time (seconds)')
       title('Sinusoidal Response')

       %Transfer Function Simulation
       disp('Beam-ball Transfer Function :');
       BeamBallNumerator = [0, 0, (m*g*d/(L*(J/R^2+m)))];
       BeamBallDenominator = [1, 0, 0];
       BeamBall = tf(BeamBallNumerator, BeamBallDenominator)

%Poles
Poles = pole(BeamBall);
PolesNumber = size(Poles);
PolesNumber = PolesNumber(1);
disp('Poles :');
if PolesNumber == 0
disp('No Poles'); disp(' ');
 else
 disp(Poles);
end

%Zeros
Zeros = zero(BeamBall);
ZerosNumber = size(Zeros);
ZerosNumber = ZerosNumber(1);
disp('Zeros :');
if ZerosNumber == 0
 disp('No Zeros'); disp(' ');
else
disp(Zeros);
end




