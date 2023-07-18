function thrust_total = ThrustCalc(power)

    function thrust = ThrustFan(power_turbine)
    thrust = power_turbine/225.4;
    end

    function thrust = ThrustNozzle (T_t)
    T_nozzle = T_t * 2 / (constants.gamma +1);
    v_jet = sqrt(constants.gamma*constants.R*T_nozzle);
    thrust = constants.mdot*(v_jet-constants.v_inf);
    end
    
    power_sp = power/constants.mdot; % specific power 
    Tt_1 = constants.Tt_in - power_sp/constants.cp;

    thrust_total = ThrustNozzle(Tt_1) + ThrustFan(power);


end
