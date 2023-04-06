function [result] = Lieblein_deviation(delta_0,m_coeff,sol,exp_b,theta)
% The deviation angle is calculated based on the data provided



result = delta_0 + (m_coeff / (sol^exp_b) ) * theta;


end