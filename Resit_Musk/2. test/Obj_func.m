function [y,c,ceq] = Obj_func(x,constants)
    arguments
        x (1,4);
        constants
    end

    %% DEFINE VARIABLES FOR EASY USE
    power = x(1);
    psi = x(2); % w/u^2
    phi = x(3);
    AR = x(4);

    
    
    rads = CommonConversions.rpm2rads(constants.rpm); % [rad/s]
   
    %% CALCULATE TURBINE PROPERTIES
    % Calculate reaction
    reaction = psi/2 -phi*tan(alpha_1) + 1 ;

    % CALCULATE r_mean, num_stages, u_tip
    num_stages = 1;
    u_tip = constants.u_tip_max + 1;   
    while u_tip>constants.u_tip_max
        w_stage = power/constants.mdot/num_stages; 
        u_mean = sqrt(w_stage/psi); % [m/s] peripheral speed at mean
        r_mean = u_mean/rads; % [m] mean radius
        r_tip = 2*r_mean/(1+constants.hub_tip_ratio); % [m] tip radius
        u_tip = r_tip * rads; % [m/s] peripheral speed at tip
        if u_tip>constants.u_tip_max
            num_stages = num_stages + 1;
        end
    end

    % CALCULATE blade height and axial chord
    r_hub = r_tip*constants.hub_tip_ratio; % [m] hub radius
    b = r_tip - r_hub; % [m] blade span
    c = s/AR;

    % Calculate the velocity triangles
    a0 = 0; %degrees
    a2 = a0;
    b2 = atand(tand(a2)-1/phi);
    a1 = atand((psi/phi)+tand(b2)+1/phi);
    b1 = atand(tand(a1)-1/phi);
    
    Vax = phi*U_blade;
    V1 = Vax/cosd(a1);  %velocity at the intlet of the turbine
    V2 = Vax/cosd(a2);  %velocity at the outlet of the turbine 

    % CALCULATE deviation rotor and stator
    T1 = constants.Tt_in - V1^2/(2*constants.cp);
    c1 = sqrt(constants.gamma*constants.R*T1); % [m/s] speed of sound
    M1 = V1/c1;

   

    delta_stator = 1;
    delta_rotor = 1;
    i_stator = -2; 
    i_rotor = -2;

    % CALCULATE max thickness and location of max thickness of airfoils
    t_max_stator = 0.3; % max thickness stator
    loc_t_max_stator = 0.45; % x location max thickness stator

    t_max_rotor = 0.3; % max thickness rotor
    loc_t_max_rotor = 0.45; % x location max thickness rotor

    %% COMMANDS USED TO START THE EXECUTABLES
    meangen_cmd = "meangen";
    stagen_cmd = 'stagen';
    multall_cmd = 'multall <stage_new.dat';
    

    %% STARTING THE MULTALL PROCEDURE

    cd("0. Multall\")
    %% WRITE THE MEANGEN.IN FILE
    WriteMeangenInputFile(num_stages,constants.rpm,0.9,reaction,phi,psi, ...
                    r_mean,delta_stator,delta_rotor, ...
                    i_stator,i_rotor,t_max_stator,loc_t_max_stator, ...
                    t_max_rotor, loc_t_max_rotor,c,c)

    
    

   
    % Inequality Constraints
        
    
    % Output Inequality Constraints
%     c = [c_v,c_ws];

    % Equality Constraints
    
    % Output Equality Constraints
%     ceq = [ceq_fuel,ceq_wing,ceq_L,ceq_D];

end 