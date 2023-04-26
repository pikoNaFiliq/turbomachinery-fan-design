%%%%%% Turbomachinery Projet %%%%%%%%%%
clear all
close all
clc
%% Data provided

p_inf = 22632 ;          % Atmospheric pressure [Pa]
T_inf = -56.5 + 273.15 ; % Temperature [K]
rho_inf = 0.3639;        % Atmospheric Density [kg/m^3]
k = 1.4;               % Specific heat ratio for air
R = 287;               % Gas constant [J/kgK]
Cp = 1005;             % Specific heat capacity ratio for constant pressure [J/kgK]
m = 270 ; % Design Mass Flow Rate [kg/s]

M_1 = 0.8;                       % Mach Number at the inlet 
V_inf = M_1 * sqrt(k * R * T_inf);   % Velocity at the inlet

A_inf = m / (rho_inf * V_inf);         % Area at the inlet of the fan


n = 3342 * pi() / 30 ; % Rotational Speed [rad/s]

b_tt = 1.4 ; % Design total to total pressure ratio [-]


% Results from the fmincon

x_opt = [0.475,0.358,0.6,0.06,1.33,0.06];
[phi,psi,sol_rt,max_th_rt,sol_st,max_th_st] =  deal(x_opt(1),x_opt(2),x_opt(3),x_opt(4),x_opt(5),x_opt(6));



%% Calculation for the inlet of the rotor( station 1)
n_is = 0.9104;
ratio = 1 +  (b_tt^( (k - 1 ) / k) - 1)  / n_is;

pt_1 = p_inf * ( 1 + ( (k - 1) / 2 ) * M_1^2 ) ^ (k / (k - 1)) ;      % Total pressure at the inlet [Pa]
Tt_1 = T_inf * ( 1 + ( (k - 1) / 2 ) * M_1^2 ) ;                      % Total Temperature at the inlet [K]
rhot_1 = rho_inf * ( 1 + ( (k - 1) / 2 ) * M_1^2 ) ^ ( - (k - 1)  ) ; % Total density at the inlet [kg/m^3]

%% Calculations fpor the outlet of the rotor ( station 2)

Tt_2 = Tt_1 * ratio;   % Total temperature at the outlet of the rotor [K]
pt_2 = pt_1 * b_tt;               % Total pressure at the outlet of the rotor [Pa]

w = Cp * ( Tt_2 - Tt_1);    % Specific work done by the fan [J/kg]

U_mean = sqrt(w / psi);   % Peripheral speed at the mean radius

r_mean = U_mean / n ;   % Mean radius ( also design radius)

Vm = phi * U_mean;  % Meridional (Axial) Velocity (constant throughout) [m/s]

%%%% Velocity triangles

a1 = 0 ;         % Inlet flow angle [degrees]

lamda = 2 * psi;

b1 = atand( tand(a1) - 1 / phi);

R = - psi / 2  - phi * tand(a1) + 1 ;

b2 = atand( 1 / phi *( psi + phi * tand(a1) - 1));

a2 = atand( tand(b2) + 1 / phi);

a3 = a1 ; % assuming REPEATED STAGES

n_p = 1; % Polytropic efficiency
R_gas = 287; 


V_1 = Vm / cosd(a1) ;   % Absolute Velocity at the inlet of the rotor [m/s]   !!!!

V_2 = Vm / cosd(a2) ;   % Absolute Velocity at the outlet of the rotor [m/s]

V_3 = Vm / cosd(a3) ;   % Absolute Velocity at the outlet of the stator [m/s]

W_1 = Vm / cosd(b1) ;   % Relative Velocity at the inlet of the rotor [m/s]

W_2 = Vm / cosd(b2) ;   % Relative Velocity at the outlet of the rotor [m/s]

T_1 = Tt_1 - (0.5/Cp) * V_1^2;   % Static temperature at the inlet of the rotor [K]!!!!!!
T_2 = Tt_2 - (0.5/Cp) * V_2^2;   % Static temperature at the outlet of the rotor  [K]

