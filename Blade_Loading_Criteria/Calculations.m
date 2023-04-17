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



%% Camber angle thita

%%% Calculations for delta_0
Kd_sh     = Lieblein_Kd_sh(prof);
Kd_t      = Lieblein_K_delta(max_th_rt);
d0_10     = Lieblein_delta0_10(sol_rt,abs(b1));  % Here we use the absolute value of b1
delta_0   = Lieblein_delta_0(Kd_sh,Kd_t,d0_10);  


%%% Calculations for i_0

i0_10 = Lieblein_i0_10(sol_rt,abs(b1));    % Here we use the absolute value of b1
Ki_t  =  Lieblein_K_it(max_th_rt);
i_0   = Lieblein_i0(i0_10,Ki_t,prof);



%%% Calculations for the rest of the parameters that theta needs

m_coeff = Lieblein_M_coeff(abs(b1),prof);
exp_b = Lieblein_expo_b(abs(b1));
n_coeff = Lieblein_n_coeff(sol_rt,abs(b1));

theta = camber(b1,b2,delta_0,i_0,m_coeff,sol_rt,exp_b,n_coeff);


%% Incidence and Deviation angles

in_angle = Lieblein_inc(i_0,n_coeff,theta);


dev_angle = Lieblein_deviation(delta_0,m_coeff,sol_rt,exp_b,theta);



%% Calculation of the objective function

% The deviation calculated by the Howell's Loading Criterion should be
% equal to the deviation that is calculated by the velovity triangles

obj = abs( abs(db_H_rt) - abs(flow_defl_rt));




end