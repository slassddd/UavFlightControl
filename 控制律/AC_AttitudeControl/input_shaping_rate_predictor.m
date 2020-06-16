function target_ang_vel=input_shaping_rate_predictor( error_angle,dt)  
% calculates the expected angular velocity correction from an angle error based on the AC_AttitudeControl settings.
% This function can be used to predict the delay associated with angle requests.
global rate_bf_ff_enabled
global input_tc
global accel_roll_max
global accel_pitch_max
global p_angle_roll
global p_angle_pitch

    target_ang_vel=zeros(1,2);
    if (rate_bf_ff_enabled)  
        % translate the roll pitch and yaw acceleration limits to the euler axis
        target_ang_vel(1) = input_shaping_angle(wrap_PI(error_angle(1)),input_tc, radians(accel_roll_max * 0.01), target_ang_vel(1), dt);
        target_ang_vel(2) = input_shaping_angle(wrap_PI(error_angle(2)),input_tc, radians(accel_pitch_max * 0.01), target_ang_vel(2), dt);
     else  
        target_ang_vel(1) = p_angle_roll*(wrap_PI(error_angle(1)));
        target_ang_vel(2) = p_angle_pitch*(wrap_PI(error_angle(2)));
    end
    % Limit the angular velocity correction
     ang_vel=[target_ang_vel(1), target_ang_vel(2), 0.0];
    ang_vel=ang_vel_limit(ang_vel, radians(ang_vel_roll_max), radians(ang_vel_pitch_max), 0.0);

    target_ang_vel(1) = ang_vel(1);
    target_ang_vel(2) = ang_vel(2);

end

