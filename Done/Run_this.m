%%% trying


close all
clear all
clc

sol = 1.65;
b1 = 54;
b2 = 35;
Re = 4*10^5;
max_th = 0.05;


d1 = Howell_Phi(Re);
d2 = Howell_Psi(sol);
d3 = Howell_dB(b2);

d4 = Lieblein_i0_10(sol,b1);
d5 = Lieblein_n_coeff(sol,b1);
d6 = Lieblein_K_it(max_th);