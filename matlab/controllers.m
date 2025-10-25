%Controller
Overshoot_max_2 = 5;              % [%]
SettlingTime_max_2 = 4;           % [s]
SteadyStateError_max_2 = 10^-3;   % [m]
CheckNumber = 10;
K_max = 50;
K_min = 0;
%P Controller (a)
% pidTuner(BeamBall,'P')
PID_a = [5.6, 0, 0];    % pidTuner Output
I_a = 0;
D_a = 0;
Kp_min_a = PID_a(1)*0.5;
Kp_max_a = PID_a(1)*1.5;
CorrectAnswer_a = zeros(CheckNumber, 6);
CorrectAnswerNumber_a = 0;
for P = linspace(Kp_min_a,Kp_max_a,CheckNumber)
   controller = pid(P, I_a, D_a);
    transferfunction = feedback(BeamBall*controller, 1);
    unitstepinformation = stepinfo(transferfunction);
    overshoot = unitstepinformation.Overshoot;
    settlingtime = unitstepinformation.SettlingTime;
    [y, t] = step(transferfunction);
    steadystateerror = abs(1 - y(end));
    if (~isnan(overshoot)) || (~isnan(settlingtime)) || (~isinf(overshoot)) || (~isinf(settlingtime))
        if (overshoot < Overshoot_max_2) && (settlingtime < SettlingTime_max_2) && (steadystateerror < SteadyStateError_max_2)
            CorrectAnswerNumber_a = CorrectAnswerNumber_a + 1;
            CorrectAnswer_a(CorrectAnswerNumber_a, :) = [P, I_a, D_a, overshoot, settlingtime, steadystateerror];
        end
    end
end
disp('P Controller Result :');
if CorrectAnswerNumber_a == 0
    disp('-- No Correct Answer --'); disp(' '); 
else
    disp('--- Correct Answer ----'); disp(CorrectAnswer_a); 
end
%PI Controller (b)
% pidTuner(BeamBall,'PI')
PID_b = [5.5991, 0.097995, 0];    % pidTuner Output
D_b = 0;
Kp_min_b = PID_b(1)*0.5;
Kp_max_b = PID_b(1)*1.5;
Ki_min_b = PID_b(3)*0.5;
Ki_max_b = PID_b(2)*1.5;
CorrectAnswer_b = zeros(CheckNumber^2, 6);
CorrectAnswerNumber_b = 0;
for P = linspace(Kp_min_b,Kp_max_b,CheckNumber)
    for I = linspace(Ki_min_b,Ki_max_b,CheckNumber)
        controller = pid(P, I, D_b);
        transferfunction = feedback(BeamBall*controller, 1);
        unitstepinformation = stepinfo(transferfunction);
        overshoot = unitstepinformation.Overshoot;
        settlingtime = unitstepinformation.SettlingTime;
        [y, t] = step(transferfunction);
        steadystateerror = abs(1 - y(end));
        if (~isnan(overshoot)) || (~isnan(settlingtime)) || (~isinf(overshoot)) || (~isinf(settlingtime))
            if (overshoot < Overshoot_max_2) && (settlingtime < SettlingTime_max_2) && (steadystateerror < SteadyStateError_max_2)
                CorrectAnswerNumber_b = CorrectAnswerNumber_b + 1;
                CorrectAnswer_b(CorrectAnswerNumber_b, :) = [P, I, D_b, overshoot, settlingtime, steadystateerror];
            end
        end

    end
end
disp('PI Controller Result :');
if CorrectAnswerNumber_b == 0
    disp('-- No Correct Answer --'); disp(' '); 
else
    disp('--- Correct Answer ----'); disp(CorrectAnswer_b); 
