function desired_ang_velo=input_shaping_angle(  error_angle,   input_tc,   accel_max,   target_ang_vel,   dt)
 
    % Calculate the velocity as error approaches zero with acceleration limited by accel_max_radss
      desired_ang_vel = sqrt_controller(error_angle, 1.0 / max(input_tc, 0.01), accel_max, dt);

    % Acceleration is limited directly to smooth the beginning of the curve.
      desired_ang_velo=input_shaping_ang_vel(target_ang_vel, desired_ang_vel, accel_max, dt);
 

end

