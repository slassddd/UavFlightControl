function  output=max_rate_step_bf_yaw()
% Return yaw rate step size in centidegrees/s that results in maximum output after 4 time steps
global throttle_hover
global AC_ATTITUDE_RATE_YAW_CONTROLLER_OUT_MAX
global ATC_RAT_YAW_FILT
global ATC_RAT_YAW_D  
global ATC_RAT_YAW_P    
global dt

    if (ATC_RAT_YAW_FILT==0) 
        filt_hz = 1.0;
    else
        filt_hz = ATC_RAT_YAW_FILT;
    end
    
    rc = 1/(2*pi*filt_hz);
    alpha=dt / (dt + rc);
    alpha_remaining = 1 - alpha;
    % todo: When a thrust_max is available we should replace 0.5f with 0.5f * _motors.thrust_max
     output= 2.0 * throttle_hover * AC_ATTITUDE_RATE_YAW_CONTROLLER_OUT_MAX / ((alpha_remaining * alpha_remaining * alpha_remaining * alpha * ATC_RAT_YAW_D) / dt + ATC_RAT_YAW_P);
 

end

