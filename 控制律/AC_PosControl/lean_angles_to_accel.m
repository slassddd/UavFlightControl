function [accel_x_cmss, accel_y_cmss]=lean_angles_to_accel( )  
global GRAVITY_MSS
global yaw
global pitch
global roll
  % get_lean_angles_to_accel - convert roll, pitch lean angles to lat/lon frame accelerations in cm/s/s
    % rotate our roll, pitch angles into lat/lon frame
    % todo: this should probably be based on the desired attitude not the current attitude
    accel_x_cmss = (GRAVITY_MSS * 100) * ( cos(yaw) * sin(pitch) * cos(roll) - sin(yaw) * sin(roll)) / max(cos(roll) * cos(pitch), 0.5);
    accel_y_cmss = (GRAVITY_MSS * 100) * ( sin(yaw) * sin(pitch) * cos(roll) + cos(yaw) * sin(roll)) / max(cos(roll) * cos(pitch), 0.5);
 
end

