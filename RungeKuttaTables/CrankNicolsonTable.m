function [Nstages,a,b,c] = CrankNicolsonTable
%
%   Number of stages
%   ----------------
    Nstages = 1;

    a(1,1) = 1/2;
    b(1)   = 1;
    c(1)   = 1/2;
end

