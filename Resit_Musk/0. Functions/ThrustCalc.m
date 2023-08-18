function thrust_total = ThrustCalc(power_lpt,T_t_aft)

    function thrust = ThrustFan(power_turbine)
    thrust = power_turbine/225.4;
    end

    function thrust = ThrustNozzle (T_t)
    T_nozzle = T_t * 2 / (constants.gamma +1);
    v_jet = sqrt(constants.gamma*constants.R*T_nozzle);
    thrust = constants.mdot*(v_jet-constants.v_inf);
    end
    
    thrust_total = ThrustNozzle(T_t_aft) + ThrustFan(power_lpt);


end
