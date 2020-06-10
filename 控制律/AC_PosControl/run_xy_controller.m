function run_xy_controller(dt)
global POSCONTROL_POS_XY_P % horizontal position controller P gain default
global POSCONTROL_VEL_XY_P  % horizontal velocity controller P gain default
global POSCONTROL_VEL_XY_I  % horizontal velocity controller I gain default
global POSCONTROL_VEL_XY_D % horizontal velocity controller D gain default
global POSCONTROL_VEL_XY_IMAX   % horizontal velocity controller IMAX gain default
global POSCONTROL_VEL_XY_FILT_HZ  % horizontal velocity controller input filter
global POSCONTROL_VEL_XY_FILT_D_HZ  % horizontal velocity controller input filter for D
global pid_vel_xy_derivative
global pid_vel_xy_integrator
global pid_vel_xy_reset_filter
global pid_vel_xy_input
global reset_accel_to_lean_xy
global POSCONTROL_ACCEL_FILTER_HZ
global accel_xy_input
global GRAVITY_MSS
global POSCONTROL_ACCEL_XY_MAX

global pos_target
global curr_pos
global pos_error

global vel_target
global vel_desired
global vel_error

global accel_target
global accel_desired

global leash
global POSCONTROL_ACCEL_XY
global curr_vel


global limit_accel_xy
global motors_limit_throttle_upper
global accel_xy_angle_max

global roll_target
global pitch_target
% run horizontal position controller correcting position and velocity
%  converts position (_pos_target) to target velocity (_vel_target)
%  desired velocity (_vel_desired) is combined into final target velocity
%  converts desired velocities in lat/lon directions to accelerations in lat/lon frame
%  converts desired accelerations provided in lat/lon frame to roll/pitch angles
  kP =POSCONTROL_POS_XY_P; % scale gains to compensate for noisy optical flow measurement in the EKF

 % avoid divide by zero
 if (kP <= 0.0)  
  vel_target(1) = 0.0;
  vel_target(2) = 0.0;
 else  
  % calculate distance error
  pos_error(1) = pos_target(1) - curr_pos(1);
  pos_error(2) = pos_target(2) - curr_pos(2);

  % Constrain _pos_error and target position
  % Constrain the maximum length of _vel_target to the maximum position correction velocity
  % TODO: replace the leash length with a user definable maximum position correction
[bool,pos_error(1),pos_error(2)]= limit_vector_length(pos_error(1), pos_error(2), leash);
  if (bool)  
   pos_target(1) = curr_pos(1) + pos_error(1);
   pos_target(2) = curr_pos(2) + pos_error(2);
  end   
  vel_target = sqrt_controller_pos(pos_error, kP, POSCONTROL_ACCEL_XY);
 end

 % add velocity feed-forward
 vel_target(1)=vel_target(1) + vel_desired(1);
 vel_target(2)=vel_target(2) + vel_desired(2);
 
 % calculate velocity error
 vel_error(1) = vel_target(1) - curr_vel(1);
 vel_error(2) = vel_target(2) - curr_vel(2);
 % TODO: constrain velocity error and velocity target
 if(POSCONTROL_VEL_XY_FILT_HZ==0)
  filt_alpha=1;
 else
  rc=1/(2*pi*POSCONTROL_VEL_XY_FILT_HZ);
  filt_alpha=dt/(dt+rc);
 end
 if(POSCONTROL_VEL_XY_FILT_D_HZ==0)
  filt_alpha_d=1;
 else
  rc=1/(2*pi*POSCONTROL_VEL_XY_FILT_D_HZ);
  filt_alpha_d=dt/(dt+rc);
 end 
 if(pid_vel_xy_reset_filter==1)
     pid_vel_xy_reset_filter=0;
     pid_vel_xy_derivative=[0 0];
     pid_vel_xy_integrator=[0 0]; 
     pid_vel_xy_input=vel_error(1:2);
 end
  
   input_delta = (vel_error(1:2) - pid_vel_xy_input) * filt_alpha;
    pid_vel_xy_input=pid_vel_xy_input + input_delta;

    derivative = input_delta / dt;
    delta_derivative = (derivative - pid_vel_xy_derivative) * filt_alpha_d;
    pid_vel_xy_derivative =pid_vel_xy_derivative + delta_derivative;
 
    vel_xy_p =POSCONTROL_VEL_XY_P*pid_vel_xy_input;

 % update i term if we have not hit the accel or throttle limits OR the i term will reduce
 % TODO: move limit handling into the PI and PID controller
 if (~limit_accel_xy && ~motors_limit_throttle_upper)  
     pid_vel_xy_integrator=pid_vel_xy_integrator+pid_vel_xy_input*POSCONTROL_VEL_XY_I*dt;
     integrator_length=norm(pid_vel_xy_integrator,2);
         if((integrator_length>POSCONTROL_VEL_XY_IMAX )&&(integrator_length>0))
            pid_vel_xy_integrator=pid_vel_xy_integrator*POSCONTROL_VEL_XY_IMAX/integrator_length;
         end
     vel_xy_i = pid_vel_xy_integrator;
 else
     integrator_length=norm(pid_vel_xy_integrator,2);
     integrator_length_orig = min(integrator_length, POSCONTROL_VEL_XY_IMAX);
     pid_vel_xy_integrator = pid_vel_xy_integrator+ pid_vel_xy_input *POSCONTROL_VEL_XY_I * dt;
     integrator_length_new =norm(pid_vel_xy_integrator,2);
        if ((integrator_length_new > integrator_length_orig) && (integrator_length_new>0))  
           pid_vel_xy_integrator=pid_vel_xy_integrator * (integrator_length_orig / integrator_length_new);
        end
        vel_xy_i=pid_vel_xy_integrator;
  end
 vel_xy_d=POSCONTROL_VEL_XY_D*pid_vel_xy_derivative;
accel_targeti=vel_xy_p+vel_xy_i+vel_xy_d;
 
 if(reset_accel_to_lean_xy==1)
     accel_xy_input=accel_targeti;
     reset_accel_to_lean_xy=0;
 end
 if(POSCONTROL_ACCEL_FILTER_HZ<=0) 
    accel_xy_input=accel_targeti;
 else
    rc = 1.0/(2*pi*POSCONTROL_ACCEL_FILTER_HZ);
    alpha_accel_xy=dt/(dt+rc);
    accel_xy_input=accel_xy_input + (accel_targeti - accel_xy_input) * alpha_accel_xy;     
 end
    accel_target(1:2)=accel_xy_input+accel_desired(1:2);


 % the following section converts desired accelerations provided in lat/lon frame to roll/pitch angles

 % limit acceleration using maximum lean angles
    accel_max = min(GRAVITY_MSS * 100.0* tand(accel_xy_angle_max * 0.01), POSCONTROL_ACCEL_XY_MAX);
    [limit_accel_xy,accel_target(1),accel_target(2)] = limit_vector_length( accel_target(1),  accel_target(2), accel_max);

 % update angle targets that will be passed to stabilize controller
 [roll_target, pitch_target]=accel_to_lean_angles( accel_target(1), accel_target(2));
 
end

