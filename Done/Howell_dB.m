function [result] = Howell_dB(b2)
%UNTITLED13 Summary of this function goes here


% define the polynomial coefficients
coeffs = dlmread('H_3.txt', ',');

% define the range of x values
x = 0:0.1:50;

% evaluate the polynomial for the given range of x values
y = polyval(coeffs, x);

% Calculate the wanted value
result  = polyval(coeffs,b2);


% plot the polynomial function
figure
plot(x, y);
hold on
plot(b2,result,"ro")
xlabel("\beta_2 (^o)")
ylabel("\Delta\beta^*/(\Phi\Psi) (^o)")
xlim([0,50])
ylim([10,40])



end