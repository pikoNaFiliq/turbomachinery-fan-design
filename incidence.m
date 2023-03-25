function [inc] = incidence(i0,n_coeff,theta)
%INCIDENCE The incidence angle is calculated here using the data provided 
%          by the figures from the lecture notes 




% n_coeff has it's x and y values(from the figure) in it's two columns repsectively based on the chosen solidity value

%% n_coeff
coeff_1 = polyfit(n_coeff(:,1) , n_coeff(:,2) , 9); % Polynomial Coefficients
y1 = polyval(coeff_1,b1);                           % Calculate n_coeff for the given b1 

 

%% Incidence angle i

inc = i0 + y1 * theta;

end