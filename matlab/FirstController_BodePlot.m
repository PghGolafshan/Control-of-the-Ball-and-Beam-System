%Plotting the Bode diagram for first controller
clear ;
clc ;
num = [63] ;
den = [28 , 67.2 , 0] ;
bode(num , den) ;
grid on ;
