function update_althold_lean_angle_max( throttle_in )
global throttle_thrust_max
global althold_lean_angle_max
global AC_ATTITUDE_CONTROL_ANGLE_LIMIT_THROTTLE_MAX
global dt
global angle_limit_tc

    % calc maximum tilt angle based on throttle
    thr_max = throttle_thrust_max;
    althold_lean_angle_maxi = acos(constrain_value(throttle_in / (AC_ATTITUDE_CONTROL_ANGLE_LIMIT_THROTTLE_MAX * thr_max), 0.0, 1.0));
    althold_lean_angle_max = althold_lean_angle_max + (dt / (dt + angle_limit_tc)) * (althold_lean_angle_maxi - althold_lean_angle_max);
        % divide by zero check
     if ((thr_max==0))  
        althold_lean_angle_max = 0.0;
    end
end

