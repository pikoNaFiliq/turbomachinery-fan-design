%%% trying


close all
clear all
clc


phi = 0.5;
psi = 0.3;
sol = 1.65;
max_th = 0.1;
a1 = 0 ;         % Inlet flow angle [degrees]

Re = 3 * 10^5;  %%%%%!!!!!!!!!!!!!!!!!!!

prof = 0;  %%%%!!!!!!!!!!!!!!

lamda = 2 * psi;

b1 = atand( tand(a1) - 1 / phi);

R = - psi / 2  - phi * tand(a1) + 1 ;

b2 = atand( 1 / phi *( psi + phi * tand(a1) - 1));

a2 = atand( tand(b2) + 1 / phi);

flow_defl = b1 - b2; % Flow deflection calculated from the velocity triangles



%% Howell's Loading Criterion

db_star = Howell_dbstar(abs(b2));  % Here we use the absolute value of b2
phi_coeff = Howell_Phi(Re);
psi_coeff = Howell_Psi(sol);
db_H = Howell_delta_b(db_star,phi_coeff,psi_coeff);


%% Camber angle thita

%%% Calculations for delta_0
Kd_sh     = Lieblein_Kd_sh(prof);
Kd_t      = Lieblein_K_delta(max_th);
d0_10     = Lieblein_delta0_10(sol,abs(b1));  % Here we use the absolute value of b1
delta_0   = Lieblein_delta_0(Kd_sh,Kd_t,d0_10);  


%%% Calculations for i_0

i0_10 = Lieblein_i0_10(sol,abs(b1));    % Here we use the absolute value of b1
Ki_t  =  Lieblein_K_it(max_th);
i_0   = Lieblein_i0(i0_10,Ki_t,prof);



%%% Calculations for the rest of the parameters that theta needs

m_coeff = Lieblein_M_coeff(abs(b1),prof);
exp_b = Lieblein_expo_b(abs(b1));
n_coeff = Lieblein_n_coeff(sol,abs(b1));

theta = camber(b1,b2,delta_0,i_0,m_coeff,sol,exp_b,n_coeff);


%% Incidence and Deviation angles

in_angle = Lieblein_inc(i_0,n_coeff,theta);


dev_angle = Lieblein_deviation(delta_0,m_coeff,sol,exp_b,theta);
