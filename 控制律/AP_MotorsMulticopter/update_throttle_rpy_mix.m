function update_throttle_rpy_mix()
global throttle_rpy_mix
global throttle_rpy_mix_desired
global dt
global AC_ATTITUDE_CONTROL_MAX
    % slew _throttle_rpy_mix to _throttle_rpy_mix_desired
    if (throttle_rpy_mix < throttle_rpy_mix_desired)  
        % increase quickly (i.e. from 0.1 to 0.9 in 0.4 seconds)
        throttle_rpy_mix=throttle_rpy_mix +min(2.0* dt, throttle_rpy_mix_desired - throttle_rpy_mix);
    elseif (throttle_rpy_mix > throttle_rpy_mix_desired)  
        % reduce more slowly (from 0.9 to 0.1 in 1.6 seconds)
        throttle_rpy_mix=throttle_rpy_mix - min(0.5 * dt, throttle_rpy_mix - throttle_rpy_mix_desired);
    end
    throttle_rpy_mix = constrain_value(throttle_rpy_mix, 0.1, AC_ATTITUDE_CONTROL_MAX);
 
end

