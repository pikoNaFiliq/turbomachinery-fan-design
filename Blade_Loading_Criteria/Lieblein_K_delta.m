function [result] = Lieblein_K_delta(max_th)

% define the polynomial coefficients
coeffs = dlmread("Lieblein_5.dat" ,',');

% define the range of x values
x = 0:0.001:0.12;

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
% ylabel("Coefficient K_{\delta,t}")
% xlim([0,0.12])
% ylim([0,1.4])
