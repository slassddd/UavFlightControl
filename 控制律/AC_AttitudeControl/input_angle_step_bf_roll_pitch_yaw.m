function input_angle_step_bf_roll_pitch_yaw(  roll_angle_step_bf_cd,   pitch_angle_step_bf_cd,   yaw_angle_step_bf_cd)
    % Command an angular step (i.e change) in body frame angle
    % Used to command a step in angle without exciting the orthogonal axis during autotune
    % Convert from centidegrees on public interface to radians
   global attitude_target_quat 
   global attitude_target_euler_angle
   global attitude_target_euler_rate
   global attitude_target_ang_vel
      roll_step_rads = radians(roll_angle_step_bf_cd * 0.01);
      pitch_step_rads = radians(pitch_angle_step_bf_cd * 0.01);
      yaw_step_rads = radians(yaw_angle_step_bf_cd * 0.01);

    % rotate attitude target by desired step
    attitude_target_update_quat=from_axis_angle3([roll_step_rads, pitch_step_rads, yaw_step_rads]);
    attitude_target_quat = quatmultiply(attitude_target_quat , attitude_target_update_quat);
    attitude_target_quat=normalizeq(attitude_target_quat);

    % calculate the attitude target euler angles
    attitude_target_euler_angle=to_euler(attitude_target_quat);
    % Set rate feedforward requests to zero
    attitude_target_euler_rate = [0.0, 0.0, 0.0];
    attitude_target_ang_vel = [0.0, 0.0, 0.0];

    % Call quaternion attitude controller
    attitude_controller_run_quat();
 
end

