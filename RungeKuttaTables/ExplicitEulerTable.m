function [Nstages,a,b,c] = ExplicitEulerTable
%
%   Number of stages
%   ----------------
    Nstages = 1;

    a(1,1) = 0;
    b(1)   = 1;
    c(1)   = 0;
end

