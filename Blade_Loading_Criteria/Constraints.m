function [c,ceq] = Constraints(x)
%function that computes the inequality constraints
global couplings
    x0 = couplings.x0;
    
    x = x .* abs(x0);
    
 %% Set the design variables
[phi,psi,sol_rt,max_th_rt,sol_st,max_th_st] =  deal(x(1),x(2),x(3),x(4),x(5),x(6));
%% calculate velocity triangles and flow deflections
a1 = 0 ;         % Inlet flow angle [degrees]

Re = 3 * 10^5;  %%%%%!!!!!!!!!!!!!!!!!!!

prof = 0;  %%%%!!!!!!!!!!!!!!

lamda = 2 * psi;

b1 = atand( tand(a1) - 1 / phi);

R = - psi / 2  - phi * tand(a1) + 1 ;

b2 = atand( 1 / phi *( psi + phi * tand(a1) - 1));

a2 = atand( tand(b2) + 1 / phi);
a3 = a1 ; % assuming REPEATED STAGES

flow_defl_beta = abs(b1 - b2);
flow_defl_alpha = abs(a2 - a1);

%% Howell's Loading Criterion for Rotor

db_star = Howell_dbstar(abs(b2));  % Here we use the absolute value of b2
phi_coeff_rt = Howell_Phi(Re);
psi_coeff_rt = Howell_Psi(sol_rt);
db_H_rt = Howell_delta_b(db_star,phi_coeff_rt,psi_coeff_rt);


%% Howell's Loading Criterion for Stator
db_star_st = Howell_dbstar(abs(a3));  % Here we use the absolute value of b2
phi_coeff_st = Howell_Phi(Re);
psi_coeff_st = Howell_Psi(sol_st);
db_H_st = Howell_delta_b(db_star_st,phi_coeff_st,psi_coeff_st);

%% Inequality Constraints
c1 = (flow_defl_beta/db_H_rt) - 1;
c2 = (flow_defl_alpha/db_H_st) - 1;

c = [c1,c2];
ceq = [];
end

