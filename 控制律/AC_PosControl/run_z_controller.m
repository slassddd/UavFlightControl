function    run_z_controller()

global limit_pos_up
global limit_pos_down
global limit_vel_up
global limit_vel_down
global throttle_lower   
global throttle_upper   
global use_desvel_ff_z



global curr_alt
global pos_error
global pos_target   %ex
global curr_vel
global vel_error
global vel_target
global vel_desired
global vel_last
global accel_desired
global accel_target
global vel_error_input
global z_accel_meas
global accel_error

global reset_rate_to_accel_z
global freeze_ff_z

global pid_accel_z_reset_filter
global pid_accel_z_input
global pid_accel_z_derivative
global pid_accel_z_integrator
global throttle_hover

% global throttle_


global POSCONTROL_ACCEL_Z
global POSCONTROL_SPEED_DOWN
global POSCONTROL_SPEED_UP
global POSCONTROL_SPEED
global leash_up_z
global leash_down_z
global dt
global reset_accel_to_throttle



global POSCONTROL_POS_Z_P           % vertical position controller P gain default
global POSCONTROL_VEL_Z_P           % vertical velocity controller P gain default
global POSCONTROL_ACC_Z_P           % vertical acceleration controller P gain default
global POSCONTROL_ACC_Z_I           % vertical acceleration controller I gain default
global POSCONTROL_ACC_Z_D           % vertical acceleration controller D gain default
global POSCONTROL_ACC_Z_IMAX        % vertical acceleration controller IMAX gain default
global POSCONTROL_ACC_Z_FILT_HZ     % vertical acceleration controller input filter default
global POSCONTROL_ACC_Z_DT          % vertical acceleration controller dt default
global AC_ATTITUDE_CONTROL_ANGLE_LIMIT_THROTTLE_MAX

global POSCONTROL_VEL_ERROR_CUTOFF_FREQ
global POSCONTROL_THROTTLE_CUTOFF_FREQ
 
 limit_pos_up=0;
 limit_pos_down=0;
 pos_error(3)=pos_target(3)-curr_alt;
 if(pos_error(3)>leash_up_z)
     pos_target(3)=curr_alt+leash_up_z;
     pos_error(3) = leash_up_z;
        limit_pos_up = 1;
 end
    if (pos_error(3) < -leash_down_z)  
        pos_target(3) = curr_alt - leash_down_z;
        pos_error(3) = -leash_down_z;
        limit_pos_down = 1;
    end

    % calculate _vel_target.z using from _pos_error.z using sqrt controller
    vel_target(3) = sqrt_controller(pos_error(3), POSCONTROL_POS_Z_P, POSCONTROL_ACCEL_Z, dt);

    % check speed limits
    % To-Do: check these speed limits here or in the pos->rate controller
        limit_vel_up=0;
        limit_vel_down=0;
    if (vel_target(3) < POSCONTROL_SPEED_DOWN)  
        vel_target(3) = POSCONTROL_SPEED_DOWN;
        limit_vel_down = 1;
    end
     
    if (vel_target(3) > POSCONTROL_SPEED_UP)  
        vel_target(3) = POSCONTROL_SPEED_UP;
        limit_vel_up = 1;
    end

    % add feed forward component
    if (use_desvel_ff_z)  
        vel_target(3) =vel_target(3)+vel_desired(3);
    end
    % the following section calculates acceleration required to achieve the velocity target
    % TODO: remove velocity derivative calculation
    % reset last velocity target to current target
    if (reset_rate_to_accel_z)  
        vel_last(3) = vel_target(3);
    end

    % feed forward desired acceleration calculation
 
