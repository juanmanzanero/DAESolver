function [dx] = PendulumODE_reduced(x,t,pend)
    dx(1,1) = x(2);
    dx(2,1) = -pend.g/pend.l * sin(x(1));
end

