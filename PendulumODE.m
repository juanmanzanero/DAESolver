function [F] = PendulumODE(x,t,pend)

F(1) = x(2);
F(2) = -x(1)*x(5)/(pend.m*pend.l);
F(3) = x(4);
F(4) = -x(3)*x(5)/(pend.m*pend.l) - pend.g;
F(5) = x(1)*x(1) + x(3)*x(3) - pend.l*pend.l;
    
end
