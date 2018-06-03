function [A] = PendulumODE_reduced(x,t,pend)
    A(1,1) = 0;
    A(1,2) = 1;
    A(2,1) = -pend.g/pend.l * cos(x(1));    
    A(2,2) = 0;
end

