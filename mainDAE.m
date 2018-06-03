clear all
clc
close all

addpath('./RungeKuttaTables');
%
%   *******************
%   Pendulum parameters
%   *******************
%
    g = 9.81;
    l = 1.0;
    m = 1.0;
    pend = struct('g',g,'l',l,'m',m);
%
%   ********************
%   Solver configuration
%   ********************
%
%   Initial condition
%   -----------------
    x0 = [l,0];
    NT = 100;
    tEnd = 5.0;
%
%   ****************************
%   Solve by natural coordinates
%   ****************************
%
    theta0 = atan2(x0(1),x0(2));
%
%   Using RadauIIA solver
%   ---------------------
    [toutRIIA,youtRIIA,nMaxSteps] = GeneralRKScheme(@(t,x)(PendulumODE_reduced(x,t,pend)),@(t,x)(PendulumODE_reducedJac(x,t,pend)),@()(RadauIIATable),[theta0,0],[0,tEnd],NT,0);
%
%   Using Prince-Dormand
%   --------------------
    [toutPD,youtPD,nMaxSteps] = GeneralRKScheme(@(t,x)(PendulumODE_reduced(x,t,pend)),@(t,x)(PendulumODE_reducedJac(x,t,pend)),@()(DormandPrinceTable),[theta0,0],[0,tEnd],NT,0);            
    
    h = figure;
    hold on;
    plot(toutRIIA, youtRIIA(1,:));
    plot(toutPD, youtPD(1,:));
    legend({'RIIA','PD'})
    
%
%   *********************
%   Solve with constraint
%   *********************
%
    [toutCONS,youtCONS,nMaxSteps] = GeneralRKScheme(@(t,x)(PendulumODE(x,t,pend)),@(t,x)(PendulumODEJac(x,t,pend)),@()(DormandPrinceTable),[l,0,0,0,0v ],[0,tEnd],NT,1);            