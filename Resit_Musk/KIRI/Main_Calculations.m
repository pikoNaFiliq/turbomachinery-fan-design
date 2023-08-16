%%%%%%%%%%%%%%%% RESIT 2023 %%%%%%%%%%%%%%%%%%%%%

% This is basically the OBJECTIVE FUNCTION  ( the calculations that need to be done )


clear all
close all
clc


%% Design Variables

%[phi,psi,sol_rt,max_th_rt,sol_st,max_th_st] =  deal(x(1),x(2),x(3),x(4),x(5),x(6));

%Ours
%[phi_mean,psi_mean,P_LPT,...

[phi_mean,psi_mean,P_LPT] = [0.8,1.5,1.3697e8];


%% Chosing of important variables for the calculations later
% We can also later check if we can put these in the optimization as design
% variables


T_LF = P_LPT / 225.4;  % Thrust produced bt the Lifting Fan [N]
omega_rpm = 9000;  % Rotational speed [rpm]
omega = omega_rpm * 2 * pi() / 60 ;  % Rotational speed [rad/s]

Rt_Rh = 1.35;  % R_tip / R_hub ratio [-] !!!!!!!!!!!!!!!!!!!!


%% Constants

g = 9.80665; % Gracity acceleration [m/s^2]
mtow = 47000* g ;  % Maximum Take Off Weight [ N ] 

%%%% Gas Properties
kg = 1.33; % [-]
cp = 1150; % [J/K/kg]
R_spec = 285.33; % [J/K/kg]

%%%% Flow/Inlet Properties at the LPT
mdot = 212; % [kg/s]
v_inf = 0; % [m/s]
p_inf = 1.0; % [bar]
Pt_in = 1.76; % [bar]
Tt_in = 1360 ;% [K]



%% Calculations

a1 = 0; % axial inflow [degrees]

R = psi/2 - phi*tand(a1) + 1 ;   % Reaction Coefficientat at mean
b1 = atand( tand(a1) - 1 / phi); % [degrees]
b2 = atand( tand(a1) - (psi + 1) / phi);  % [degrees]
a2 = atand( tand(b2) + 1 / phi); % [degrees]

%%%% The duty coefficients that were chosen are at the mean but in order to do the following calculations we should transform them to tip
% We know that (psi_tip / psi_mid) = (R_mid / R_tip)^2 if you assume free vortex design

psi_tip = psi_mid * (R_mean / R_tip)^2;

w_LPT = P_LPT / mdot;  % Specific work for the whole LPT [J/kg]

N_stages = 1;
w_LPT_stage = w_LPT / N_stages; % Initial Specific work per stage [J/kg]


U_calc = sqrt( w_LPT_stage / psi_tip); % Calculated rotational speed at the tip 


%%%% Checking the constraint in order to calculate the total number of stages needed
while (U_calc >= 800 )

    N_stages = N_stages + 1 ; % Incrementing the number of stages [-]
    w_LPT_stage_new = w_LPT / N_stages; % Reducing the specific work per stage [J/kg]

    U_calc = sqrt( w_LPT_stage_new / psi);

end


U_tip = U_calc;
w_LPT_stage = w_LPT_stage_new;


R_tip = U_tip / omega;   % Radius at the tip based on our calculations [m]
R_hub = R_tip / Rt_Rh;   % Radius at the hub based on our assumption [m]
R_mean = 0.5 * ( R_tip + R_hub);  % Radius at mean [m]

%%%%%%!!!!!!!!!! Now depends where did we pick the duty coeff!!!!
Vm = phi * U_tip; % !!!! Could me U_mean depending on them (Axial-Meridional Velocity)



DTt = P_LPT / ( mdot * cp) ;   % Total temperature difference over LPT
Tt_out = Tt_in - DTt;  % Total temperature at the outlet of the LPT

%%%% We will use isentropic relations for the calculation at the outlet of the LPT

n_is = 1;   % Isentropic efficiency assumed [-]
Pt_out = Pt_in * ( 1 - (1 / n_is) * ( 1 - Tt_out / Tt_in) )^(kg / ( kg - 1 ) );

%%%% Calculations for the nozzle %%%%%

n_nozzle = 1;    % Isentropic efficiency of the nozzle [-]
PR_crit = ( 1 - ( 1 / n_nozzle) * (kg - 1 ) / (kg + 1 ) )^(-kg / (kg - 1 ) );  % Critical Pressure Ratio [-]

T_8 = Tt_out * ( 2 / ( kg + 1 ));   % Static Temperature at the outlet of the nozzle
p_8 = Pt_out / PR_crit;             % Exit static pressure of the nozzle [bar]
V_8 = sqrt( kg * R_spec * T_8);     % Velocity at the exit of the nozzle [m/s]
rho_8 = p_8 / ( R_spec * T_8);      % Density at the exit of the nozzle [kg / m^3]
A_8 = mdot / ( rho_8 * V_8);        % Area of the nozzle at the exit [m^2]

T_J = mdot *( V_8 - v_inf ) + A_8 * ( p_8 - p_inf);  % Thrust from the nozzle [N]




%%%%%%%%%% Efficiencies %%%%%%%%%%%%%

%% Boundary Layer Loss

C_d = 0.002;  % B.L dissipation coefficient 
DV_V = 1 / sqrt(3);

zeta_BL = C_d * ( 2 * ( 1 / DV_V) + 6 * dv_v ) * ( tand(a2) - tand(a1) );   % B.L Loss


%% Shock Loss

if M_1 > 1 

    L = (2 / 3 ) * ( kg / ( kg + 1 )^2 ) * ( M_1^2 - 1 )^3;

else

    L = 0;

end

zeta_SL = ( T_1 * L * R_spec ) / ( 0.5 * V1^2); % Shock loss



%% Trailing Edge Losses

if M_1 >=  1

    zeta_TE = (   ( 1 + ( (kg - 1 ) / 2 ) * M_a^2 )^(kg / ( kg - 1 ) ) - ( P_1 / P_a ) * ( 1 + ( ( kg - 1 )/ 2 ) * M_1^2 )^( kg / ( kg - 1 ) )   ) / ( ( 1 + ( ( kg - 1 ) / 2) * M_a^2 ) - 1 );
    
end


zeta_all = zeta_TE + zeta_SL + zeta_BL;  % Total Loss





