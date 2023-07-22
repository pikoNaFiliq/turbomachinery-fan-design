function [obj] = Calculations(x)


%% Set the design variables
[phi,psi,power] =  deal(x(1),x(2),x(3));


%% Calculate the velocity triangles
n_stages = 1;
a0 = 0: %degrees

U_blade = sqrt(power/psi);  %U_blade based on the mean chord
Vm = phi*U_blade;

b2 = atand(-1/phi);
a1 = atand((psi/phi)+tand(b2)+1/phi));
b1 = atand(tand(a1)-1/phi);

R = psi/2 - phi*tand(a1) + 1;

%% Calculate the thrust










