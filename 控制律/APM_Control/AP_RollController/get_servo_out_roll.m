function servo_out=get_servo_out_roll(  angle_err,   scaler,   disable_integrator)
 global gains_tau_roll
%  Function returns an equivalent aileron deflection in centi-degrees in the range from -4500 to 4500
%  A positive demand is up
%  Inputs are: 
%  1) demanded bank angle in centi-degrees
%  2) control gain scaler = scaling_speed / aspeed
%  3) boolean which is true when stabilise mode is active
%  4) minimum FBW airspeed (metres/sec)
  
 
    if (gains_tau_roll < 0.1)  
        gains_tau_roll=0.1;
    end
	
	% Calculate the desired roll rate (deg/sec) from the angle error
	  desired_rate = angle_err * 0.01 / gains_tau_roll;

    servo_out=get_rate_out_roll(desired_rate, scaler, disable_integrator);
 

end

