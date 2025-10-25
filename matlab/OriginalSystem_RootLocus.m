%Plotting the root locus for the original system
clear ;
clc ;
num = [5] ;
den = [28,0,0] ;
r = rlocus(num , den) ;
plot(r,'-');
ylabel('jw') ;
xlabel('sigma') ;
v = [-4 4 -4 4] ;
axis(v);
grid on;