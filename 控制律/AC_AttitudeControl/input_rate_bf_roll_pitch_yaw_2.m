function input_rate_bf_roll_pitch_yaw_2(  roll_rate_bf_cds,   pitch_rate_bf_cds,   yaw_rate_bf_cds)
global attitude_target_quat
global attitude_target_euler_angle
global attitude_target_ang_vel
global accel_roll_max
global accel_pitch_max
global accel_yaw_max
global attitude_target_euler_rate
global rot_body_to_ned
global rate_target_ang_vel
    % Convert from centidegrees on public interface to radians
      roll_rate_rads = radians(roll_rate_bf_cds * 0.01);
      pitch_rate_rads = radians(pitch_rate_bf_cds * 0.01);
      yaw_rate_rads = radians(yaw_rate_bf_cds * 0.01);

    % Compute acceleration-limited body frame rates
    % When acceleration limiting is enabled, the input shaper constrains angular acceleration about the axis, slewing
    % the output rate towards the input rate.
    attitude_target_ang_vel(1) = input_shaping_ang_vel(attitude_target_ang_vel(1), roll_rate_rads, radians(accel_roll_max * 0.01), dt);
    attitude_target_ang_vel(2) = input_shaping_ang_vel(attitude_target_ang_vel(2), pitch_rate_rads, radians(accel_pitch_max * 0.01), dt);
    attitude_target_ang_vel(3) = input_shaping_ang_vel(attitude_target_ang_vel(3), yaw_rate_rads, radians(accel_yaw_max * 0.01), dt);
    attitude_target_quat=from_rotation_matrix(rot_body_to_ned);
    attitude_target_euler_angle=to_euler(attitude_target_quat);
    % Update the unused targets attitude based on current attitude to condition mode change
    % Convert body-frame angular velocity into euler angle derivative of desired attitude
    attitude_target_euler_rate=ang_vel_to_euler_rate(attitude_target_euler_angle, attitude_target_ang_vel);
    rate_target_ang_vel = attitude_target_ang_vel;

end

