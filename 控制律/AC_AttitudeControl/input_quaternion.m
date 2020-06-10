function input_quaternion( attitude_desired_quat)
 global attitude_target_euler_angle
 global attitude_target_quat
 global rate_bf_ff_enabled
 global input_tc
 global dt
 global attitude_target_ang_vel
 global accel_roll_max
 global accel_pitch_max
 global accel_yaw_max
 global attitude_target_euler_rate
 global ang_vel_roll_max
 global ang_vel_pitch_max
 global ang_vel_yaw_max
    % calculate the attitude target euler angles
    attitude_target_euler_angle=to_euler(attitude_target_quat);
    attitude_error_quat = quatmultiply(quatconj(attitude_target_quat), attitude_desired_quat);
    attitude_error_angle=to_axis_angle(attitude_error_quat);

    if (rate_bf_ff_enabled)  
        % When acceleration limiting and feedforward are enabled, the sqrt controller is used to compute an euler
        % angular velocity that will cause the euler angle to smoothly stop at the input angle with limited deceleration
        % and an exponential decay specified by _input_tc at the end.
        attitude_target_ang_vel(1) = input_shaping_angle(wrap_PI(attitude_error_angle(1)), input_tc, radians(accel_roll_max * 0.01), attitude_target_ang_vel(1), dt);
        attitude_target_ang_vel(2) = input_shaping_angle(wrap_PI(attitude_error_angle(2)), input_tc, radians(accel_pitch_max * 0.01), attitude_target_ang_vel(2), dt);
        attitude_target_ang_vel(3) = input_shaping_angle(wrap_PI(attitude_error_angle(3)), input_tc, radians(accel_yaw_max * 0.01), attitude_target_ang_vel(3), dt);

        % Limit the angular velocity
        attitude_target_ang_vel=ang_vel_limit(attitude_target_ang_vel, radians(ang_vel_roll_max), radians(ang_vel_pitch_max), radians(ang_vel_yaw_max));
        % Convert body-frame angular velocity into euler angle derivative of desired attitude
        attitude_target_euler_rate=ang_vel_to_euler_rate(attitude_target_euler_angle, attitude_target_ang_vel);    
    else  
        attitude_target_quat = attitude_desired_quat;
        % Set rate feedforward requests to zero
        attitude_target_euler_rate = [0.0, 0.0, 0.0];
        attitude_target_ang_vel    = [0.0, 0.0, 0.0];
       
    end

    % Call quaternion attitude controller
    attitude_controller_run_quat();
 

end

