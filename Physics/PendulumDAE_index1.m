function [F] = PendulumDAE_index1(x,t,pend)

if ( abs(x(3)) > abs(x(1)) )
    F(1,1) = x(2);
    F(2,1) = -x(1)*x(5)/(pend.m*pend.l);
    F(3,1) = (x(1)*x(1) + x(3)*x(3) - pend.l*pend.l);
    F(4,1) = x(1)*x(2) + x(3)*x(4);
    F(5,1) = (x(2)*x(2) + x(4)*x(4)) - x(5)*(pend.l*pend.l) - pend.g*x(3);
    
else
    F(1,1) = x(4);
    F(2,1) = -x(3)*x(5)/(pend.m*pend.l)-pend.g;
    F(3,1) = (x(1)*x(1) + x(3)*x(3) - pend.l*pend.l);
    F(4,1) = x(1)*x(2) + x(3)*x(4);
    F(5,1) = (x(2)*x(2) + x(4)*x(4)) - x(5)*(pend.l*pend.l) - pend.g*x(3);    
end
end

