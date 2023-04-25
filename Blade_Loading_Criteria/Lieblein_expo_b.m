function [result] = Lieblein_expo_b(b1)

% define the polynomial coefficients
coeffs = dlmread("Lieblein_7.dat" ,',');

% define the range of x values
x = 0:0.1:70;

% evaluate the polynomial for the given range of x values
y = polyval(coeffs, x);

% Calculate the wanted value
result  = polyval(coeffs,b1);


% plot the polynomial function
figure
plot(x, y);
hold on
plot(b1,result,"ro")
xlabel("\beta_1 (^o)")
ylabel("Exponent b")
xlim([0,70])
ylim([0,1])
