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
Rt_1 = sqrt(A_1 / pi);           % Radius at the tip ( Assuming that Rh is small compared to Rt)

n = 3342 * pi() / 30 ; % Rotational Speed [rad/s]

b_tt = 1.4 ; % Design total to total pressure ratio [-]




%% Calculation for the inlet of the rotor( station 1)

pt_1 = p_1 * ( 1 + ( (k - 1) / 2 ) * M_1^2 ) ^ (k / (k - 1)) ;      % Total pressure at the inlet [Pa]
Tt_1 = T_1 * ( 1 + ( (k - 1) / 2 ) * M_1^2 ) ;                      % Total Temperature at the inlet [K]
rhot_1 = rho_1 * ( 1 + ( (k - 1) / 2 ) * M_1^2 ) ^ ( - (k - 1)  ) ; % Total density at the inlet [kg/m^3]

%% Calculations fpor the outlet of the rotor ( station 2)

Tt_2 = Tt_1 * b_tt^((k-1) / k);   % Total temperature at the outlet of the rotor

w = Cp * ( Tt_2 - Tt_1);    % Specific work done by the fan [J/kg]



%% Duty Coefficients and angles

% Here we define the two duty coefficients and a1

phi = 0.5;       % Flow Coefficient
psi = 0.3;       % Work Coefficient
a1 = 0 ;         % Inlet flow angle [degrees]

lamda = 2 * psi;

b1 = atand( tand(a1) - 1 / phi);

R = - psi / 2  - phi * tand(a1) + 1 ;

b2 = atand( 1 / phi *( psi + phi * tand(a1) - 1));

a2 = atand( tand(b2) + 1 / phi);


%% Stability - Recovery Ratio

R_R = ( cosd(b2)^2 * tand(b2) / phi ) - (cosd(a1)^2 * cosd(b2)^2 * tand(a1) * tand(b2) / phi^2) + (cosd(a1)^2 * tand(a1) / phi);


