function [theta] = camber(b1,b2,d0,i0,m_coeff,sol,exp_b,n_coeff)
%CAMBER Here the camber angle is calculated based on the data provided

% n_coeff have their x and y values(from their figures) in their two columns repsectively based on the chosen solidity value



%% Flow deviation
delta_b = b1 - b2 ; % !!!!!!! Flow deviation 

%% m_coeff
coeff_1 = polyfit(m_coeff(:,1) , m_coeff(:,2) , 9);       % Polynomial Coefficients
y1 = polyval(coeff_1,b1);                                 % Calculate m_coeff for the given b1

%% exp_b
coeff_2 = polyfit(exp_b(:,1) , exp_b(:,2) , 9);       % Polynomial Coefficients
y2 = polyval(coeff_2,b1);                             % Calculate exponent b for the given b1

%% n_coeff
coeff_3 = polyfit(n_coeff(:,1) , n_coeff(:,2) , 9);       % Polynomial Coefficients
y3 = polyval(coeff_3,b1);                                 % Calculate n_coeff for the givem maximum thickness

%% result

theta = (delta_b + d0 - i0) / (1 - m_coeff / sol^exp_b + n_coeff );
end