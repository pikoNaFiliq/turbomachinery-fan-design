function [c,ceq] = Constraints(x)
%function that computes the inequality constraints
global couplings
    x0 = couplings.x0;
    
    x = x .* abs(x0);
    
 %% Set the design variables
%[phi,psi,sol_rt,max_th_rt,sol_st,max_th_st] =  deal(x(1),x(2),x(3),x(4),x(5),x(6));


%% Inequality Constraints
c1 = 1.4 * (47000 * 9.80665) - ( T_LF + T_J);



c = [c1];
ceq = [];
end
