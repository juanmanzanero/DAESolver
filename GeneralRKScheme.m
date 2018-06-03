function [tout,xout,varargout] = GeneralRKScheme(ODE,Jacobian,RKTable,x0,tInt,NT,no_of_constraints)
%
%   Linear solver configuration
%   ---------------------------
    NEWTON_TOLERANCE = 1.0e-10;  
    NEWTON_MAXSTEPS = 100;
%
%   Get the ODE specs
%   -----------------
    nEqn = length(x0);
    ti = linspace(tInt(1),tInt(2),NT);
    dt = (tInt(2)-tInt(1))/(NT-1);
    no_of_ODEs = nEqn - no_of_constraints;

    M = eye(nEqn);                 % Mass matrix
    M(no_of_ODEs+1:nEqn,no_of_ODEs+1:nEqn) = 0;
%
%   Get the RK scheme specs
%   -----------------------
    [Nstages, a, b, c] = RKTable();
%
%   Perform the time integration
%   ----------------------------
    xout = zeros(nEqn,NT);
    xout(:,1) = x0;
%
%   Define the array or Runge-Kutta steps
%   -------------------------------------
    dimPrb = nEqn*Nstages;
    k0 = zeros(dimPrb,1);
    k  = zeros(dimPrb,1);
    x  = zeros(nEqn,1);
    pos_f = @(stage)(nEqn*(stage-1)+1:nEqn*stage);
    oneEq_f = @(eq)(eq:nEqn:dimPrb);
    f0 = zeros(dimPrb,1);
    J = zeros(dimPrb,1);
    NewtonMaxSteps = zeros(NT-1,1);
    
    for n = 1: NT-1
%
%       ************************************************
%       Perform Newton iterations to get the RK stages k
%       ************************************************
%
        k0 = zeros(dimPrb,1);   % TODO better seed for k0? (e.g. from explicit RK?)
        k  = zeros(dimPrb,1);
        for iter = 1 : NEWTON_MAXSTEPS 
            for s = 1:Nstages
%
%               Construct the ODEs evaluation point
%               -----------------------------------
                for eq = 1:nEqn
                    x(eq) = xout(eq,n) + dt*dot(a(s,:),k0(oneEq_f(eq))); 
                end
%
%               Construct Newton iterations RHS
%               -------------------------------
                f0(pos_f(s)) = ODE(ti(n)+c(s)*dt,x)-diag(M).*k0(pos_f(s));                
%
%               Construct the Jacobian row that corresponds to the stage
%               --------------------------------------------------------
                A = Jacobian(ti(n)+c(s)*dt,x);
                
                for s2 = 1:Nstages
                    J(pos_f(s),pos_f(s2)) = dt*A*a(s,s2);
                end
%
%               Substract the mass matrix
%               -------------------------
                J(pos_f(s),pos_f(s)) = J(pos_f(s),pos_f(s)) - M;
            end
%
%           Solve the system
%           ----------------
            k = k0-J\f0;            
            k0 = k;
%
%           Check the convergence
%           ---------------------
            if ( abs(f0) < NEWTON_TOLERANCE ) 
                NewtonMaxSteps(n) = iter;
                break;
            end

        end     % Newton iterations
%
%       ****************************************
%       Get the new x value from the RK stages k
%       ****************************************
%
        xout(:,n+1) = xout(:,n);
        for s = 1:Nstages
            xout(:,n+1) = xout(:,n+1) + dt * b(s) * k(pos_f(s));
        end
    end
    
    tout = ti;

    if (nargout == 3)
        varargout{1} = NewtonMaxSteps;
    end

end

