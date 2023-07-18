
classdef CommonConversions
    properties
    end
    methods(Static,Access=public)
        function rads = rpm2rads(rpm)
            rads = rpm*2*pi/60;
        end
    
        function rpm = rads2rpm(rads)
            rpm = rads/2/pi*60;
        end
    end  
end