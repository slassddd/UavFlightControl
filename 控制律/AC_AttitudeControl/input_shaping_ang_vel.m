function desired_ang_velo = input_shaping_ang_vel( target_ang_vel,  desired_ang_vel,  accel_max,   dt)
 
    %Acceleration is limited directly to smooth the beginning of the curve.
    if accel_max>0 
        delta_ang_vel = accel_max * dt;
        desired_ang_velo=constrain_value(desired_ang_vel,target_ang_vel -delta_ang_vel,target_ang_vel + delta_ang_vel);
    else
        desired_ang_velo=desired_ang_vel;
    end
 