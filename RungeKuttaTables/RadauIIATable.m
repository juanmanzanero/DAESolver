function [Nstages,a,b,c] = RadauIIATable
%
%   Number of stages
%   ----------------
    Nstages = 3;
%
%   Expensive quantities that are repeated    
%   --------------------------------------
    sqrt6 = sqrt(6);
    inv360 = 1/360;
    inv1800 = 1/1800;
    inv225 = 1/225;
    
    a(1,1) = (88-7*sqrt6)*inv360;
    a(1,2) = (396-196*sqrt6)*inv1800;
    a(1,3) = (-2+3*sqrt6)*inv225;
    
    a(2,1) = (396+196*sqrt6)*inv1800;
    a(2,2) = a(1,1);
    a(2,3) = (-2-3*sqrt6)*inv225;
    
    a(3,1) = (16-sqrt6)*10*inv360;
    a(3,2) = (16+sqrt6)*10*inv360;
    a(3,3) = 1/9;
    
    b(1) = a(3,1);
    b(2) = a(3,2);
    b(3) = a(3,3);
    
    c(1) = 0.1*(4-sqrt6);
    c(2) = c(1);
    c(3) = 1.0;
end

