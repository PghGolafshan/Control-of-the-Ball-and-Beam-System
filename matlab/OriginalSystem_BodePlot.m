%Plotting the Bode diagram for original system
clear ;
clc ;
num = [5] ;
den = [28 , 0 , 0] ;
bode(num , den) ;
grid on; 