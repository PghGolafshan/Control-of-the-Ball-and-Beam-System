%Plotting the root locus for first controller
clear ;
clc ;
num = [5] ;
den = [28,67.2,0] ;
r = rlocus(num , den) ;
plot(r,'-');
ylabel('jw') ;
xlabel('sigma') ;
v = [-4 4 -4 4] ;
axis(v);
grid on ;
