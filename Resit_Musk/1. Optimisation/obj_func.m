function [mass,constraints] =obj_func(x)
    arguments
        x (1,10);
    end
    %% Decompress vector
    psi = x(1); % load coefficient
    phi = x(2); % flow coefficient

    %% Aircraft Data
    mtom = 47000; % [kg]
    T_min = 1.15 * mtom * constants.g; % [N]
    
    %% Basic Stage Relations
    beta_2 = atan(-1/phi);



end