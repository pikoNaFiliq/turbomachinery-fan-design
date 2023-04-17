function [obj] = Calculations(x)


%% Set the design variables
[phi,psi,sol_rt,max_th_rt] =  deal(x(1),x(2),x(3),x(4));

%% Calculate the velocity triangles


a1 = 0 ;         % Inlet flow angle [degrees]

Re = 3 * 10^5;  %%%%%!!!!!!!!!!!!!!!!!!!

prof = 0;  %%%%!!!!!!!!!!!!!!

lamda = 2 * psi;

b1 = atand( tand(a1) - 1 / phi);

R = - psi / 2  - phi * tand(a1) + 1 ;

b2 = atand( 1 / phi *( psi + phi * tand(a1) - 1));

a2 = atand( tand(b2) + 1 / phi);

a3 = a1 ; % assuming REPEATED STAGES

flow_defl_rt = b1 - b2; % Flow deflection calculated from the velocity triangles for the rotor

flow_def_st = a2 - a3;  % Flow deflection calculated from the velocity triangles for the stator


%% Howell's Loading Criterion for ROTOR

db_star_rt = Howell_dbstar(abs(b2));  % Here we use the absolute value of b2
phi_coeff_rt = Howell_Phi(Re);
psi_coeff_rt = Howell_Psi(sol_rt);
db_H_rt = Howell_delta_b(db_star_rt,phi_coeff_rt,psi_coeff_rt);

%% Howell's Loading Criterion for STATOR
da_star_st = Howell_dbstar(abs(a3));  % Here we use the absolute value of b2
phi_coeff_st = Howell_Phi(Re);
psi_coeff_st = Howell_Psi(sol_st);
db_H_st = Howell_delta_b(db_star_st,phi_coeff_st,psi_coeff_st);


%% Camber angle theta for ROTOR

%%% Calculations for delta_0_rt 
Kd_sh_rt     = Lieblein_Kd_sh(prof);
Kd_t_rt      = Lieblein_K_delta(max_th_rt);
d0_10_rt     = Lieblein_delta0_10(sol_rt,abs(b1));  % Here we use the absolute value of b1
delta_0_rt   = Lieblein_delta_0(Kd_sh_rt,Kd_t_rt,d0_10_rt);  


%%% Calculations for i_0_rt

i0_10_rt = Lieblein_i0_10(sol_rt,abs(b1));    % Here we use the absolute value of b1
Ki_t_rt  =  Lieblein_K_it(max_th_rt);
i_0_rt   = Lieblein_i0(i0_10_rt,Ki_t_rt,prof);



%%% Calculations for the rest of the parameters that theta_rt needs

m_coeff_rt = Lieblein_M_coeff(abs(b1),prof);
exp_b_rt = Lieblein_expo_b(abs(b1));
n_coeff_rt = Lieblein_n_coeff(sol_rt,abs(b1));

theta_rt = camber(b1,b2,delta_0_rt,i_0_rt,m_coeff_rt,sol_rt,exp_b_rt,n_coeff_rt);

%% Camber angle theta for STATOR


%% Incidence and Deviation angles

in_angle = Lieblein_inc(i_0_rt,n_coeff_rt,theta_rt);


dev_angle = Lieblein_deviation(delta_0_rt,m_coeff_rt,sol_rt,exp_b_rt,theta_rt);



%% Calculation of the objective function

% The deviation calculated by the Howell's Loading Criterion should be
% equal to the deviation that is calculated by the velovity triangles

obj = abs( abs(db_H_rt) - abs(flow_defl_rt));




end