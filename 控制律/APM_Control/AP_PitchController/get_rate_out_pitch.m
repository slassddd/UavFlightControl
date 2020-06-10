function  rate_out=get_rate_out_pitch(  desired_rate,   scaler,   disable_integrator,   aspeed)
 
global dt
global gyro_y
global airspeed_min
global gains_I_pitch 
global gains_tau_pitch;
global gains_P_pitch;
global gains_D_pitch;
global gains_imax_pitch;
global gains_FF_pitch;
global last_out_pitch
global pid_info_I_pitch
global pid_info_P_pitch
global pid_info_FF_pitch
global pid_info_D_pitch
global pid_info_desired_pitch
global pid_info_actual_pitch
global EAS2TAS
global roll
global pitch
global roll_limit_cd
global HD   
%  Function returns an equivalent elevator deflection in centi-degrees in the range from -4500 to 4500
%  A positive demand is up
%  Inputs are: 
%  1) demanded pitch rate in degrees/second
%  2) control gain scaler = scaling_speed / aspeed
%  3) boolean which is true when stabilise mode is active
%  4) minimum FBW airspeed (metres/sec)
%  5) maximum FBW airspeed (metres/sec)
%  
    delta_time=dt;
 
	
	% Get body rate vector (radians/sec)
 	
	% Calculate the pitch rate error (deg/sec) and scale
      achieved_rate = gyro_y*HD;
	  rate_error = (desired_rate - achieved_rate) * scaler;
	
	% Multiply pitch rate error by _ki_rate and integrate
	% Scaler is applied before integrator so that integrator state relates directly to elevator deflection
	% This means elevator trim offset doesn't change as the value of scaler changes with airspeed
	% Don't integrate if in stabilise mode as the integrator will wind up against the pilots inputs
	
    if (~disable_integrator && gains_I_pitch > 0)  
          k_I = gains_I_pitch;
        if (is_zero(gains_FF_pitch))               
%               if the user hasn't set a direct FF then assume they are
%               not doing sophisticated tuning. Set a minimum I value of
%               0.15 to ensure that the time constant for trimming in
%               pitch is not too long. We have had a lot of user issues
%               with very small I value leading to very slow pitch
%               trimming, which causes a lot of problems for TECS. A
%               value of 0.15 is still quite small, but a lot better
%               than what many users are running.              
            k_I = max(k_I, 0.15);
        end
          ki_rate = k_I * gains_tau_pitch;
		%only integrate if gain and time step are positive and airspeed above min value.	
        if (dt > 0 && aspeed > 0.5* (airspeed_min))  
		      integrator_delta = rate_error * ki_rate * delta_time * scaler;			
              if (last_out_pitch < -45)  
				% prevent the integrator from increasing if surface defln demand is above the upper limit
				integrator_delta = max(integrator_delta , 0);            
              elseif (last_out_pitch > 45)  
				% prevent the integrator from decreasing if surface defln demand  is below the lower limit
				integrator_delta = min(integrator_delta , 0);
              end
			pid_info_I_pitch=pid_info_I_pitch+integrator_delta;    
        else  
            pid_info_I_pitch = 0;      
        end
    end
    

    % Scale the integration limit
      intLimScaled = gains_imax_pitch * 0.01;
    % Constrain the integrator state
    pid_info_I_pitch = constrain_value (pid_info_I_pitch, -intLimScaled, intLimScaled);

	% Calculate equivalent gains so that values for K_P and K_I can be taken across from the old PID law
    % No conversion is required for K_D
	  kp_ff = max((gains_P_pitch - gains_I_pitch * gains_tau_pitch) * gains_tau_pitch  - gains_D_pitch , 0) / EAS2TAS;
      k_ff = gains_FF_pitch / EAS2TAS;
	
	% Calculate the demanded control surface deflection
	% Note the scaler is applied again. We want a 1/speed scaler applied to the feed-forward
	% path, but want a 1/speed^2 scaler applied to the rate error path. 
	% This is because acceleration scales with speed^2, but rate scales with speed.
    pid_info_P_pitch = desired_rate * kp_ff * scaler;
    pid_info_FF_pitch = desired_rate * k_ff * scaler;
    pid_info_D_pitch = rate_error * gains_D_pitch * scaler;
	last_out_pitch = pid_info_D_pitch + pid_info_FF_pitch + pid_info_P_pitch;
    pid_info_desired_pitch = desired_rate;
    pid_info_actual_pitch = achieved_rate;
	last_out_pitch= last_out_pitch+ pid_info_I_pitch;
    
     
%       when we are past the users defined roll limit for the
%       aircraft our priority should be to bring the aircraft back
%       within the roll limit. Using elevator for pitch control at
%       large roll angles is ineffective, and can be counter
%       productive as it induces earth-frame yaw which can reduce
%       the ability to roll. We linearly reduce elevator input when
%       beyond the configured roll limit, reducing to zero at 90
%       degrees
     
      roll_wrapped = abs(roll);
    if (roll_wrapped > 9000)  
        roll_wrapped = 18000 - roll_wrapped;
    end
    if (roll_wrapped >roll_limit_cd + 500 && roll_limit_cd < 8500 &&abs(pitch) < 7000)  
         roll_prop = (roll_wrapped - (roll_limit_cd+500)) / (9000 - roll_limit_cd);
        last_out_pitch=last_out_pitch* (1 - roll_prop);
    end
    
	% Convert to centi-degrees and constrain
 	rate_out= constrain_value (last_out_pitch * 100, -4500, 4500);
 

end

