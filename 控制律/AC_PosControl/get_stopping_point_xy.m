function   stopping_point=get_stopping_point_xy()  
% get_stopping_point_xy - calculates stopping point based on current position, velocity, vehicle acceleration
%     distance_max allows limiting distance to stopping point
%     results placed in stopping_position vector
%     set_max_accel_xy() should be called before this method to set vehicle acceleration
%     set_leash_length() should have been called before this method
global curr_vel
global POSCONTROL_POS_XY_P 
global curr_pos
global is_active_xy
global POSCONTROL_ACCEL_XY
global leash
global vel_error

    stopping_point=[0 0];
      kP = POSCONTROL_POS_XY_P;
    % add velocity error to current velocity
    if (is_active_xy)  
        curr_vel(1)=curr_vel(1)+vel_error(1);
        curr_vel(2)=curr_vel(2)+vel_error(2);
    end

    % calculate current velocity
      vel_total = norm(curr_vel(1:2),2);

    % avoid divide by zero by using current position if the velocity is below 10cm/s, kP is very low or acceleration is zero
    if (kP <= 0.0 || POSCONTROL_ACCEL_XY <= 0.0 || (vel_total==0))  
        stopping_point(1) = curr_pos(1);
        stopping_point(2) = curr_pos(2);
        return;
    end

    % calculate point at which velocity switches from linear to sqrt
    linear_velocity = POSCONTROL_ACCEL_XY / kP;

    % calculate distance within which we can stop
    if (vel_total < linear_velocity)  
        stopping_dist = vel_total / kP;
      else  
        linear_distance = POSCONTROL_ACCEL_XY / (2.0 * kP * kP);
        stopping_dist = linear_distance + (vel_total * vel_total) / (2.0 * POSCONTROL_ACCEL_XY);
    end

    % constrain stopping distance
    stopping_dist = constrain_value (stopping_dist, 0, leash);

    % convert the stopping distance into a stopping point using velocity vector
    stopping_point(1) = curr_pos(1) + (stopping_dist * curr_vel(1) / vel_total);
    stopping_point(2) = curr_pos(2) + (stopping_dist * curr_vel(2) / vel_total);
end

