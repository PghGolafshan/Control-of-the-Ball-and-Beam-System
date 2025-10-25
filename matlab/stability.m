
stb = isstable(BeamBall);      % if stb = 0 : unsatble & if stb = 1 : stable
disp('Beam and Ball Transfer Function Stability By (isstable) Function :');
if stb == 0
    disp('-- Unstable --'); disp(' ');
else
    disp('--- Stable ---'); disp(' ');
end
%Routh’s Stability Criterion

disp('Beam and Ball Transfer Function Stability By (Routh-Hurwitz) :');
Routh_Hurwitz(BeamBallDenominator);
function yy = Routh_Hurwitz_Stability(D)
l = length (D);
disp('Roots of Characteristic Equation :');
disp(roots(D));
% Begin of Bulding array
if mod(l,2)==0
    m=zeros(l,l/2);
    [cols,rows]=size(m);
    for i=1:rows
        m(1,i)=D(1,(2*i)-1);
        m(2,i)=D(1,(2*i));
    end
else
    m=zeros(l,(l+1)/2);
    [cols,rows]=size(m);
    for i=1:rows
        m(1,i)=D(1,(2*i)-1);
    end
    for i=1:((l-1)/2)
        m(2,i)=D(1,(2*i));
    end
end
for j=3:cols
    
    if m(j-1,1)==0
        m(j-1,1)=0.001;
    end
    
    for i=1:rows-1
        m(j,i)=(-1/m(j-1,1))*det([m(j-2,1) m(j-2,i+1);m(j-1,1) m(j-1,i+1)]);
    end
end
disp('Routh-Hurwitz Array :');
disp(m);
% End of Bulding array

% Checking for sign change
Temp=sign(m);a=0;
disp('Routh-Hurwitz Stability Criterion :');
for j=1:cols
    a=a+Temp(j,1);
end
if a==cols
    disp('--- stable ---'); disp(' ');
else
    disp('-- Unstable --'); disp(' ');
end
end