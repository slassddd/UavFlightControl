function    stopping_point_z=get_stopping_point_z()  
% get_stopping_point_z - calculates stopping point based on current position, velocity, vehicle acceleration
global curr_alt
global curr_vel
global vel_error
global vel_desired
global is_active_z
global POSCONTROL_ACCEL_Z
global POSCONTROL_STOPPING_DIST_DOWN_MAX
global POSCONTROL_STOPPING_DIST_UP_MAX
global use_desvel_ff_z
global POSCONTROL_POS_Z_P

      curr_pos_z = curr_alt;
      curr_vel_z = curr_vel(3);
 
    % if position controller is active add current velocity error to avoid sudden jump in acceleration
    if (is_active_z)  
        curr_vel_z =curr_vel_z+ vel_error(3);
        if ( use_desvel_ff_z)  
            curr_vel_z=curr_vel_z -vel_desired(3);
        end
    end
     

    % avoid divide by zero by using current position if kP is very low or acceleration is zero
    if (POSCONTROL_POS_Z_P <= 0.0 || POSCONTROL_ACCEL_Z <= 0.0)  
        stopping_point_z = curr_pos_z;
        return;
    end

    % calculate the velocity at which we switch from calculating the stopping point using a linear function to a sqrt function
    linear_velocity = POSCONTROL_ACCEL_Z / POSCONTROL_POS_Z_P;

    if (abs(curr_vel_z) < linear_velocity)  
        % if our current velocity is below the cross-over point we use a linear function
        stopping_point_z= curr_pos_z + curr_vel_z /POSCONTROL_POS_Z_P;
      else  
        linear_distance = POSCONTROL_ACCEL_Z / (2.0 * POSCONTROL_POS_Z_P * POSCONTROL_POS_Z_P);
        if (curr_vel_z > 0)  
            stopping_point_z = curr_pos_z + (linear_distance + curr_vel_z * curr_vel_z / (2.0 * POSCONTROL_ACCEL_Z));
         else  
            stopping_point_z = curr_pos_z - (linear_distance + curr_vel_z * curr_vel_z / (2.0 * POSCONTROL_ACCEL_Z));
        end
    end
     
    stopping_point_z = constrain_value (stopping_point_z, curr_pos_z - POSCONTROL_STOPPING_DIST_DOWN_MAX, curr_pos_z + POSCONTROL_STOPPING_DIST_UP_MAX);
 

end

