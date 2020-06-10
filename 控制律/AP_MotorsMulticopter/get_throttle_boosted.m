function     throttle_boosted=get_throttle_boosted(  throttle_in)
% returns a throttle including compensation for roll/pitch angle
% throttle value should be 0 ~ 1
 global angle_boost_enabled
 global angle_boost
 global pitch
 global roll
    if (~angle_boost_enabled)  
        angle_boost = 0;
        throttle_boosted=throttle_in;
        return;
    end
      
    % inverted_factor is 1 for tilt angles below 60 degrees
    % inverted_factor reduces from 1 to 0 for tilt angles between 60 and 90 degrees
    cos_tilt = cos(pitch) * cos(roll);
    inverted_factor = constrain_value(2.0 * cos_tilt, 0.0, 1.0);
    boost_factor = 1.0 / constrain_value(cos_tilt, 0.5, 1.0);

    throttle_out = throttle_in * inverted_factor * boost_factor;
    angle_boost = constrain_value(throttle_out - throttle_in, -1.0, 1.0);
    throttle_boosted= throttle_out;
 
end

