function [obj] = Objective(x)



%% Design Variables

%[phi,psi,sol_rt,max_th_rt,sol_st,max_th_st] =  deal(x(1),x(2),x(3),x(4),x(5),x(6));



global couplings
    x0 = couplings.x0;
    
    x = x .* abs(x0);

    %Ours
[phi_mean,psi_mean,P_LPT] = deal(x(1),x(2),x(3));


%% Chosing of important variables for the calculations later
% We can also later check if we can put these in the optimization as design
% variables


T_LF = P_LPT / 225.4;  % Thrust produced bt the Lifting Fan [N]
omega_rpm = 9000;  % Rotational speed [rpm]
omega = omega_rpm * 2 * pi() / 60 ;  % Rotational speed [rad/s]

Rm_Rt = 0.5;  % R_mean / R_tip ratio [-] !!!!!!!!!!!!!!!!!!!! NOT SURE ABOUT THAT TBH


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

%a1 = 0; % axial inflow [degrees]

%R = psi_mean/2 - phi_mean*tand(a1) + 1 ;   % Reaction Coefficientat at mean
%b1 = atand( tand(a1) - 1 / phi_mean); % [degrees]
%b2 = atand( tand(a1) - (psi_mean + 1) / phi_mean);  % [degrees]
%a2 = atand( tand(b2) + 1 / phi_mean); % [degrees]

%a3 = a1 ; % Repeated stages


a0 = 0; %degrees
a2 = a0;
b2 = atand(tand(a2)-1/phi_mean);
a1 = atand((psi_mean/phi_mean)+tand(b2)+1/phi_mean);
b1 = atand(tand(a1)-1/phi_mean);


R = psi_mean/2 - phi_mean*tand(a1) + 1;

%%%% The duty coefficients that were chosen are at the mean but in order to do the following calculations we should transform them to tip
% We know that (psi_tip / psi_mid) = (R_mid / R_tip)^2 if you assume free vortex design
psi_tip = psi_mean * (Rm_Rt)^2;    
w_LPT = P_LPT / mdot;  % Specific work for the whole LPT [J/kg]


err = 1000;
while (err > 0.1)

    N_stages = 1;
    w_LPT_stage = w_LPT / N_stages; % Initial Specific work per stage [J/kg]
    
    
    U_calc = sqrt( w_LPT_stage / psi_tip); % Calculated rotational speed at the tip 
    
    
    %%%% Checking the constraint in order to calculate the total number of stages needed
    while (U_calc >= 800 )
    
        N_stages = N_stages + 1 ; % Incrementing the number of stages [-]
        w_LPT_stage = w_LPT / N_stages; % Reducing the specific work per stage [J/kg]
    
        U_calc = sqrt( w_LPT_stage / psi_tip);
    
    end
    
    
    U_tip = U_calc;
    
    
    R_tip = U_tip / omega;   % Radius at the tip based on our calculations [m]
    R_mean = R_tip * Rm_Rt;  % Radius at mean based on our assumption [m]
    R_hub = 2 * R_mean - R_tip; % Radius at the hub [m]


    % Now because we calculate R_mean and R_tip, I think it is wise to
    % recompute their ratio and compare it with what we have assumed at the
    % beginning. If the error is high we should redo the calculations.

    err = abs( ( Rm_Rt - (R_mean/R_tip)) / Rm_Rt );  % NOT SURE IF THIS IS THE CORRECT WAY TO DEFINE IT
    if err > 0.1
        Rm_Rt = R_mean/R_tip;
    end


end

U_mean = omega * R_mean;

Vm = phi_mean * U_mean; % Meridional velocity [m/s]



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
rho_8 = (p_8 * 10^5) / ( R_spec * T_8);      % Density at the exit of the nozzle [kg / m^3]
A_8 = mdot / ( rho_8 * V_8);        % Area of the nozzle at the exit [m^2]

T_J = mdot *( V_8 - v_inf ) + A_8 * ( p_8 - p_inf);  % Thrust from the nozzle [N]

couplings.T_J = T_J;

%%%% Calculations for the FIRST stage %%%%

V_0 = Vm / cosd(a0) ;   % Absolute Velocity at the inlet of the stator [m/s]   

