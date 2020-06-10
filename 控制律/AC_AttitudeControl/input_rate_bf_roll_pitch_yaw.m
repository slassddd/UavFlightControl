function input_rate_bf_roll_pitch_yaw( roll_rate_bf_cds,  pitch_rate_bf_cds,  yaw_rate_bf_cds)
 %Command an angular velocity with angular velocity feedforward and smoothing
global attitude_target_quat
global attitude_target_euler_angle
global rate_bf_ff_enabled
global attitude_target_ang_vel
global accel_roll_max
global accel_pitch_max
global accel_yaw_max
global attitude_target_euler_rate
global dt
% Convert from centidegrees on public interface to radians
     roll_rate_rads = radians(roll_rate_bf_cds * 0.01);
     pitch_rate_rads = radians(pitch_rate_bf_cds * 0.01);
     yaw_rate_rads = radians(yaw_rate_bf_cds * 0.01);


    % calculate the attitude target euler angles
    attitude_target_euler_angle=to_euler(attitude_target_quat);
    
    
    if (rate_bf_ff_enabled)  
        % Compute acceleration-limited body frame rates
        % When acceleration limiting is enabled, the input shaper constrains angular acceleration about the axis, slewing
        % the output rate towards the input rate.
        attitude_target_ang_vel(1) = input_shaping_ang_vel(attitude_target_ang_vel(1), roll_rate_rads, radians(accel_roll_max * 0.01), dt);
        attitude_target_ang_vel(2) = input_shaping_ang_vel(attitude_target_ang_vel(2), pitch_rate_rads, radians(accel_pitch_max * 0.01), dt);
        attitude_target_ang_vel(3) = input_shaping_ang_vel(attitude_target_ang_vel(3), yaw_rate_rads, radians(accel_yaw_max * 0.01), dt);

        % Convert body-frame angular velocity into euler angle derivative of desired attitude
        attitude_target_euler_rate=ang_vel_to_euler_rate(attitude_target_euler_angle, attitude_target_ang_vel);
      else  
        % When feedforward is not enabled, the quaternion is calculated and is input into the target and the feedforward rate is zeroed.
        attitude_target_update_quat=from_axis_angle3([roll_rate_rads * dt, pitch_rate_rads * dt, yaw_rate_rads * dt]);
        attitude_target_quat = quatmultiply(attitude_target_quat ,attitude_target_update_quat);
        attitude_target_quat=normalizeq(attitude_target_quat);

        % Set rate feedforward requests to zero
        attitude_target_euler_rate = [0.0, 0.0, 0.0];
        attitude_target_ang_vel =    [0.0, 0.0, 0.0];
    end 

    % Call quaternion attitude controller
    attitude_controller_run_quat();
 
end

