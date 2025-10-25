%Plotting the unit-step response for second controller
clear ;
clc ;
num = [112 , 1.12] ;
den = [28 , 89.74 , 112.448 , 1.12] ;
t = 0:0.1:10 ;
step(num , den , t) ;
grid on ;