V_1 = Vm / cosd(a1) ;   % Absolute Velocity at the outlet of the stator [m/s]

V_2 = Vm / cosd(a2) ;   % Absolute Velocity at the outlet of the rotor [m/s]

W_1 = Vm / cosd(b1) ;   % Relative Velocity at the inlet of the rotor [m/s]

W_2 = Vm / cosd(b2) ;   % Relative Velocity at the outlet of the rotor [m/s]

Tt_0 = Tt_in;
Tt_1 = Tt_0;
Tt_2 = Tt_1 - w_LPT_stage / cp;


T_0 = Tt_0 - (0.5/cp) * V_0^2;   % Static temperature at the inlet of the stator [K]
T_1 = Tt_1 - (0.5/cp) * V_1^2;   % Static temperature at the outlet of the stator  [K]
T_2 = Tt_2 - (0.5/cp) * V_2^2;   % Static temperature at the outlet of the rotor  [K]

n_p = 1 ; % Polytropic Efficiency [-]
n_is = 1;

b_tt = ( 1 - (1 / n_is) * ( 1 - Tt_2 / Tt_1) )^( kg / ( kg - 1 ) );
pt_0 = Pt_in;
pt_1 = pt_0;
pt_2 = pt_1 * b_tt;

p_0 = pt_0 / (Tt_0 / T_0)^( kg / ((kg - 1) * n_p));  % Static pressire at the inlet of the stator  [bar]
p_1 = pt_1 / (Tt_1 / T_1)^( kg / ((kg - 1) * n_p));  % Static pressire at the outlet of the stator  [bar]
p_2 = pt_2 / (Tt_2 / T_2)^( kg / ((kg - 1) * n_p));   % Static pressire at the outlet of the rotor [bar]

rho_0 = (p_0*10^5)/(R_spec * T_0);           % Static pressure at the inlet of the stator ,assuming IDEAL GAS [kg/m^3]
rho_1 = (p_1*10^5)/(R_spec * T_1);           % Static pressure at the outlet of the stator ,assuming IDEAL GAS [kg/m^3]
rho_2 = (p_2*10^5)/(R_spec * T_2);           % Static pressure at the outlet of the rotor,assuming IDEAL GAS [kg/m^3]

A_0 = mdot / (rho_0 * Vm);         % Area at the inlet of the stator  [m^2]
A_1 = mdot / (rho_1 * Vm);         % Area at the otulet of the stator  [m^2] 
A_2 = mdot / (rho_2 * Vm);         % Area at the outlet of the rotor [m^2]

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

display(M_1)
%%%%%%%%%% Efficiencies %%%%%%%%%%%%%

%% Boundary Layer Loss

C_d = 0.002;  % B.L dissipation coefficient 
DV_V = 1 / sqrt(3);

zeta_BL = C_d * ( 2 * ( 1 / DV_V) + 6 * DV_V ) * ( tand(a1) );   % B.L Loss


%% Shock Loss

if M_1 > 1 

    L = (2 / 3 ) * ( kg / ( kg + 1 )^2 ) * ( M_1^2 - 1 )^3;

else

    L = 0;

end

zeta_SL = ( T_1 * L * R_spec ) / ( 0.5 * V_1^2); % Shock loss



%% Trailing Edge Losses

if M_1 >=  1
    
    P1_P0 = (T_1/T_0)^(kg / (kg - 1 ) );  % P_1/P_0 assuming n_p = 1
    P1_Pa = P1_P0 * PR_crit; % P_1/P_a
    M_a = 1;
    zeta_TE = (   ( 1 + ( (kg - 1 ) / 2 ) * M_a^2 )^(kg / ( kg - 1 ) ) - ( P1_Pa ) * ( 1 + ( ( kg - 1 )/ 2 ) * M_1^2 )^( kg / ( kg - 1 ) )   ) / ( ( 1 + ( ( kg - 1 ) / 2) * M_a^2 ) - 1 );

else
    zeta_TE = 0;
end

zeta_all = zeta_TE + zeta_SL + zeta_BL;  % Total Loss

obj = zeta_all;




end
