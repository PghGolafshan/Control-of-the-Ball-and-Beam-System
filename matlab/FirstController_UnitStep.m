%Plotting the unit-step response for first controller
clear ;
clc ;
num = [63] ;
den = [28 , 67.2 , 63] ;
t = 0:0.1:10 ;
step(num , den , t) ;
grid on;