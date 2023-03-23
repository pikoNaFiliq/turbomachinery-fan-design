%%%%%% Turbomachinery Projet %%%%%%%%%%
clear all
close all
clc
%% Data provided

p_0 = 22632 ;          % Atmospheric pressure [Pa]
T_0 = -56.5 + 273.15 ; % Temperature [K]
rho_0 = 0.3639;        % Atmospheric Density [kg/m^3]
k = 1.4;               % Specific heat ratio for air
R = 287;               % Gas constant [J/kgK]
m = 270 ; % Design Mass Flow Rate [kg/s]

M_0 = 0.8;   % Mach Number at the inlet 
V_0 = M_0 * sqrt(k * R * T_0);

A_0 = m / (rho_0 * V_0);
Rt_0 = sqrt(A_0 / pi);

n = 3342 ; % Rotational Speed [rpm]

b_tt = 1.4 ; % Design total to total pressure ratio [-]




%% Calculation for the inlet conditions

pt_0 = p_0 * ( 1 + ( (k - 1) / 2 ) * M_0^2 ) ^ (k / (k - 1)) ; % Total pressure at the inlet [Pa]
Tt_0 = T_0 * ( 1 + ( (k - 1) / 2 ) * M_0^2 ) ; % Total Temperature at the inlet [K]
rhot_0 = rho_0 * ( 1 + ( (k - 1) / 2 ) * M_0^2 ) ^ ( - (k - 1)  ) ; % Total density at the inlet [kg/m^3]


%% Duty Coefficients and angles

phi = 0.5;     % Flow Coefficient
psi = 0.3;       % Work Coefficient
a1 = 0 ;       % Inlet flow angle [degrees]

lamda = 2 * psi;

b1 = atand( tand(a1) - 1 / phi);

R = - psi / 2  - phi * tand(a1) + 1 ;

b2 = atand( 1 / phi *( psi + phi * tand(a1) - 1));

a2 = atand( tand(b2) + 1 / phi);


%% Stability - Recovery Ratio

R_R = ( cosd(b2)^2 * tand(b2) / phi ) - (cosd(a1)^2 * cosd(b2)^2 * tand(a1) * tand(b2) / phi^2) + (cosd(a1)^2 * tand(a1) / phi);


