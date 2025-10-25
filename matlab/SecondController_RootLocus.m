%Plotting the root locus for second controller
clear ;
clc ;
num = [5 , 0.05] ;
den = [28 , 89.74 , 0.448 , 0] ;
r = rlocus(num , den) ;
plot(r,'-');
ylabel('jw') ;
xlabel('sigma') ;
v = [-4 4 -4 4] ;
axis(v);
grid on ;
