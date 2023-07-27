function pr = PressureStaticTotal(gamma,mach)
    pr = (1 + (gamma-1)/2*mach^2)^(-gamma/(gamma-1));
end