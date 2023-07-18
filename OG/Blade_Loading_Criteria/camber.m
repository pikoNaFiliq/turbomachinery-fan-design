function [theta] = camber(b1,b2,d0,i0,m_coeff,sol,exp_b,n_coeff)
%CAMBER Here the camber angle is calculated based on the data provided



%% Flow deflection
delta_b = b1 - b2 ; % !!!!!!! Flow deflection

%% result

theta = (delta_b + d0 - i0) / (1 - m_coeff / (sol^exp_b) + n_coeff );
end