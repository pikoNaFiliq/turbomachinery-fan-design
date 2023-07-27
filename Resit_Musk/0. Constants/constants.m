classdef constants
   properties (Constant)
    %% World Properties
    g = 9.80665; % [m/s^2]
    %% Aircraft Properties
    mtow = 47000*constants.g;
    %% Gas Properties
    gamma = 1.33; % [-]
    cp = 1150; % [J/K/kg]
    R = 285.33; % [J/K/kg]
    %% Flow/Inlet Properties
    mdot = 212; % [kg/s]
    v_inf = 0; % [m/s]
    Pt_in = 1.76; % [bar]
    Tt_in = 1360 ;% [K]
    %% Constraints
    Thrust_req = 1.15 * constants.mtow; % [N]
    u_tip_max = 800; %[m/s]

    %% Design Parameters
    hub_tip_ratio = 0.6 %[-]
    rpm = 9160; % [rpm]

    %% Meangen Settings
    bf_le = 0.0000; % blockage factor leading edge
    bf_te = 0.0200; % blockage factor trailing edge
    blade_rotation = "N"; % no clue what this does tbh
    blade_twist = 0; % 1 --> Free Vortex 0 --> No twist
    design_point = "M"; % [H]ub, [M]id, or [T]ip
    flow_type = "AXI"; % Axi or Mix
    gap_row = 0.25; % Just taken from og file
    gap_stage = 0.5; % Just taken from og file
    QO_angle = 90; % set to 90 for now
    radius_method = "A" % B to input enthalpy change
    triangle_method = "A" % Look up the other options
    turbo_type = "T"; % C or T
    %% Multall Settings
    IM = 30;
    KM = 30;
        
    
    
    
    


   end
end