p_1 = pt_1 / (Tt_1 / T_1)^( k / ((k - 1) * n_p)); % Static pressire at the inlet of the rotor  [Pa] !!!!
p_2 = pt_2 / (Tt_2 / T_2)^( k / ((k - 1) * n_p)); % Static pressire at the outlet of the rotor [Pa]

rho_1 = p_1/(R_gas * T_1);           % Static pressure at the inlet of the rotor ,assuming IDEAL GAS [kg/m^3]!!!!
rho_2 = p_2/(R_gas * T_2);           % Static pressure at the outlet of the rotor,assuming IDEAL GAS [kg/m^3]

A_1 = m / (rho_1 * Vm);         % Area at the inlet of the rotor  [m^2] !!!!!
A_2 = m / (rho_2 * Vm);         % Area at the outlet of the rotor [m^2]

H_1 = A_1 / (2 * pi() * r_mean);   % Blade Height of rotor  at the inlet[m]
H_2 = A_2 / (2 * pi() * r_mean);   % Blade Height of rotor at the outlet[m]

r_hub_1 = (2 * r_mean - H_1) / 2;  % Radius at the hub of the rotor (inlet)[m]
r_hub_2 = (2 * r_mean - H_2) / 2;  % Radius at the hub of the stator (inlet) [m]

r_tip_1 = H_1 + r_hub_1;             % Radius at the tip of the rotor (inlet) [m]
r_tip_2 = H_2 + r_hub_2;             % Radius at the tip of the stator (inlet)[m]


M_1_me =  V_1 / sqrt(k * R_gas * T_1); % Mach number at the inlet of the rotor [-] !!!!!
M_2 =  V_2 / sqrt(k * R_gas * T_2); % Mach number at the outlet of the rotor [-]


AR_rt = 6;    % Aspect Ratio for the rotor  [-] !!!!!!!!!!!!
AR_st = 4;    % Aspect Ratio for the stator [-] !!!!!!!!!!!!

l_ax_rt = H_1 / AR_rt;   % Axial chord for the rotor [m]
l_ax_st = H_2 / AR_st;   % Axial chord for the stator [m] 

pitch_rt = l_ax_rt / sol_rt;  % Pitch for the rotor  [m]
pitch_st = l_ax_st / sol_st;  % Pitch for the stator [m]


N_rt = (2 * pi() * r_mean) / pitch_rt ; % Number of blades for the rotor !!!!!!

N_st = (2 * pi() * r_mean) / pitch_st ; % Number of blades for the stator !!!!!




%% Stability - Recovery Ratio

R_R = ( cosd(b2)^2 * tand(b2) / phi ) - (cosd(a1)^2 * cosd(b2)^2 * tand(a1) * tand(b2) / phi^2) + (cosd(a1)^2 * tand(a1) / phi);


%%%%%%%%%%%%%%%%%%%%% Incidence and deviation angles %%%%%%%%%%%%%%%%%%%%%%

Re = 3 * 10^5;  %%%%%!!!!!!!!!!!!!!!!!!!

prof = 0;  %%%%!!!!!!!!!!!!!!

flow_defl_rt = b1 - b2; % Flow deflection calculated from the velocity triangles for the rotor

flow_defl_st = a2 - a3;  % Flow deflection calculated from the velocity triangles for the stator


%% Howell's Loading Criterion for ROTOR

db_star_rt = Howell_dbstar(abs(b2));  % Here we use the absolute value of b2
phi_coeff_rt = Howell_Phi(Re);
psi_coeff_rt = Howell_Psi(sol_rt);
db_H_rt = Howell_delta_b(db_star_rt,phi_coeff_rt,psi_coeff_rt);

%% Howell's Loading Criterion for STATOR
db_star_st = Howell_dbstar(abs(a3));  % Here we use the absolute value of b2
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


