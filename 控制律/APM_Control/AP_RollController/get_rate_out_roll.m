function rate_out=get_rate_out_roll(  desired_rate,   scaler,   disable_integrator)

global dt 
global EAS2TAS
global HD
global gyro_x
global aspeed
global airspeed_min

global gains_tau_roll
global gains_P_roll;
global gains_D_roll;
global gains_I_roll
global gains_rmax_roll;
global gains_imax_roll;
global gains_FF_roll;
global last_out_roll
global pid_info_I_roll
global pid_info_P_roll
global pid_info_FF_roll
global pid_info_D_roll
global pid_info_desired_roll
global pid_info_actual_roll


%   internal rate controller, called by attitude and rate controller
%   public functions
 
        delta_time=dt;
	% Calculate equivalent gains so that values for K_P and K_I can be taken across from the old PID law
    % No conversion is required for K_D
	  ki_rate = gains_I_roll * gains_tau_roll;
 	  kp_ff = max((gains_P_roll - gains_I_roll * gains_tau_roll) * gains_tau_roll  - gains_D_roll , 0) / EAS2TAS;
      k_ff = gains_FF_roll / EAS2TAS;
	  
	
	% Limit the demanded roll rate	
    if (gains_rmax_roll && desired_rate < -gains_rmax_roll)  
        desired_rate = - gains_rmax_roll;
    elseif (gains_rmax_roll && desired_rate > gains_rmax_roll)
        desired_rate = gains_rmax_roll;
    end
     
	
    % Get body rate vector (radians/sec)
 	
	% Calculate the roll rate error (deg/sec) and apply gain scaler
      achieved_rate = gyro_x*HD;
	  rate_error = (desired_rate - achieved_rate) * scaler;
	
	% Get an airspeed estimate - default to zero if none available

     

	% Multiply roll rate error by _ki_rate, apply scaler and integrate
	% Scaler is applied before integrator so that integrator state relates directly to aileron deflection
	% This means aileron trim offset doesn't change as the value of scaler changes with airspeed
	% Don't integrate if in stabilise mode as the integrator will wind up against the pilots inputs
	
    if (~disable_integrator && ki_rate > 0)  
		%only integrate if gain and time step are positive and airspeed above min value.		
        if (dt > 0 && aspeed >  (airspeed_min))  
		      integrator_delta = rate_error * ki_rate * delta_time * scaler;
			% prevent the integrator from increasing if surface defln demand is above the upper limit		
            if (last_out_roll < -45)  
                integrator_delta = max(integrator_delta , 0);
            elseif (last_out_roll > 45)  
                % prevent the integrator from decreasing if surface defln demand  is below the lower limit
                 integrator_delta = min(integrator_delta, 0);
            end
			pid_info_I_roll=pid_info_I_roll + integrator_delta;
        end      
    else
		pid_info_I_roll = 0;   
    end
	 
	
    % Scale the integration limit
      intLimScaled = gains_imax_roll * 0.01;

    % Constrain the integrator state
    pid_info_I_roll = constrain_value (pid_info_I_roll, -intLimScaled, intLimScaled);
	
	% Calculate the demanded control surface deflection
	% Note the scaler is applied again. We want a 1/speed scaler applied to the feed-forward
	% path, but want a 1/speed^2 scaler applied to the rate error path. 
	% This is because acceleration scales with speed^2, but rate scales with speed.
    pid_info_D_roll = rate_error * gains_D_roll * scaler;
    pid_info_P_roll = desired_rate * kp_ff * scaler;
    pid_info_FF_roll = desired_rate * k_ff * scaler;
    pid_info_desired_roll = desired_rate;
    pid_info_actual_roll = achieved_rate;

	last_out_roll = pid_info_FF_roll + pid_info_P_roll + pid_info_D_roll;
	last_out_roll=last_out_roll +pid_info_I_roll;
	
	% Convert to centi-degrees and constrain
	  rate_out=constrain_value (last_out_roll * 100, -4500, 4500);
 

end

