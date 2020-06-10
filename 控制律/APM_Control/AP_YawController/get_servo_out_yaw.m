function servo_out=get_servo_out_yaw(  scaler,   disable_integrator)
 
global dt 
global HD
global gyro_z
global accel_y
global GRAVITY_MSS
global airspeed_min
global aspeed
global roll

global K_I_yaw
global K_D_yaw
global K_A_yaw
global K_FF_yaw
global imax_yaw
global K_D_last_yaw
global pid_info_I_yaw
global pid_info_D_yaw
global last_rate_hp_out_yaw
global last_rate_hp_in_yaw
global integrator_yaw
global last_out_yaw


    servo_out=0;
    aspd_min=airspeed_min;
     if (aspd_min < 1)  
        aspd_min = 1;
     end
	
	  delta_time = dt;
	
	% Calculate yaw rate required to keep up with a constant height coordinated turn
 
	  bank_angle =roll;
	% limit bank angle between +- 80 deg if right way up
    if (abs(bank_angle) < 1.5707964)	 
	    bank_angle = constrain_value (bank_angle,-1.3962634,1.3962634);
    end

	 
    rate_offset = (GRAVITY_MSS / max(aspeed ,  (aspd_min))) * sin(bank_angle) * K_FF_yaw;

    % Get body rate vector (radians/sec)
	 
	
	% Get the accln vector (m/s^2)
 
	% Subtract the steady turn component of rate from the measured rate
	% to calculate the rate relative to the turn requirement in degrees/sec
	  rate_hp_in = HD*(gyro_z - rate_offset);
	
	% Apply a high-pass filter to the rate to washout any steady state error
	% due to bias errors in rate_offset
	% Use a cut-off frequency of omega = 0.2 rad/sec
	% Could make this adjustable by replacing 0.9960080 with (1 - omega * dt)
	  rate_hp_out = (1-0.2*dt)  *  last_rate_hp_out_yaw + rate_hp_in -  last_rate_hp_in_yaw;
	 last_rate_hp_out_yaw = rate_hp_out;
	 last_rate_hp_in_yaw = rate_hp_in;
	%Calculate input to integrator_yaw
	  integ_in = - K_I_yaw * (K_A_yaw * accel_y + rate_hp_out);
	
	% Apply integrator_yaw, but clamp input to prevent control saturation and freeze integrator_yaw below min FBW speed
	% Don't integrate if in stabilise mode as the integrator_yaw will wind up against the pilots inputs
	% Don't integrate if _K_D is zero as integrator_yaw will keep winding up	
    if (~disable_integrator && K_D_yaw > 0)  
		%only integrate if airspeed above min value	
        if (aspeed >  (aspd_min))		 
			% prevent the integrator_yaw from increasing if surface defln demand is above the upper limit	
            if ( last_out_yaw < -45)  
                 integrator_yaw =integrator_yaw+ max(integ_in * delta_time , 0);
            elseif (last_out_yaw > 45)  
                % prevent the integrator_yaw from decreasing if surface defln demand  is below the lower limit
                integrator_yaw =integrator_yaw+ min(integ_in * delta_time , 0);			  
            else  
               integrator_yaw=integrator_yaw + integ_in * delta_time;
            end
        end      
    else
		integrator_yaw = 0;    
    end
	 
    if (K_D_yaw < 0.0001)  
        % yaw damping is disabled, and the integrator_yaw is scaled by damping, so return 0
        servo_out=0;
        return ;
    end
     
	
    % Scale the integration limit
      intLimScaled = imax_yaw * 0.01 / (K_D_yaw * scaler * scaler);

    % Constrain the integrator_yaw state
    integrator_yaw = constrain_value (integrator_yaw, -intLimScaled, intLimScaled);
	
	% Protect against increases to _K_D during in-flight tuning from creating large control transients
	% due to stored integrator_yaw values
    if (K_D_yaw > K_D_last_yaw && K_D_yaw > 0)  
	    integrator_yaw = K_D_last_yaw/K_D_yaw * integrator_yaw;
    end
	K_D_last_yaw = K_D_yaw;
	
	% Calculate demanded rudder deflection, +Ve deflection yaws nose right
	% Save to last value before application of limiter so that integrator_yaw limiting
	% can detect exceedance next frame
	% Scale using inverse dynamic pressure (1/V^2)
	pid_info_I_yaw = K_D_yaw * integrator_yaw * scaler * scaler;
	pid_info_D_yaw = K_D_yaw * (-rate_hp_out) * scaler * scaler;
	last_out_yaw =  pid_info_I_yaw + pid_info_D_yaw;

	% Convert to centi-degrees and constrain
	 servo_out=constrain_value (last_out_yaw * 100, -4500, 4500);

end

