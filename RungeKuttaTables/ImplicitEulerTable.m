function [Nstages,a,b,c] = ImplicitEulerTable
%
%   Number of stages
%   ----------------
    Nstages = 1;

    a(1,1) = 1;
    b(1)   = 1;
    c(1)   = 1;
end

