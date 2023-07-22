function [c,ceq] = Constraints(x)

global couplings
    x0 = couplings.x0;
    
    x = x .* abs(x0)
    
    %% Set the design variables
    [phi,psi,power] =  deal(x(1),x(2),x(3));
    
    %% U blade calculations
    
mdot = 212; %kg
n_stages = 1;
a0 = 0: %degrees
sp_power = power/(n_stages*mdot);

U_blade = sqrt(sp_power/psi);  %U_blade based on the mean chord

%% inequality constraints
c1 = [];