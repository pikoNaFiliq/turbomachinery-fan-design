function [c,ceq] = Constraints(x)
%function that computes the inequality constraints
global couplings
    x0 = couplings.x0;
    
    x = x .* abs(x0);
    
 %% Set the design variables
%[phi,psi,sol_rt,max_th_rt,sol_st,max_th_st] =  deal(x(1),x(2),x(3),x(4),x(5),x(6));
[phi_mean,psi_mean,P_LPT] = deal(x(1),x(2),x(3));

T_LF = P_LPT/225.4;

global couplings
T_J = couplings.T_J;

%% Call the global variables


%% Inequality Constraints
c1 = (1.4 * (47000 * 9.80665))/(T_LF + T_J) - 1;
%c2 = (omega*Rt/800) - 1; 


c = [c1];
ceq = [];
end
