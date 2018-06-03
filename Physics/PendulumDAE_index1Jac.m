function [A] = PendulumDAE_index1Jac(x,t,pend)
m = pend.m;
l = pend.l;
ml = m*l;
if ( abs(x(3)) > abs(x(1)) )
    
    A = [ 0    ,   1    ,   0   ,   0   ,   0    ; ...
          -x(5)/ml, 0   ,   0   ,   0   , -x(1)/ml ; ...
          2*x(1), 0 ,      2*x(3) , 0 , 0 ; ...
          x(2), x(1), x(4), x(3), 0; ...
          0, 2*x(2), -pend.g, 2*x(4), -l*l];
else
    A = [ 0    ,   0    ,   0   ,   1   ,   0    ; ...
          0, 0   ,   -x(5)/ml   ,   0   , -x(1)/ml ; ...
          2*x(1), 0 ,      2*x(3) , 0 , 0 ; ...
          x(2), x(1), x(4), x(3), 0; ...
          0, 2*x(2), -pend.g, 2*x(4), -l*l];    
end

