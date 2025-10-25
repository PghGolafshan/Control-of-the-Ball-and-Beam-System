%Compensator
overshoot_max_1 = 5;       % [%]
settlingtime_max_1 = 4;    % [s]
syms zeta omega_n s
eqn1 = [overshoot_max_1*0.99 == 100*exp(-pi*zeta/((1-zeta^2)^0.5))];
zeta = vpa(solve(eqn1, zeta), 6);
if zeta(1) < 0
    zeta(1) = [];
else
    zeta(2) = [];
end
disp('Zeta :'); disp(vpa(zeta, 6));
eqn2 = [settlingtime_max_1*0.99 == 4/(zeta*omega_n)];
omega_n = vpa(solve(eqn2, omega_n), 6);
disp('Omega_n :'); disp(vpa(omega_n, 6));
omega_d = vpa(omega_n*sqrt(1 - zeta^2), 6)
disp('Omega_d :'); disp(vpa(omega_d, 6));
sigma = vpa(zeta*omega_n, 6)
disp('Sigma :'); disp(vpa(sigma, 6));
SettlingTime = vpa(4/sigma, 6);
disp('SettlingTime (s) :'); disp(vpa(SettlingTime, 6));
Overshoot = vpa(100*exp(-(sigma/omega_d)*pi),6);
disp('Overshoot (%) :'); disp(vpa(Overshoot, 6));
eqn3 = s^2 + 2*zeta*omega_n*s + omega_n^2;
S = vpa(solve(eqn3, s), 6)
alpha = 0.5
beta = 5
leadlag_num = [1 alpha];
leadlagnum_p = poly2sym(leadlag_num, s);
leadlag_den = [1 beta];
leadlagden_p = poly2sym(leadlag_den, s);
LeadLag = tf(leadlag_num, leadlag_den)
BBnum = poly2sym(BeamBall.Numerator, s);
BBden = poly2sym(BeamBall.Denominator, s);
sys_num_p = BBnum*leadlagnum_p;
sys_den_p = BBden*leadlagden_p;
rlocus(series(LeadLag,BeamBall))
syms k_c
s =S(2);
sys = k_c*eval(sys_num_p/sys_den_p) ;
eqn3 = abs(sys)-1 ;
k_c = vpa(solve(eqn3,k_c),6)
syms s
leadlagnum_p=poly2sym(k_c*leadlag_num,s);
leadlag_num = sym2poly(leadlagnum_p);
leadlag_controler = tf(leadlag_num,leadlag_den)
margin(series(leadlag_controler,BeamBall))
nyquist(series(leadlag_controler,BeamBall))
leadlag_sys = feedback(series(leadlag_controler,BeamBall),+1)
pzmap(leadlag_sys)
opt = stepDataOptions('StepAmplitude',2);
disp('Lead-Lag Step Response :');
step(leadlag_sys, opt)
axis([0 10 0 2.5])
grid on