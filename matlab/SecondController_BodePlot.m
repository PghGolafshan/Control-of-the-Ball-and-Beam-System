%Plotting the Bode diagram for second controller
clear ;
clc ;
num = [112 , 1.12] ;
den = [28 , 89.74 , 0.448 , 0] ;
bode(num , den) ;
grid on ;