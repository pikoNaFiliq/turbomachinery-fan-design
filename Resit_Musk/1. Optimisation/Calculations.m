function [obj] = Calculations(x)


%% Set the design variables
[phi,psi,power,r_tip,omega] =  deal(x(1),x(2),x(3),x(4),x(5));

%% Calculate the number of stages
mdot = 212; %kg
U_blade = r_tip*omega;

n_stages = ceil(power/(mdot*(U_blade^2)*psi));

sp_power = power/(n_stages*mdot);

%% Calculate the velocity triangles
a0 = 0; %degrees
a2 = a0;
b2 = atand(tand(a2)-1/phi);
a1 = atand((psi/phi)+tand(b2)+1/phi);
b1 = atand(tand(a1)-1/phi);


R = psi/2 - phi*tand(a1) + 1;
Vm = phi*U_blade;
V1 = Vm/cosd(a1);  %velocity at the intlet of the turbine
V2 = Vm/cosd(a2);  %velocity at the outlet of the turbine 

%% Calculate the thermodynamic properties
T1 = Tt1 - 0.5*V1^2/Cp;
M1 = V1/sqrt(gamma*R*T1);

%% 








