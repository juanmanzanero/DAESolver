clear all
clc
close all

addpath('./RungeKuttaTables');
addpath('./Physics');
addpath('./Schemes');
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
    x0 = [1,0];
    NT = 20000;
    tEnd = 10.0;
%
%   ****************************
%   Solve by natural coordinates
%   ****************************
%
    theta0 = atan2(x0(1),-x0(2));
%
%   Using RadauIIA solver
%   ---------------------
    [toutRIIA,youtRIIA,nMaxSteps] = GeneralRKScheme(@(t,x)(PendulumODE_reduced(x,t,pend)),@(t,x)(PendulumODE_reducedJac(x,t,pend)),@()(RadauIIATable),[theta0,0],[0,tEnd],NT,0);
%

%   Using Prince-Dormand
%   --------------------
%    [toutPD,youtPD,nMaxSteps] = GeneralRKScheme(@(t,x)(PendulumODE_reduced(x,t,pend)),@(t,x)(PendulumODE_reducedJac(x,t,pend)),@()(DormandPrinceTable),[theta0,0],[0,tEnd],NT,0);            
    
%
%   *********************
%   Solve with constraint
%   *********************
%
    [toutCONS,youtCONS,nMaxSteps] = GeneralRKScheme(@(t,x)(PendulumDAE(x,t,pend)),@(t,x)(PendulumDAEJac(x,t,pend)),@()(RadauIIATable),[x0(1),0,x0(2),0,0 ],[0,tEnd],NT,1);            
   
%
%   Use ODE15s
%   ----------
%    M = eye(5);
%    M(3:5,3:5) = 0;
%    options = odeset('Mass',M,'RelTol',1e-4,'AbsTol',1e-10);
%    [tODE15s,yODE15s] = ode15s(@(t,x)(PendulumDAE_index1(x,t,pend)),[0,tEnd],[1,0,0,0,0],options);    
%
%   *************************
%   Comparison of theta angle
%   *************************
%    
    h = figure;
    hold on;
    plot(toutRIIA, youtRIIA(1,:),'LineWidth',2);
    plot(toutCONS,atan2(youtCONS(1,:),-youtCONS(3,:)),'LineWidth',2)
 
    h.CurrentAxes.LineWidth = 2;
    h.CurrentAxes.FontSize = 24;  
    xlabel('$t$ ($s$), $N_T=20000$','interpreter','latex');
    ylabel('$\theta$','interpreter','latex')
    legend({'ODE::RIIA','DAE-3idx::RIIA'},'orientation','horizontal')    
    h.CurrentAxes.XMinorTick='on';
    h.CurrentAxes.YMinorTick='on';
