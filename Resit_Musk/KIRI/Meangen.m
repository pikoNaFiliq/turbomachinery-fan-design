V_0 = Vm / cosd(a1) ;   % Absolute Velocity at the inlet of the stator [m/s]   

V_1 = Vm / cosd(a2) ;   % Absolute Velocity at the outlet of the stator [m/s]

V_2 = Vm / cosd(a3) ;   % Absolute Velocity at the outlet of the rotor [m/s]

W_0 = Vm / cosd(b1) ;   % Relative Velocity at the inlet of the stator [m/s]

W_1 = Vm / cosd(b2) ;   % Relative Velocity at the outlet of the stator [m/s]

T_0 = Tt_0 - (0.5/cp) * V_0^2;   % Static temperature at the inlet of the stator [K]
T_1 = Tt_1 - (0.5/cp) * V_1^2;   % Static temperature at the outlet of the stator  [K]
T_2 = Tt_2 - (0.5/cp) * V_2^2;   % Static temperature at the outlet of the rotor  [K]

n_p = 1 ; % Polytropic Efficiency [-]

p_0 = pt_0 / (Tt_0 / T_0)^( kgg / ((kg - 1) * n_p));  % Static pressire at the inlet of the stator  [bar]
p_1 = pt_1 / (Tt_1 / T_1)^( kgg / ((kg - 1) * n_p));  % Static pressire at the outlet of the stator  [bar]
p_2 = pt_2 / (Tt_2 / T_2)^( kg / ((kg - 1) * n_p));   % Static pressire at the outlet of the rotor [bar]

rho_0 = p_0/(R_spec * T_0);           % Static pressure at the inlet of the stator ,assuming IDEAL GAS [kg/m^3]
rho_1 = p_1/(R_spec * T_1);           % Static pressure at the outlet of the stator ,assuming IDEAL GAS [kg/m^3]
rho_2 = p_2/(R_spec * T_2);           % Static pressure at the outlet of the rotor,assuming IDEAL GAS [kg/m^3]

A_0 = m / (rho_0 * Vm);         % Area at the inlet of the stator  [m^2]
A_1 = m / (rho_1 * Vm);         % Area at the otulet of the stator  [m^2] 
A_2 = m / (rho_2 * Vm);         % Area at the outlet of the rotor [m^2]

H_0 = A_0 / (2 * pi() * R_mean);   % Blade Height of stator  at the inlet[m]
H_1 = A_1 / (2 * pi() * R_mean);   % Blade Height of stator  at the outlet[m]
H_2 = A_2 / (2 * pi() * R_mean);   % Blade Height of rotor at the outlet[m]

r_hub_0 = (2 * R_mean - H_0) / 2;  % Radius at the hub of the stator (inlet)[m]
r_hub_1 = (2 * R_mean - H_1) / 2;  % Radius at the hub of the stator (outlet)[m]
r_hub_2 = (2 * R_mean - H_2) / 2;  % Radius at the hub of the rotor (outlet) [m]

r_tip_0 = H_0 + r_hub_0;             % Radius at the tip of the stator (inlet) [m]
r_tip_1 = H_1 + r_hub_1;             % Radius at the tip of the stator (outlet) [m]
r_tip_2 = H_2 + r_hub_2;             % Radius at the tip of the rotor (outlet)[m]

M_0 =  V_0 / sqrt(kg * R_spec * T_0); % Mach number at the inlet of the stator [-] 
M_1 =  V_1 / sqrt(kg * R_spec * T_1); % Mach number at the outlet of the stator [-] 
M_2 =  V_2 / sqrt(kg * R_spec * T_2); % Mach number at the outlet of the rotor [-]


% AR_rt = 6;    % Aspect Ratio for the rotor  [-] !!!!!!!!!!!!
% AR_st = 6;    % Aspect Ratio for the stator [-] !!!!!!!!!!!!
% 
% l_ax_rt = H_1 / AR_rt;   % Axial chord for the rotor [m]
% l_ax_st = H_0 / AR_st;   % Axial chord for the stator [m] 
% 
% pitch_rt = l_ax_rt / sol_rt;  % Pitch for the rotor  [m]
% pitch_st = l_ax_st / sol_st;  % Pitch for the stator [m]
% 
% 
% N_rt = (2 * pi() * R_mean) / pitch_rt ; % Number of blades for the rotor 
% 
% N_st = (2 * pi() * R_mean) / pitch_st ; % Number of blades for the stator 

