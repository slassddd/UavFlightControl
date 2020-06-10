function input_euler_rate_yaw_euler_angle_pitch_bf_roll_m(euler_yaw_rate_cds,  euler_pitch_cd,  body_roll_cd)
global rot_body_to_ned
global attitude_target_quat
global AC_ATTITUDE_THRUST_ERROR_ANGLE
global attitude_target_euler_angle
global dt
global rate_target_ang_vel
global attitude_target_euler_rate
global attitude_target_ang_vel
    % Command euler pitch and yaw angles and roll rate (used only by tailsitter quadplanes)
    % Multicopter style controls: roll stick is tailsitter bodyframe yaw in hover
    % Convert from centidegrees on public interface to radians
      euler_yaw_rate = radians(euler_yaw_rate_cds*0.01);
      euler_pitch = radians(constrain_value (euler_pitch_cd * 0.01, -90.0, 90.0));
      body_roll   = radians(constrain_value (body_roll_cd   * 0.01, -90.0, 90.0));

    % Compute attitude error

    attitude_vehicle_quat=from_rotation_matrix(rot_body_to_ned);
    error_quat = quatmultiply(quatconj(attitude_vehicle_quat) ,attitude_target_quat);
  
    att_error=to_axis_angle(error_quat);

    % limit yaw error
    if (abs(att_error(3)) < AC_ATTITUDE_THRUST_ERROR_ANGLE) 
        % update heading
        attitude_target_euler_angle(3) = wrap_PI(attitude_target_euler_angle(3) + euler_yaw_rate * dt);
     
    end
    % init attitude target to desired euler yaw and pitch with zero roll
    attitude_target_quat=from_euler([0, euler_pitch, attitude_target_euler_angle(3)]);

    cpitch = cos(euler_pitch);
    spitch = abs(sin(euler_pitch));

    % apply body-frame yaw/roll (this is roll/yaw for a tailsitter in forward flight)
    % rotate body_roll axis by |sin(pitch angle)|
     bf_roll_Q=from_axis_angle3([0, 0, spitch * body_roll]);

    % rotate body_yaw axis by cos(pitch angle)
    bf_yaw_Q=from_axis_angle3([-cpitch * body_roll, 0, 0]);
    attitude_target_quat = quatmultiply(quatmultiply(attitude_target_quat , bf_roll_Q ), bf_yaw_Q);

    % _attitude_target_euler_angle roll and pitch: Note: roll/yaw will be indeterminate when pitch is near +/-90
    % These should be used only for logging target eulers, with the caveat noted above.
    % Also note that _attitude_target_quat.from_euler() should only be used in special circumstances
    % such as when attitude is specified directly in terms of Euler angles.
    %    _attitude_target_euler_angle.x = _attitude_target_quat.get_euler_roll();
    %    _attitude_target_euler_angle.y = euler_pitch;

    % Set rate feedforward requests to zero
    attitude_target_euler_rate = [0.0, 0.0, 0.0];
    attitude_target_ang_vel = [0.0, 0.0, 0.0];

    % Compute attitude error
    error_quat =  quatmultiply(quatconj(attitude_vehicle_quat),attitude_target_quat);
    att_error=to_axis_angle(error_quat);

    % Compute the angular velocity target from the attitude error
    rate_target_ang_vel = update_ang_vel_target_from_att_error(att_error);
 
end

