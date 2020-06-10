function inertial_frame_reset()
% Shifts earth frame yaw target by yaw_shift_cd. yaw_shift_cd should be in centidegrees and is added to the current target heading
    % Retrieve quaternion vehicle attitude
    global rot_body_to_ned
    global attitude_ang_error
    global attitude_target_quat
    global attitude_target_euler_angle
    attitude_vehicle_quat=from_rotation_matrix(rot_body_to_ned);
    % Recalculate the target quaternion
    attitude_target_quat = quatmultiply(attitude_vehicle_quat ,attitude_ang_error);

    % calculate the attitude target euler angles
    attitude_target_euler_angle=to_euler(attitude_target_quat);
end


