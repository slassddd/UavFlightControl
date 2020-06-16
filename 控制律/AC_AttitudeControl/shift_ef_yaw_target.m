function shift_ef_yaw_target(  yaw_shift_cd)
% Shifts earth frame yaw target by yaw_shift_cd. yaw_shift_cd should be in centidegrees and is added to the current target heading
global attitude_target_quat
    yaw_shift = radians(yaw_shift_cd * 0.01);
    attitude_target_update_quat=from_axis_angle([0.0, 0.0, yaw_shift]);
    attitude_target_quat =quatmultiply( attitude_target_update_quat , attitude_target_quat); 
end

