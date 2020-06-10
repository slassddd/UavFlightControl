function [ roll_target,    pitch_target]=accel_to_lean_angles(  accel_x_cmss,   accel_y_cmss)  
 global yaw
 global GRAVITY_MSS
    % get_lean_angles_to_accel - convert roll, pitch lean angles to lat/lon frame accelerations in cm/s/s

 
    % rotate accelerations into body forward-right frame
    % todo: this should probably be based on the desired heading not the current heading
    accel_forward = accel_x_cmss * cos(yaw) + accel_y_cmss * sin(yaw);
    accel_right = -accel_x_cmss * sin(yaw) + accel_y_cmss * cos(yaw);

    % update angle targets that will be passed to stabilize controller
    pitch_target = atan(-accel_forward / (GRAVITY_MSS * 100.0)) * (18000.0 / pi);
    cos_pitch_target = cos(pitch_target * pi / 18000.0);
    roll_target = atan(accel_right * cos_pitch_target / (GRAVITY_MSS * 100.0)) * (18000.0 / pi);
 
end

