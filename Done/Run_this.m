%%% trying


close all
clear all
clc

sol = 1.65;
b1 = 54;
b2 = 35;
Re = 4*10^5;
max_th = 0.05;
prof = 1; % 1 -> DCA profile , 0 -> NACA-65 profile


d1 = Howell_Phi(Re);
d2 = Howell_Psi(sol);
d3 = Howell_dbstar(b2);

d4 = Lieblein_i0_10(sol,b1);
d5 = Lieblein_n_coeff(sol,b1);
d6 = Lieblein_K_it(max_th);



i0 = Lieblein_i0(d4,d5,d6,prof)
db = Howell_delta_b(d3,d1,d2)