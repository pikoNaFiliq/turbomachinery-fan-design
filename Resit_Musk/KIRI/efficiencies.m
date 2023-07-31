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

if M_1 > =  1

    zeta_TE = (   ( 1 + ( (kg - 1 ) / 2 ) * M_a^2 )^(kg / ( kg - 1 ) ) - ( P_1 / P_a ) * ( 1 + ( ( kg - 1 )/ 2 ) * M_1^2 )^( kg / ( kg - 1 ) )   ) / ( ( 1 + ( ( kg - 1 ) / 2) * M_a^2 ) - 1 );
    
end


zeta_all = zeta_TE + zeta_SL + zeta_BL;  % Total Loss


