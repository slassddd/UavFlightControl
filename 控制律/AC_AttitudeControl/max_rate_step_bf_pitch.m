function output=max_rate_step_bf_pitch()
% Return pitch rate step size in centidegrees/s that results in maximum output after 4 time steps

global throttle_hover
global AC_ATTITUDE_RATE_RP_CONTROLLER_OUT_MAX
global ATC_RAT_PIT_FILT
global ATC_RAT_PIT_D  
global ATC_RAT_PIT_P    
global dt

     if (ATC_RAT_PIT_FILT==0) 
        filt_hz = 1.0;
    else
        filt_hz = ATC_RAT_PIT_FILT;
    end
    
    rc = 1/(2*pi*filt_hz);
    alpha=dt / (dt + rc);
    
    alpha_remaining = 1 - alpha;
    
    % todo: When a thrust_max is available we should replace 0.5f with 0.5f * _motors.thrust_max
     output= 2.0  * throttle_hover * AC_ATTITUDE_RATE_RP_CONTROLLER_OUT_MAX / ((alpha_remaining * alpha_remaining * alpha_remaining * alpha *ATC_RAT_PIT_D) / dt + ATC_RAT_PIT_P);
 

end



      
 
  
