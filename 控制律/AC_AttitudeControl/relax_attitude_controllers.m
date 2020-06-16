function  relax_attitude_controllers()
 global rot_body_to_ned
 global attitude_target_quat
 global attitude_target_euler_angle
 global attitude_ang_error
 global gyro_x gyro_y gyro_z
 global attitude_target_ang_vel
 global attitude_target_euler_rate
 global rate_target_ang_vel
 global thrust_error_angle
 global rate_pitch_pid_reset_filter
 global rate_roll_pid_reset_filter
 global rate_yaw_pid_reset_filter
    % Initialize the attitude variables to the current attitude
    attitude_target_quat=from_rotation_matrix(rot_body_to_ned); 
    
    attitude_target_euler_angle=to_euler(attitude_target_quat);
    
    attitude_ang_error=[1 0 0 0];

    % Initialize the angular rate variables to the current rate
    attitude_target_ang_vel = [gyro_x gyro_y gyro_z];
    attitude_target_euler_rate = ang_vel_to_euler_rate(attitude_target_euler_angle,attitude_target_ang_vel);
     rate_target_ang_vel = [gyro_x gyro_y gyro_z];

    % Initialize remaining variables
    thrust_error_angle = 0.0;

    % Reset the PID filters
    rate_pitch_pid_reset_filter=1;
    rate_roll_pid_reset_filter=1;
    rate_yaw_pid_reset_filter=1;

    reset_rate_controller_I_terms();
end