%         if (~freeze_ff_z)  
%             accel_desired(3) = (vel_target(3) - vel_last(3)) / dt;
%         else  
%             % stop the feed forward being calculated during a known discontinuity
%             freeze_ff_z = 0;
%         end
%  
     

    % store this iteration's velocities for the next iteration
    vel_last(3)= vel_target(3);

    % reset velocity error and filter if this controller has just been engaged
    if (reset_rate_to_accel_z)  
        % Reset Filter
        vel_error(3) = 0;
        vel_error_input=0;
        reset_rate_to_accel_z = 0;
      else  
        % calculate rate error and filter with cut off frequency of 2 Hz        
        if (POSCONTROL_VEL_ERROR_CUTOFF_FREQ <= 0.0 ) 
        vel_error_input = vel_target(3) - curr_vel(3);
        else
        rc = 1.0/(2*pi*POSCONTROL_VEL_ERROR_CUTOFF_FREQ);
        alpha = dt/(dt+rc);
        vel_error_input=vel_error_input + (vel_target(3) - curr_vel(3) - vel_error_input) * alpha;
        end        
        vel_error(3)=vel_error_input;
    end

    accel_target(3) = POSCONTROL_VEL_Z_P*vel_error(3);

    accel_target(3)=accel_target(3) + accel_desired(3);

    % the following section calculates a desired throttle needed to achieve the acceleration target


    % Calculate Earth Frame Z acceleration
 
    % reset target acceleration if this controller has just been engaged
    if (reset_accel_to_throttle)  
        % Reset Filter
        accel_error(3) = 0;
        reset_accel_to_throttle = 0;
      else  
        % calculate accel error
        accel_error(3) = accel_target(3) - z_accel_meas;
    end

    % set input to PID

    if (pid_accel_z_reset_filter) 
        pid_accel_z_reset_filter = 0;
        pid_accel_z_input = accel_error(3);
        pid_accel_z_derivative = 0.0;
    else
    % update filter and calculate derivative
        if(POSCONTROL_ACC_Z_FILT_HZ==0)
            alpha=1;
        else
            rc = 1.0/(2*pi*POSCONTROL_ACC_Z_FILT_HZ);
            alpha = dt/(dt+rc);
        end 
      input_filt_change = alpha * (accel_error(3) - pid_accel_z_input);
       pid_accel_z_input = pid_accel_z_input + input_filt_change;     
       pid_accel_z_derivative = input_filt_change / dt;
    end
    
   % separately calculate p, i, d values for logging
    p = POSCONTROL_ACC_Z_P*pid_accel_z_input;

    % get i term
    i= pid_accel_z_integrator;

    % ensure imax is always large enough to overpower hover throttle
    if (throttle_hover * 1000.0 > POSCONTROL_ACC_Z_IMAX)  
        POSCONTROL_ACC_Z_IMAX=throttle_hover * 1000.0;
    end
     

    % update i term as long as we haven't breached the limits or the I term will certainly reduce
    % To-Do: should this be replaced with limits check from attitude_controller?
    if ((~throttle_lower && ~throttle_upper) || (i > 0 && accel_error(3) < 0) || (i < 0 && accel_error(3) > 0))      
        if(POSCONTROL_ACC_Z_I~=0 )  
            pid_accel_z_integrator=pid_accel_z_integrator +pid_accel_z_input * POSCONTROL_ACC_Z_I * dt;
            if (pid_accel_z_integrator < -POSCONTROL_ACC_Z_IMAX)  
                pid_accel_z_integrator = -POSCONTROL_ACC_Z_IMAX;
            elseif (pid_accel_z_integrator > POSCONTROL_ACC_Z_IMAX)  
                pid_accel_z_integrator = POSCONTROL_ACC_Z_IMAX;
            end
            i= pid_accel_z_integrator;
        else
            i=0;
        end
    end
      % get d term
    d = POSCONTROL_ACC_Z_D*pid_accel_z_derivative;

    thr_out = (p + i + d) * 0.001 +throttle_hover;
    thr_out=constrain_value(thr_out,0,1);
    % send throttle to attitude controller with angle boost
%     _attitude_control.
% set_throttle_out(throttle_hover, 1, POSCONTROL_THROTTLE_CUTOFF_FREQ);
set_throttle_out(thr_out, 1, POSCONTROL_THROTTLE_CUTOFF_FREQ);

end

