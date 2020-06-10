function desired_vel_to_pos(  nav_dt)
%  desired_vel_to_pos - move position target using desired velocities
    % range check nav_dt
    global reset_desired_vel_to_pos
    global pos_target
    global vel_desired
    if (nav_dt < 0)  
        return;
    end
     

    % update target position
    if (reset_desired_vel_to_pos)  
        reset_desired_vel_to_pos = 0;
      else  
        pos_target(1) = pos_target(1) + vel_desired(1) * nav_dt;
        pos_target(2) = pos_target(2) + vel_desired(2) * nav_dt;
    end
 
end

