function [d_0] = delta_0(Kd_sh,Kd_t,d0_10,b1,max_th)
% The d_0 is calculated based on the data provided

% Kd_t,d0_10 have their x and y values(from their figures) in their two columns repsectively based on the chosen solidity value


%% Kd_t 
coeff_1 = polyfit(Kd_t(:,1) , Kd_t(:,2) , 9); % Polynomial Coefficients
y1= polyval(coeff_1,max_th);                  % Calculate Kd_t for the given maximum thickness

%% d0_10
coeff_2 = polyfit(d0_10(:,1) , d0_10(:,2) , 9); % Polynomial Coefficients
y2= polyval(coeff_2,b1);                        % Calculate d0_10 for the given b1

%% result

d_0 = Kd_sh * y1 * y2;



end