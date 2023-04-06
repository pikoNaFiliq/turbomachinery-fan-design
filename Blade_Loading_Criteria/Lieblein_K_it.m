function [result] = Lieblein_K_it(max_th)
%UNTITLED22 Summary of this function goes here
%   Detailed explanation goes here

% define the polynomial coefficients
coeffs = dlmread("Lieblein_3.dat" ,',');

% define the range of x values
x = 0:0.001:0.1;

% evaluate the polynomial for the given range of x values
y = polyval(coeffs, x);

% Calculate the wanted value
result  = polyval(coeffs,max_th);


% % plot the polynomial function
% figure
% plot(x, y);
% hold on
% plot(max_th,result,"ro")
% xlabel("max thickness (t/c)")
% ylabel("Coefficient K_{i,t}")
% xlim([0,0.1])
% ylim([0,1.2])


end