end
%PD Controller (c)
% pidTuner(BeamBall,'PD')      % Response time = 2.370 s; Transient Behavior = 0.845; setteling time = 3.99 s; Overshoot = 1.56 %
PID_c = [0.069786 0 4.725];    % pidTuner Output
I_c = 0;
Kp_min_c = PID_c(1)*0.5;
Kp_max_c = PID_c(1)*1.5;
Kd_min_c = PID_c(3)*0.5;
Kd_max_c = PID_c(3)*1.5;
CorrectAnswer_c = zeros(CheckNumber^2, 6);
CorrectAnswerNumber_c = 0;
for P = linspace(Kp_min_c,Kp_max_c,CheckNumber)
    for D = linspace(Kd_min_c,Kd_max_c,CheckNumber)
        controller = pid(P, I_c, D);
        transferfunction = feedback(BeamBall*controller, 1);
        unitstepinformation = stepinfo(transferfunction);
        overshoot = unitstepinformation.Overshoot;
        settlingtime = unitstepinformation.SettlingTime;
        [y, t] = step(transferfunction);
        steadystateerror = abs(1 - y(end));
        if (~isnan(overshoot)) || (~isnan(settlingtime)) || (~isinf(overshoot)) || (~isinf(settlingtime))
            if (overshoot < Overshoot_max_2) && (settlingtime < SettlingTime_max_2) && (steadystateerror < SteadyStateError_max_2)
                CorrectAnswerNumber_c = CorrectAnswerNumber_c + 1;
                CorrectAnswer_c(CorrectAnswerNumber_c, :) = [P, I_c, D, overshoot, settlingtime, steadystateerror];
            end
        end
    end
end
CorrectAnswer_c(CorrectAnswerNumber_c+1 : CheckNumber^2, :) = [];
Kp = CorrectAnswer_c(:, 1);
Ki = CorrectAnswer_c(:, 2);
Kd = CorrectAnswer_c(:, 3);
Overshoot = CorrectAnswer_c(:, 4);
SettlingTime = CorrectAnswer_c(:, 5);
SteadyStateError = CorrectAnswer_c(:, 6);
CorrectAnswerTable_c = table(Kp, Ki, Kd, Overshoot, SettlingTime, SteadyStateError);
disp('PD Controller Result :');
if CorrectAnswerNumber_c == 0
    disp('-- No Correct Answer --'); disp(' '); 
else
    disp('--- Correct Answer ----'); disp(CorrectAnswerTable_c); 
end
OptimalOvershoot_c = 100*ones(1,6);
OptimalSettlingTime_c = 100*ones(1,6);
OptimalSteadyStateError_c = 100*ones(1,6);
OptimalK_c = 100*ones(1,6);
for n = 1 : CorrectAnswerNumber_c
    if CorrectAnswer_c(n, 4) < OptimalOvershoot_c(4)
        OptimalOvershoot_c = CorrectAnswer_c(n, :);
    end
    if CorrectAnswer_c(n, 5) < OptimalSettlingTime_c(5)
        OptimalSettlingTime_c = CorrectAnswer_c(n, :);
    end
    if CorrectAnswer_c(n, 6) < OptimalSteadyStateError_c(6)
        OptimalSteadyStateError_c = CorrectAnswer_c(n, :);
    end
    if CorrectAnswer_c(n, 1) + CorrectAnswer_c(n, 2) + CorrectAnswer_c(n, 3) < OptimalK_c(1) + OptimalK_c(2) + OptimalK_c(3)
        OptimalK_c = CorrectAnswer_c(n, :);
    end
end
disp('Optimal Overshoot :'); disp(array2table(OptimalOvershoot_c,"VariableNames",["Kp","Ki","Kd","Overshoot","SettlingTime","SteadyStateError"]));
disp('Optimal Settling Time :'); disp(array2table(OptimalSettlingTime_c,"VariableNames",["Kp","Ki","Kd","Overshoot","SettlingTime","SteadyStateError"]));
disp('Optimal Steady State Error :'); disp(array2table(OptimalSteadyStateError_c,"VariableNames",["Kp","Ki","Kd","Overshoot","SettlingTime","SteadyStateError"]));
disp('Optimal K (minimmum of K) :'); disp(array2table(OptimalK_c,"VariableNames",["Kp","Ki","Kd","Overshoot","SettlingTime","SteadyStateError"]));
PID_PD = OptimalK_c(1:3);
disp('PD Controller Design :'); disp(array2table(PID_PD,"VariableNames",["Kp","Ki","Kd"]));

