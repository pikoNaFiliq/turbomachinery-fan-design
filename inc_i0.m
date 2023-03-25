function [i0] = inc_i0(Ki_sh,Ki_t,i0_10,B1,max_th)
% The i0 is calculated based on the data provided

% Ki_t,i0_10 have their x and y values(from their figures) in their two columns repsectively based on the chosen solidity value


%% Ki,t
coeff_1 = polyfit(Ki_t(:,1) , Ki_t(:,2) , 9);       % Polynomial Coefficients
y1 = polyval(coeff_1,max_th);                       % Calculate Ki,t for the givem maximum thickness

%% i0_10
coeff_3 = polyfit(i0_10(:,1) , i0_10(:,2) , 9);     % Polynomial Coefficients
y2 = polyval(coeff_3,b1);                           % Calculate i0_10 for the given b1

%% result

i0 = Ki_sh * y1 * y2;

end