function [result] = Lieblein_M_coeff(b1,profile)
%choose profile type, 0 = DCA profile, 1 = NACA profile


%% Using the data provided by the graphs
data = dlmread('Lieblein_6.dat', ',');
% 1st line  -> solidity = 2.0
% Last line -> solidity = 0.4


[row,columns] = size(data);
coeffs = zeros(row,columns);
for i=1:row

    coeffs(i,:) = data(i,:); % Getting the coefficients of each individual graph


end

%% Making the plots of all the lines
% define the range of x values
x = 0:0.1:70;


% evaluate the polynomial for the given range of x values
for i=1:row
    y(i,:) = polyval(coeffs(i,:), x);
end


% % plot the polynomial function
% figure
% plot(x, y);
% hold on
% xlabel("\beta_1 (^o)")
% ylabel(" m coefficient (^o)")
% xlim([0,70])
% ylim([0,0.4])
%% Checking which line we should use to calculate our output
if profile == 0 
    result = polyval(coeffs(1,:),b1);
    %plot(b1,result,"ro")
    %legend("DCA profile", "NACA-65 profile")
elseif profile == 1 
    result = polyval(coeffs(2,:),b1);
   % plot(b1,result,"ro")
   % legend("DCA profile", "NACA-65 profile")
else 
    print("Choose a type value, 0 = DCA, 1 = NACA65")
end
end

    
