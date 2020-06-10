function [rate_offset, inverted]=get_coordination_rate_offset(  )  

%   get the rate offset in degrees/second needed for pitch in body frame
%   to maintain height in a coordinated turn.
%   
%   Also returns the inverted flag and the estimated airspeed in m/s for
%   use by the rest of the pitch controller
global roll
global pitch
global EAS2TAS
global GRAVITY_MSS
global roll_ff_pitch
global airspeed_min
global aspeed
global HD;
 
 	  bank_angle =  roll;

	% limit bank angle between +- 80 deg if right way up
	
    if (abs(bank_angle) < radians(90))	 
	    bank_angle = constrain_value (bank_angle,-radians(80),radians(80));
        inverted = 0;  
    else  
		inverted = 1;	
        if (bank_angle > 0.0)  
			bank_angle = constrain_value(bank_angle,radians(100),radians(180));		  
        else  
			bank_angle = constrain_value(bank_angle,-radians(180),-radians(100));
        end
    end
	 
    if (abs(pitch*HD*100) > 7000)  
        % don't do turn coordination handling when at very high pitch angles
        rate_offset = 0;    
    else  
        rate_offset = cos(pitch)*abs(HD*((GRAVITY_MSS / max((aspeed *EAS2TAS) ,  (airspeed_min))) * tan(bank_angle) * sin(bank_angle))) * roll_ff_pitch;
    end
    if (inverted)
		rate_offset = -rate_offset;
    end
  
end

