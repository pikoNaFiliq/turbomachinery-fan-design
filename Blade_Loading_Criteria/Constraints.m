function [c,ceq] = Constraints(x)
%function that computes the inequality constraints
[phi,psi,sol,max_th] =  deal(x(1),x(2),x(3),x(4));

%% calculate velocity triangles and flow deflections
a1 = 0 ;         % Inlet flow angle [degrees]

Re = 3 * 10^5;  %%%%%!!!!!!!!!!!!!!!!!!!

prof = 0;  %%%%!!!!!!!!!!!!!!

lamda = 2 * psi;

b1 = atand( tand(a1) - 1 / phi);

R = - psi / 2  - phi * tand(a1) + 1 ;

b2 = atand( 1 / phi *( psi + phi * tand(a1) - 1));

a2 = atand( tand(b2) + 1 / phi);

flow_defl_beta = b1 - b2;
flow_defl_alpha = a2 - a1;

%% Howell's Loading Criterion

db_star = Howell_dbstar(abs(b2));  % Here we use the absolute value of b2
phi_coeff = Howell_Phi(Re);
psi_coeff = Howell_Psi(sol);
db_H = Howell_delta_b(db_star,phi_coeff,psi_coeff);


%% Inequality Constraints
c1 = (flow_defl_beta/db_H) - 1;


c = [c1];
ceq = [];
end

