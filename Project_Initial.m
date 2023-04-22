%%%%%% Turbomachinery Projet %%%%%%%%%%
clear all
close all
clc
%% Data provided

p_1 = 22632 ;          % Atmospheric pressure [Pa]
T_1 = -56.5 + 273.15 ; % Temperature [K]
rho_1 = 0.3639;        % Atmospheric Density [kg/m^3]
k = 1.4;               % Specific heat ratio for air
R = 287;               % Gas constant [J/kgK]
Cp = 1005;             % Specific heat capacity ratio for constant pressure [J/kgK]
m = 270 ; % Design Mass Flow Rate [kg/s]

M_1 = 0.8;                       % Mach Number at the inlet 
V_1 = M_1 * sqrt(k * R * T_1);   % Velocity at the inlet

A_1 = m / (rho_1 * V_1);         % Area at the inlet of the fan


n = 3342 * pi() / 30 ; % Rotational Speed [rad/s]

b_tt = 1.4 ; % Design total to total pressure ratio [-]


% Results from the fmincon

%x_opt = !!!! 
[phi,psi,sol_rt,max_th_rt,sol_st,max_th_st] =  deal(x_opt(1),x_opt(2),x_opt(3),x_opt(4),x_opt(5),x_opt(6));



%% Calculation for the inlet of the rotor( station 1)

pt_1 = p_1 * ( 1 + ( (k - 1) / 2 ) * M_1^2 ) ^ (k / (k - 1)) ;      % Total pressure at the inlet [Pa]
Tt_1 = T_1 * ( 1 + ( (k - 1) / 2 ) * M_1^2 ) ;                      % Total Temperature at the inlet [K]
rhot_1 = rho_1 * ( 1 + ( (k - 1) / 2 ) * M_1^2 ) ^ ( - (k - 1)  ) ; % Total density at the inlet [kg/m^3]

%% Calculations fpor the outlet of the rotor ( station 2)

Tt_2 = Tt_1 * b_tt^((k-1) / k);   % Total temperature at the outlet of the rotor [K]
pt_2 = pt_1 * b_tt;               % Total pressure at the outlet of the rotor [Pa]

w = Cp * ( Tt_2 - Tt_1);    % Specific work done by the fan [J/kg]

U = sqrt(w / psi);   % Peripheral speed at the mean radius

r_mean = U / n ;   % Mean radius ( also design radius)

Vm = phi * U_mean;  % Meridional (Axial) Velocity (constant throughout) [m/s]

%%%% Velocity triangles

a1 = 0 ;         % Inlet flow angle [degrees]

lamda = 2 * psi;

b1 = atand( tand(a1) - 1 / phi);

R = - psi / 2  - phi * tand(a1) + 1 ;

b2 = atand( 1 / phi *( psi + phi * tand(a1) - 1));

a2 = atand( tand(b2) + 1 / phi);

a3 = a1 ; % assuming REPEATED STAGES


V_1_me = Vm / cosd(a1) ;   % Absolute Velocity at the inlet of the rotor [m/s]   !!!!

V_2 = Vm / cosd(a2) ;   % Absolute Velocity at the outlet of the rotor [m/s]

V_3 = Vm / cosd(a3) ;   % Absolute Velocity at the outlet of the stator [m/s]

W_1 = Vm / cosd(b1) ;   % Relative Velocity at the inlet of the rotor [m/s]

W_2 = Vm / cosd(b2) ;   % Relative Velocity at the outlet of the rotor [m/s]

T_1_me = Tt_1 - (0.5/Cp) * V_1^2;   % Static temperature at the inlet of the rotor [K]!!!!!!
T_2 = Tt_2 - (0.5/Cp) * V_2^2;   % Static temperature at the outlet of the rotor  [K]

p_1_me = pt_1 / (Tt_1 / T_1)^( k / ((k - 1) * n_p)); % Static pressire at the inlet of the rotor  [Pa] !!!!
p_2 = pt_2 / (Tt_2 / T_2)^( k / ((k - 1) * n_p)); % Static pressire at the outlet of the rotor [Pa]

rho_1_me = p_1/(R_gas * T_1);           % Static pressure at the inlet of the rotor ,assuming IDEAL GAS [kg/m^3]!!!!
rho_2 = p_2/(R_gas * T_2);           % Static pressure at the outlet of the rotor,assuming IDEAL GAS [kg/m^3]

A_1_me = m / (rho_1 * Vm);         % Area at the inlet of the rotor  [m^2] !!!!!
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
AR_st = 6;    % Aspect Ratio for the stator [-] !!!!!!!!!!!!

l_ax_rt = H_1 / AR_rt;   % Axial chord for the rotor [m]
l_ax_st = H_2 / AR_st;   % Axial chord for the stator [m] 

pitch_rt = l_ax_rt / sol_rt;  % Pitch for the rotor  [m]
pitch_st = l_ax_st / sol_st;  % Pitch for the stator [m]


N_rt = (2 * pi() * r_mean) / pitch_rt ; % Number of blades for the rotor !!!!!!

N_st = (2 * pi() * r_mean) / pitch_st ; % Number of blades for the stator !!!!!




%% Stability - Recovery Ratio

R_R = ( cosd(b2)^2 * tand(b2) / phi ) - (cosd(a1)^2 * cosd(b2)^2 * tand(a1) * tand(b2) / phi^2) + (cosd(a1)^2 * tand(a1) / phi);


