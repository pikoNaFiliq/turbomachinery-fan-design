function [delta] = deviation(d0,m_coeff,sol,exp_b,theta)
% The deviation angle is calculated based on the data provided

% m_coeff,exp_b  have their x and y values(from their figures) in their two columns repsectively based on the chosen solidity value


%% m_coeff
coeff_1 = polyfit(m_coeff(:,1) , m_coeff(:,2) , 9);       % Polynomial Coefficients
y1 = polyval(coeff_1,b1);   

%% exp_b
coeff_2 = polyfit(exp_b(:,1) , exp_b(:,2) , 9);       % Polynomial Coefficients
y2 = polyval(coeff_2,b1); % Calculate m_coeff for the given b1

%% result

delta = d0 + (y1 / sol^y2) * theta;

end