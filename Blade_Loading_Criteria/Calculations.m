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

%%% Calculations for delta_0_st 
Kd_sh_st     = Lieblein_Kd_sh(prof);
Kd_t_st      = Lieblein_K_delta(max_th_st);
d0_10_st     = Lieblein_delta0_10(sol_st,abs(a2));  % Here we use the absolute value of a2
delta_0_st   = Lieblein_delta_0(Kd_sh_st,Kd_t_st,d0_10_st);  


%%% Calculations for i_0_st

i0_10_st = Lieblein_i0_10(sol_st,abs(a2));    % Here we use the absolute value of a2
Ki_t_st  =  Lieblein_K_it(max_th_st);
i_0_st   = Lieblein_i0(i0_10_st,Ki_t_st,prof);



%%% Calculations for the rest of the parameters that theta_st needs

m_coeff_st = Lieblein_M_coeff(abs(a2),prof);
exp_b_st = Lieblein_expo_b(abs(a2));
n_coeff_st = Lieblein_n_coeff(sol_st,abs(a2));

theta_st = camber(a2,a3,delta_0_st,i_0_st,m_coeff_st,sol_st,exp_b_st,n_coeff_st);




%% Incidence and Deviation angles for ROTOR

in_angle_rt = Lieblein_inc(i_0_rt,n_coeff_rt,theta_rt);


dev_angle_rt = Lieblein_deviation(delta_0_rt,m_coeff_rt,sol_rt,exp_b_rt,theta_rt);


%% Incidence and Deviation angles for STATOR

in_angle_st = Lieblein_inc(i_0_st,n_coeff_st,theta_st);


dev_angle_st = Lieblein_deviation(delta_0_st,m_coeff_st,sol_st,exp_b_st,theta_st);



%% Calculation for the profile losses for ROTOR

DF_rt = 0.45 ; % Typical value for the Diffusion Factor

th_c_rt = 0.0804 * DF_rt^2 - 0.0272 * DF_rt + 0.0071; % theta over c value for rotor

Y_rt = th_c_rt * ( sol_rt / cosd(b2) ) * ( cosd(b1) / cosd(b2) )^2 ; % Y value for rotor

dpsi_loss_rt = (Y_rt * phi^2) / ( 2 * (cosd(b1))^2 );  % Loss of psi for the rotor

%% Calculation for the profile losses for STATOR

DF_st = 0.45 ; % Typical value for the Diffusion Factor

th_c_st = 0.0804 * DF_st^2 - 0.0272 * DF_st + 0.0071; % theta over c value for stator

Y_st = th_c_st * ( sol_st / cosd(a3) ) * ( cosd(a2) / cosd(a3) )^2 ; % Y value for stator

dpsi_loss_st = (Y_st * phi^2) / ( 2 * (cosd(a2))^2 );  % Loss of psi for the stator




%% Objective Function

% Now the objective function is calculated
% We want to minimize the profile losses in both stator and rotor

obj = dpsi_loss_st + dpsi_loss_rt ; % Adding both losses 






% %% Calculation of the objective function
% 
% % The deviation calculated by the Howell's Loading Criterion should be
% % equal to the deviation that is calculated by the velovity triangles
% 
% obj = abs( abs(db_H_rt) - abs(flow_defl_rt));



end