function [result] = Howell_Phi(Re)
%Howell_Phi :  The Coefficinet Phi for the Howell's Criterion is calculated
%               based on the given Reynolds

% define the polynomial coefficients
coeffs = dlmread('H_2.txt', ',');

% define the range of x values
x = 10^5:1:5*10^5;

% evaluate the polynomial for the given range of x values
y = polyval(coeffs, x);

% Calculate the wanted value
result = polyval(coeffs,Re);

% 
% % plot the polynomial function
% figure
% plot(x, y);
% hold on
% plot(Re,result,"ro")
% xlabel("Re ")
% ylabel("Coefficient \Phi")






end