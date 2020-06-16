function throttle_avg_max=get_throttle_avg_max(  throttle_in)
 global throttle_rpy_mix
 global throttle_hover
 
    throttle_in = constrain_value(throttle_in, 0.0, 1.0);
    throttle_avg_max=max(throttle_in, throttle_in * max(0.0, 1.0 - throttle_rpy_mix) + throttle_hover * throttle_rpy_mix);
 
end

