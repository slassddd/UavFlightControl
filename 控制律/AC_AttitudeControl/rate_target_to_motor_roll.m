function output=rate_target_to_motor_roll(  rate_actual_rads,   rate_target_rads)
global rate_roll_pid_reset_filter
global rate_roll_pid_input
global rate_roll_pid_derivative
global rate_roll_pid_integrator
global motors_limit_roll_pitch
global dt
global ATC_RAT_RLL_D  
global ATC_RAT_RLL_FF 
global ATC_RAT_RLL_FILT 
global ATC_RAT_RLL_I    
global ATC_RAT_RLL_IMAX  
global ATC_RAT_RLL_P    

  % Run the roll angular velocity PID controller and return the output
     rate_error_rads = rate_target_rads - rate_actual_rads;
     
    if (ATC_RAT_RLL_FILT==0) 
        filt_hz = 1.0;
    else
        filt_hz = ATC_RAT_RLL_FILT;
    end
    
    rc = 1/(2*pi*filt_hz);
    get_filt_alpha=dt / (dt + rc);
     
    % pass error to PID controller    
   % reset input filter to value received
    % reset input filter to value received
    if (rate_roll_pid_reset_filter==1)  
        rate_roll_pid_reset_filter = 0;
        rate_roll_pid_derivative = 0.0;
        rate_roll_pid_integrator=0;
    end

    % update filter and calculate derivative

        derivative = (rate_error_rads - rate_roll_pid_input) / dt;
        rate_roll_pid_derivative = rate_roll_pid_derivative + get_filt_alpha * (derivative-rate_roll_pid_derivative);
        rate_roll_pid_input=rate_error_rads;


    % Ensure that integrator can only be reduced if the output is saturated
    if (~motors_limit_roll_pitch || (((rate_roll_pid_integrator>0) && (rate_error_rads<0)) || ((rate_roll_pid_integrator<0) && (rate_error_rads>0))))  
         rate_roll_pid_integrator=rate_roll_pid_integrator+(rate_roll_pid_input*ATC_RAT_RLL_I)*dt;
        if (rate_roll_pid_integrator < -ATC_RAT_RLL_IMAX)  
            rate_roll_pid_integrator = -ATC_RAT_RLL_IMAX;
        elseif (rate_roll_pid_integrator > ATC_RAT_RLL_IMAX)  
            rate_roll_pid_integrator = ATC_RAT_RLL_IMAX; 
        end
    end 

    % Compute output in range -1 ~ +1
   output =ATC_RAT_RLL_P*rate_roll_pid_input + rate_roll_pid_integrator + ATC_RAT_RLL_D*rate_roll_pid_derivative + ATC_RAT_RLL_FF*rate_target_rads;
 
end