%PID Controller (d)
% pidTuner(BeamBall,'PID')    % Response time = 0.335 s; Transient Behavior = 0.8647; setteling time = 3.99 s; Overshoot = 4.99 %
PID_d = [12.2895, 0.91951, 33.3952];    % pidTuner Output
Kp_min_d = PID_d(1)*0.5;
Kp_max_d = PID_d(1)*1.5;
Ki_min_d = PID_d(2)*0.5;
Ki_max_d = PID_d(2)*1.5;
Kd_min_d = PID_d(3)*0.5;
Kd_max_d = PID_d(3)*1.5;
CorrectAnswer_d = zeros(CheckNumber^3, 6);
CorrectAnswerNumber_d = 0;
for P = linspace(Kp_min_d,Kp_max_d,CheckNumber)
    for I = linspace(Ki_min_d,Ki_max_d,CheckNumber)
        for D = linspace(Kd_min_d,Kd_max_d,CheckNumber)
            controller = pid(P, I, D);
            transferfunction = feedback(BeamBall*controller, 1);
            unitstepinformation = stepinfo(transferfunction);
            overshoot = unitstepinformation.Overshoot;
            settlingtime = unitstepinformation.SettlingTime;
            [y, t] = step(transferfunction);
            steadystateerror = abs(1 - y(end));
            if (~isnan(overshoot)) || (~isnan(settlingtime)) || (~isinf(overshoot)) || (~isinf(settlingtime))
                if (overshoot < Overshoot_max_2) && (settlingtime < SettlingTime_max_2) && (steadystateerror < SteadyStateError_max_2)
                    CorrectAnswerNumber_d = CorrectAnswerNumber_d + 1;
                    CorrectAnswer_d(CorrectAnswerNumber_d, :) = [P, I, D, overshoot, settlingtime, steadystateerror];
                end
            end
        end
    end
end
CorrectAnswer_d(CorrectAnswerNumber_d+1 : CheckNumber^3, :) = [];
Kp = CorrectAnswer_d(:, 1);
Ki = CorrectAnswer_d(:, 2);
Kd = CorrectAnswer_d(:, 3);
Overshoot = CorrectAnswer_d(:, 4);
SettlingTime = CorrectAnswer_d(:, 5);
SteadyStateError = CorrectAnswer_d(:, 6);
CorrectAnswerTable_d = table(Kp, Ki, Kd, Overshoot, SettlingTime, SteadyStateError);
disp('PID Controller Result :');
if CorrectAnswerNumber_d == 0
    disp('-- No Correct Answer --'); disp(' '); 
else
    disp('--- Correct Answer ----'); disp(CorrectAnswerTable_d); 
end
OptimalOvershoot_d = 100*ones(1,6);
OptimalSettlingTime_d = 100*ones(1,6);
OptimalSteadyStateError_d = 100*ones(1,6);
OptimalK_d = 100*ones(1,6);
for n = 1 : CorrectAnswerNumber_d
    if CorrectAnswer_d(n, 4) < OptimalOvershoot_d(4)
        OptimalOvershoot_d = CorrectAnswer_d(n, :);
    end
    if CorrectAnswer_d(n, 5) < OptimalSettlingTime_d(5)
        OptimalSettlingTime_d = CorrectAnswer_d(n, :);
    end
    if CorrectAnswer_d(n, 6) < OptimalSteadyStateError_d(6)
        OptimalSteadyStateError_d = CorrectAnswer_d(n, :);
    end
    if CorrectAnswer_d(n, 1) + CorrectAnswer_d(n, 2) + CorrectAnswer_d(n, 3) < OptimalK_d(1) + OptimalK_d(2) + OptimalK_d(3)
        OptimalK_d = CorrectAnswer_d(n, :);
    end
end
disp('Optimal Overshoot :'); disp(array2table(OptimalOvershoot_d,"VariableNames",["Kp","Ki","Kd","Overshoot","SettlingTime","SteadyStateError"]));
disp('Optimal Settling Time :'); disp(array2table(OptimalSettlingTime_d,"VariableNames",["Kp","Ki","Kd","Overshoot","SettlingTime","SteadyStateError"]));
disp('Optimal Steady State Error :'); disp(array2table(OptimalSteadyStateError_d,"VariableNames",["Kp","Ki","Kd","Overshoot","SettlingTime","SteadyStateError"]));
disp('Optimal K (minimmum of K) :'); disp(array2table(OptimalK_d,"VariableNames",["Kp","Ki","Kd","Overshoot","SettlingTime","SteadyStateError"]));
PID_PID = OptimalK_d(1:3);
disp('PID Controller Design :'); disp(array2table(PID_PID,"VariableNames",["Kp","Ki","Kd"]));

 %firstController
disp('PD Controller :');
PD_Controller = pid(PID_PD(1), PID_PD(2), PID_PD(3))
%SecondController
disp('PID Controller :');
PID_Controller = pid(PID_PID(1), PID_PID(2), PID_PID(3))
%Closed_Loop Transfer Function
disp('PID Closed-Loop TransferFunction :');
PID_TransferFunction = feedback(BeamBall*PID_Controller, 1)

