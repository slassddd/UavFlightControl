function  output=rate_target_to_motor_yaw(  rate_actual_rads,   rate_target_rads)
%  Run the yaw angular velocity PID controller and return the output
global rate_yaw_pid_reset_filter
global rate_yaw_pid_input
global rate_yaw_pid_derivative
global rate_yaw_pid_integrator
global motors_limit_yaw
global dt
global ATC_RAT_YAW_D  
global ATC_RAT_YAW_FF 
global ATC_RAT_YAW_FILT 
global ATC_RAT_YAW_I    
global ATC_RAT_YAW_IMAX  
global ATC_RAT_YAW_P   

    rate_error_rads = rate_target_rads - rate_actual_rads;

    % pass error to PID controller
    if (ATC_RAT_YAW_FILT==0) 
        filt_hz = 1.0;
    else
        filt_hz = ATC_RAT_YAW_FILT;
    end
    
    rc = 1/(2*pi*filt_hz);
    get_filt_alpha=dt / (dt + rc);
     
    % pass error to PID controller    
   % reset input filter to value received
    % reset input filter to value received
    if (rate_yaw_pid_reset_filter==1)  
        rate_yaw_pid_reset_filter = 0;
        rate_yaw_pid_derivative = 0.0;
        rate_yaw_pid_integrator=0;
    end

    % update filter and calculate derivative

        derivative = (rate_error_rads - rate_yaw_pid_input) / dt;
        rate_yaw_pid_derivative = rate_yaw_pid_derivative + get_filt_alpha * (derivative-rate_yaw_pid_derivative);
        rate_yaw_pid_input=rate_error_rads;

    % Ensure that integrator can only be reduced if the output is saturated
    if (~motors_limit_yaw || (((rate_yaw_pid_integrator>0) && (rate_error_rads<0)) || ((rate_yaw_pid_integrator<0) && (rate_error_rads>0))))  
               rate_yaw_pid_integrator=rate_yaw_pid_integrator+(rate_yaw_pid_input*ATC_RAT_YAW_I)*dt;
        if (rate_yaw_pid_integrator < -ATC_RAT_YAW_IMAX)  
            rate_yaw_pid_integrator = -ATC_RAT_YAW_IMAX;
        elseif (rate_yaw_pid_integrator > ATC_RAT_YAW_IMAX)  
            rate_yaw_pid_integrator = ATC_RAT_YAW_IMAX; 
        end    
    end 

    % Compute output in range -1 ~ +1
   output =ATC_RAT_YAW_P*rate_yaw_pid_input + rate_yaw_pid_integrator + ATC_RAT_YAW_D*rate_yaw_pid_derivative + ATC_RAT_YAW_FF*rate_target_rads;
 

end

