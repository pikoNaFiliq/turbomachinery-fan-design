function [i0] = Lieblein_i0(i0_10,n_coeff,Kit_coeff,prof)
%UNTITLED23 Summary of this function goes here
%   Detailed explanation goes here

if prof == 1
    Ki_sh = 0.7 ; % DCA profiles
else
    Ki_sh = 1.1;  % NACA-65 profiles
end

i0 = Ki_sh * Kit_coeff * i0_10;

end