function delta = FlowDeviation(gamma,Ma,M1,beta)
    gg1 = gamma/(gamma-1);
    g1g1 = gamma+1/(gamma-1);
    tb = tan(beta);
    P1Pa = PressureStaticTotal(g,M1)/PressureStaticTotal(g,Ma);
    x = gg1 * P1Pa * tb - ...
        sqrt((1-P1Pa)*(2*gg1*Ma^2 -1-g1g1*P1Pa)+(gg1*P1Pa*tb)^2)/...
        (1+gamma*Ma^2-P1Pa);
    delta = atan(x);
end