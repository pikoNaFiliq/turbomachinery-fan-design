function [] = Lieblein_dev_theta(sol,b1)

%% Using the data provided by the graphs
data = dlmread('Lieblein_4.dat', ',');
% 1st line  -> solidity = 2.0
% Last line -> solidity = 0.4

coeffs = zeros(length(data),width(data));
for i=1:length(data)

    coeffs(i,:) = data(i,:); % Getting the coefficients of each individual graph


end

solidity = round(sol,1); % We are rounding solidity so we get the closest graph for it
