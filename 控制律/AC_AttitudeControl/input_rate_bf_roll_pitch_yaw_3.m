function input_rate_bf_roll_pitch_yaw_3( roll_rate_bf_cds,  pitch_rate_bf_cds,  yaw_rate_bf_cds)
% Command an angular velocity with angular velocity smoothing using rate loops only with integrated rate error stabilization
    global attitude_target_quat
    global attitude_target_euler_angle
    global attitude_target_ang_vel
    global accel_roll_max
    global accel_pitch_max
    global accel_yaw_max
    global attitude_target_euler_rate
    global rot_body_to_ned
    global rate_target_ang_vel
    global attitude_ang_error
    global AC_ATTITUDE_THRUST_ERROR_ANGLE
    global gyro_latest %%ºóÐø²¹³ä
    % Convert from centidegrees on public interface to radians
     roll_rate_rads = radians(roll_rate_bf_cds * 0.01);
     pitch_rate_rads = radians(pitch_rate_bf_cds * 0.01);
     yaw_rate_rads = radians(yaw_rate_bf_cds * 0.01);

    % Update attitude error
    attitude_error_vector=to_axis_angle(attitude_ang_error);
    % limit the integrated error angle
     err_mag = norm(attitude_error_vector,2);
     
    if (err_mag > AC_ATTITUDE_THRUST_ERROR_ANGLE)  
        attitude_error_vector =attitude_error_vector* AC_ATTITUDE_THRUST_ERROR_ANGLE / err_mag;
        attitude_ang_error=from_axis_angle3(attitude_error_vector);
    end
    

    attitude_ang_error_update_quat=from_axis_angle3([(attitude_target_ang_vel(1)-gyro_latest(1)) * dt, (attitude_target_ang_vel(2)-gyro_latest(2)) * dt, (attitude_target_ang_vel(3)-gyro_latest(3)) * dt]);
    attitude_ang_error = quatmultiply(attitude_ang_error_update_quat , attitude_ang_error);

    % Compute acceleration-limited body frame rates
    % When acceleration limiting is enabled, the input shaper constrains angular acceleration about the axis, slewing
    % the output rate towards the input rate.
    attitude_target_ang_vel(1) = input_shaping_ang_vel(attitude_target_ang_vel(1), roll_rate_rads, radians(accel_roll_max * 0.01), dt);
    attitude_target_ang_vel(2) = input_shaping_ang_vel(attitude_target_ang_vel(2), pitch_rate_rads, radians(accel_pitch_max * 0.01), dt);
    attitude_target_ang_vel(3) = input_shaping_ang_vel(attitude_target_ang_vel(3), yaw_rate_rads, radians(accel_yaw_max * 0.01), dt);

    % Retrieve quaternion vehicle attitude
    attitude_vehicle_quat=from_rotation_matrix(rot_body_to_ned);
    % Update the unused targets attitude based on current attitude to condition mode change
    attitude_target_quat = quatmultiply(attitude_vehicle_quat ,attitude_ang_error);

    % calculate the attitude target euler angles
    attitude_target_euler_angle=to_euler(attitude_target_quat);
    

    % Convert body-frame angular velocity into euler angle derivative of desired attitude
    attitude_target_euler_rate=ang_vel_to_euler_rate(attitude_target_euler_angle, attitude_target_ang_vel);

    % Compute the angular velocity target from the integrated rate error
    attitude_error_vector=to_axis_angle(attitude_ang_error) ;
    rate_target_ang_vel = update_ang_vel_target_from_att_error(attitude_error_vector);
    rate_target_ang_vel =rate_target_ang_vel+ attitude_target_ang_vel;

    % ensure Quaternions stay normalized
    attitude_ang_error=normlizeq(attitude_ang_error);

end

