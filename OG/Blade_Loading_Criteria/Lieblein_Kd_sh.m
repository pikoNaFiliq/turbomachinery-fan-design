function [result] = Lieblein_Kd_sh(prof)
%UNTITLED7 Summary of this function goes here

if prof == 0
    result = 0.75;   % DCA profile

elseif prof == 1
    result = 1.1;    % NACA-65 profile
else
    print("Choose a type value, 0 = DCA, 1 = NACA65")
end

end