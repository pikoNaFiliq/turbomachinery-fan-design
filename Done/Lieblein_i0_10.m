function [result] = Lieblein_i0_10(sol,b1)
%Lieblein_1 We calculate the i0_10 for the given values of solidity and b1

%% Using the data provided by the graphs
data = dlmread('Lieblein_1.dat', ',');
% 1st line  -> solidity = 2.0
% Last line -> solidity = 0.4

coeffs = zeros(length(data),width(data));
for i=1:length(data)

    coeffs(i,:) = data(i,:); % Getting the coefficients of each individual graph


end

solidity = round(sol,1); % We are rounding solidity so we get the closest graph for it

%% Making the plots of all the lines
% define the range of x values
x = 0:0.1:70;


% evaluate the polynomial for the given range of x values
for i=1:length(data)
    y(i,:) = polyval(coeffs(i,:), x);
end


% plot the polynomial function
figure
plot(x, y);
hold on
xlabel("\beta_1 (^o)")
ylabel("(i_0)_{10} (^o)")
xlim([0,70])
ylim([0,10])









%% Checking which line we should use to calculate our output
if solidity > 2
    print("Solidity value >2, Check")
end

if (solidity <= 2) && (solidity >= 1.9)


    result = polyval(coeffs(1,:),b1)
    plot(b1,result,"ro")
    legend("\sigma = 2","\sigma = 1.8","\sigma = 1.6","\sigma = 1.4","\sigma = 1.2","\sigma = 1","\sigma = 0.8","\sigma = 0.6","\sigma = 0.4","Our Point",'Location','best')




elseif (solidity >= 1.7)

    result = polyval(coeffs(2,:),b1)
    plot(b1,result,"ro")
    legend("\sigma = 2","\sigma = 1.8","\sigma = 1.6","\sigma = 1.4","\sigma = 1.2","\sigma = 1","\sigma = 0.8","\sigma = 0.6","\sigma = 0.4","Our Point",'Location','best')



elseif (solidity >= 1.5)

    result = polyval(coeffs(3,:),b1)
    plot(b1,result,"ro")
    legend("\sigma = 2","\sigma = 1.8","\sigma = 1.6","\sigma = 1.4","\sigma = 1.2","\sigma = 1","\sigma = 0.8","\sigma = 0.6","\sigma = 0.4","Our Point",'Location','best')


elseif (solidity >= 1.3)

    result = polyval(coeffs(4,:),b1)
    plot(b1,result,"ro")
    legend("\sigma = 2","\sigma = 1.8","\sigma = 1.6","\sigma = 1.4","\sigma = 1.2","\sigma = 1","\sigma = 0.8","\sigma = 0.6","\sigma = 0.4","Our Point",'Location','best')


elseif (solidity >= 1.1)

    result = polyval(coeffs(5,:),b1)
    plot(b1,result,"ro")
    legend("\sigma = 2","\sigma = 1.8","\sigma = 1.6","\sigma = 1.4","\sigma = 1.2","\sigma = 1","\sigma = 0.8","\sigma = 0.6","\sigma = 0.4","Our Point",'Location','best')


elseif (solidity >= 0.9)

    result = polyval(coeffs(6,:),b1)
    plot(b1,result,"ro")
    legend("\sigma = 2","\sigma = 1.8","\sigma = 1.6","\sigma = 1.4","\sigma = 1.2","\sigma = 1","\sigma = 0.8","\sigma = 0.6","\sigma = 0.4","Our Point",'Location','best')


   

elseif (solidity >= 0.7)

    result = polyval(coeffs(7,:),b1)
    plot(b1,result,"ro")
    legend("\sigma = 2","\sigma = 1.8","\sigma = 1.6","\sigma = 1.4","\sigma = 1.2","\sigma = 1","\sigma = 0.8","\sigma = 0.6","\sigma = 0.4","Our Point",'Location','best')



elseif (solidity >= 0.5)

    result = polyval(coeffs(8,:),b1)
    plot(b1,result,"ro")
    legend("\sigma = 2","\sigma = 1.8","\sigma = 1.6","\sigma = 1.4","\sigma = 1.2","\sigma = 1","\sigma = 0.8","\sigma = 0.6","\sigma = 0.4","Our Point",'Location','best')



else

    result = polyval(coeffs(9,:),b1)
    plot(b1,result,"ro")
    legend("\sigma = 2","\sigma = 1.8","\sigma = 1.6","\sigma = 1.4","\sigma = 1.2","\sigma = 1","\sigma = 0.8","\sigma = 0.6","\sigma = 0.4","Our Point",'Location','best')


end

end

    
