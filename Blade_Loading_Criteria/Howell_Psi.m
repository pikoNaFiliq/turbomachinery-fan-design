function [result] = Howell_Psi(sol)
%Howell_Psi :  The Coefficinet Psi for the Howell's Criterion is calculated
%               based on the given solidity


% define the polynomial coefficients
coeffs = dlmread('H_1.txt', ',');

% define the range of x values
x = 0.4:0.1:1.6;

% evaluate the polynomial for the given range of x values
y = polyval(coeffs, x);

% Calculate the wanted value

result = polyval(coeffs, 1 / sol);

% plot the polynomial function
figure
plot(x, y);
hold on
plot(1/sol,result,"ro")
xlabel("s/c = 1 / \sigma")
ylabel("Coefficient \Psi")
xlim([0.4,1.6])






end