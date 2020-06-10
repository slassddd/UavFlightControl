function input_euler_rate_roll_pitch_yaw(  euler_roll_rate_cds,   euler_pitch_rate_cds,   euler_yaw_rate_cds)
    global attitude_target_quat
    global attitude_target_euler_angle
    global rate_bf_ff_enabled
    global accel_roll_max
    global accel_pitch_max
    global accel_yaw_max
    global attitude_target_euler_rate
    global dt
    global attitude_target_ang_vel
    % Convert from centidegrees on public interface to radians
      euler_roll_rate = radians(euler_roll_rate_cds * 0.01);
      euler_pitch_rate = radians(euler_pitch_rate_cds * 0.01);
      euler_yaw_rate = radians(euler_yaw_rate_cds * 0.01);

    % calculate the attitude target euler angles
    attitude_target_euler_angle=to_euler(attitude_target_quat);

    if (rate_bf_ff_enabled)  
        % translate the roll pitch and yaw acceleration limits to the euler axis
         euler_accel = euler_accel_limit(attitude_target_euler_angle, [radians(accel_roll_max * 0.01), radians(accel_pitch_max * 0.01), radians(accel_yaw_max * 0.01)]);

        % When acceleration limiting is enabled, the input shaper constrains angular acceleration, slewing
        % the output rate towards the input rate.
        attitude_target_euler_rate(1) = input_shaping_ang_vel(attitude_target_euler_rate(1), euler_roll_rate, euler_accel(1), dt);
        attitude_target_euler_rate(2) = input_shaping_ang_vel(attitude_target_euler_rate(2), euler_pitch_rate, euler_accel(2), dt);
        attitude_target_euler_rate(3) = input_shaping_ang_vel(attitude_target_euler_rate(3), euler_yaw_rate, euler_accel(3), dt);

        % Convert euler angle derivative of desired attitude into a body-frame angular velocity vector for feedforward
        attitude_target_ang_vel=euler_rate_to_ang_vel(attitude_target_euler_angle, attitude_target_euler_rate );     
      else  
        % When feedforward is not enabled, the target euler angle is input into the target and the feedforward rate is zeroed.
        % Pitch angle is restricted to +- 85.0 degrees to avoid gimbal lock discontinuities.
        attitude_target_euler_angle(1) = wrap_PI(attitude_target_euler_angle(1) + euler_roll_rate * dt);
        attitude_target_euler_angle(2) = constrain_value (attitude_target_euler_angle(2) + euler_pitch_rate * dt, radians(-85.0), radians(85.0));
        attitude_target_euler_angle(3) = wrap_2PI(attitude_target_euler_angle(3) + euler_yaw_rate * dt);

        % Set rate feedforward requests to zero
        attitude_target_euler_rate = [0.0, 0.0, 0.0];
        attitude_target_ang_vel = [0.0, 0.0, 0.0];

        % Compute quaternion target attitude
        attitude_target_quat=from_euler(attitude_target_euler_angle);
     
    end
    % Call quaternion attitude controller
    attitude_controller_run_quat();
 
   
end

