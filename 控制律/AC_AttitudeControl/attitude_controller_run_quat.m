function attitude_controller_run_quat()
  global rot_body_to_ned
  global attitude_target_quat
  global attitude_target_ang_vel
  global thrust_error_angle
  global rate_target_ang_vel
  global gyro_z
  global ang_vel_roll_max
  global ang_vel_pitch_max
  global ang_vel_yaw_max

  global AC_ATTITUDE_THRUST_ERROR_ANGLE
  global rate_bf_ff_enabled
  global dt
  global attitude_ang_error
  global attitude_error_vector %%%%%%%%%tiao shi
    % Retrieve quaternion vehicle attitude
    attitude_vehicle_quat=from_rotation_matrix(rot_body_to_ned);
    
%     Compute attitude error
  [attitude_error_vector,thrust_error_angle,attitude_target_quat]= thrust_heading_rotation_angles ( attitude_target_quat,  attitude_vehicle_quat);
    % Compute the angular velocity target from the attitude error
    rate_target_ang_vel = update_ang_vel_target_from_att_error(attitude_error_vector);

    % Add feedforward term that attempts to ensure that roll and pitch errors rotate with the body frame rather than the reference frame.
    % todo: this should probably be a matrix that couples yaw as well.
    rate_target_ang_vel(1) =rate_target_ang_vel(1) + constrain_value(attitude_error_vector(2), -pi/4, pi/4) * gyro_z;
    rate_target_ang_vel(2) =rate_target_ang_vel(2) - constrain_value(attitude_error_vector(1), -pi/4, pi/4) * gyro_z;

    rate_target_ang_vel=ang_vel_limit(rate_target_ang_vel, radians(ang_vel_roll_max), radians(ang_vel_pitch_max), radians(ang_vel_yaw_max));

    % Add the angular velocity feedforward, rotated into vehicle frame
     attitude_target_ang_vel_quat = [0.0, attitude_target_ang_vel(1), attitude_target_ang_vel(2), attitude_target_ang_vel(3)];
     to_to_from_quat = quatmultiply(quatconj(attitude_vehicle_quat) , attitude_target_quat);
    
     desired_ang_vel_quat =quatmultiply(quatmultiply( quatconj(to_to_from_quat), attitude_target_ang_vel_quat) ,to_to_from_quat);

    % Correct the thrust vector and smoothly add feedforward and yaw input
   if (thrust_error_angle > AC_ATTITUDE_THRUST_ERROR_ANGLE * 2.0) 
        rate_target_ang_vel(3) = gyro_z;
    elseif (thrust_error_angle > AC_ATTITUDE_THRUST_ERROR_ANGLE) 
       feedforward_scalar = (1.0 - (thrust_error_angle - AC_ATTITUDE_THRUST_ERROR_ANGLE) / AC_ATTITUDE_THRUST_ERROR_ANGLE);
        rate_target_ang_vel(1)=rate_target_ang_vel(1) + desired_ang_vel_quat(2) * feedforward_scalar;
        rate_target_ang_vel(2)=rate_target_ang_vel(2) + desired_ang_vel_quat(3) * feedforward_scalar;
        rate_target_ang_vel(3)=rate_target_ang_vel(3) + desired_ang_vel_quat(4);
        rate_target_ang_vel(3) = gyro_z * (1.0 - feedforward_scalar) + rate_target_ang_vel(3) * feedforward_scalar;
   else 
        rate_target_ang_vel(1)=rate_target_ang_vel(1)+ desired_ang_vel_quat(2);
        rate_target_ang_vel(2)=rate_target_ang_vel(2)+ desired_ang_vel_quat(3);
        rate_target_ang_vel(3)=rate_target_ang_vel(3)+ desired_ang_vel_quat(4);
   end
    
    if (rate_bf_ff_enabled) 
        % rotate target and normalize     
        attitude_target_update_quat=from_axis_angle3([attitude_target_ang_vel(1) * dt, attitude_target_ang_vel(2)* dt, attitude_target_ang_vel(3) * dt]);
        attitude_target_quat = quatmultiply(attitude_target_quat , attitude_target_update_quat);
        attitude_target_quat=normalizeq(attitude_target_quat) ;
    else
        attitude_target_quat=normalizeq(attitude_target_quat) ;
    end
    
%     attitude_target_quat=normalizeq(attitude_target_quat) ;
        attitude_ang_error = quatmultiply(quatconj(attitude_vehicle_quat), attitude_target_quat);
end

