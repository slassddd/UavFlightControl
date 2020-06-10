function  servo_out=get_servo_out_pitch(  angle_err,   scaler,   disable_integrator)

global gains_tau_pitch
global aspeed
global max_rate_neg
global gains_rmax_pitch
% Function returns an equivalent elevator deflection in centi-degrees in the range from -4500 to 4500
% A positive demand is up
% Inputs are: 
% 1) demanded pitch angle in centi-degrees
% 2) control gain scaler = scaling_speed / aspeed
% 3) boolean which is true when stabilise mode is active
% 4) minimum FBW airspeed (metres/sec)
% 5) maximum FBW airspeed (metres/sec)
%
 
	% Calculate offset to pitch rate demand required to maintain pitch angle whilst banking
	% Calculate ideal turn rate from bank angle and airspeed assuming a level coordinated turn
	% Pitch rate offset is the component of turn rate about the pitch axis
 

    if (gains_tau_pitch < 0.1)  
        gains_tau_pitch=0.1;
    end
     

    [rate_offset,inverted] = get_coordination_rate_offset();
	
	% Calculate the desired pitch rate (deg/sec) from the angle error
	  desired_rate = angle_err * 0.01 / gains_tau_pitch;
	
	% limit the maximum pitch rate demand. Don't apply when inverted
	% as the rates will be tuned when upright, and it is common that
	% much higher rates are needed inverted	
    if (~inverted)  		
        if (max_rate_neg && desired_rate < -max_rate_neg)  
			desired_rate = -max_rate_neg;
        elseif (gains_rmax_pitch && desired_rate > gains_rmax_pitch)  
			desired_rate = gains_rmax_pitch;           
        end
    end
     
    if (inverted)
		desired_rate = -desired_rate;
    end

	% Apply the turn correction offset
	desired_rate = desired_rate + rate_offset;

    servo_out=get_rate_out_pitch(desired_rate, scaler, disable_integrator, aspeed);
 

end

