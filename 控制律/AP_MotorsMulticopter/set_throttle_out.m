function  set_throttle_out(  throttle_ini,   apply_angle_boost,   filter_cutoff)
 global throttle_in
 global angle_boost
 global throttle_avg_max
 global throttle_cutoff_frequency
%     throttle_in = throttle_ini;
    update_althold_lean_angle_max(throttle_ini);
%     set_throttle_filter_cutoff(filter_cutoff);
    throttle_cutoff_frequency=filter_cutoff;
    if (apply_angle_boost)  
        % Apply angle boost
        throttle_ini = get_throttle_boosted(throttle_ini);
      else  
        % Clear angle_boost for logging purposes
        angle_boost = 0.0;
    end
%     set_throttle(throttle_ini);
    throttle_in = throttle_ini;
    throttle_avg_max=constrain_value(get_throttle_avg_max(max(throttle_ini, throttle_in)),0,1);
 
end

