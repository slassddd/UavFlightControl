function   set_alt_target_from_climb_rate_ff(  climb_rate_cms,   dt,   force_descend)
 
%     set_alt_target_from_climb_rate_ff - adjusts target up or down using a climb rate in cm/s using feed-forward
%     should be called continuously (with dt set to be the expected time between calls)
%     actual position target will be moved no faster than the speed_down and speed_up
%     target will also be stopped if the motors hit their limits or leash length is exceeded
%     set force_descend to true during landing to allow target to move low enough to slow the motors
global POSCONTROL_ACCEL_Z
global POSCONTROL_SPEED_DOWN
global POSCONTROL_SPEED_UP
global vel_desired
global POSCONTROL_JERK_RATIO
global accel_last_z_cms
global use_desvel_ff_z
global pos_target
global POSCONTROL_OVERSPEED_GAIN_Z
global throttle_lower
% global force_descend
global throttle_upper
global limit_pos_up

    % calculated increased maximum acceleration if over speed
      accel_z_cms = POSCONTROL_ACCEL_Z;
    if (vel_desired(3) < POSCONTROL_SPEED_DOWN && POSCONTROL_SPEED_DOWN~=0)  
        accel_z_cms =accel_z_cms*POSCONTROL_OVERSPEED_GAIN_Z * vel_desired(3) / POSCONTROL_SPEED_DOWN;
    end
    if (vel_desired(3) > POSCONTROL_SPEED_UP &&POSCONTROL_SPEED_UP~=0)  
        accel_z_cms= accel_z_cms* POSCONTROL_OVERSPEED_GAIN_Z * vel_desired(3) / POSCONTROL_SPEED_UP;
    end
    accel_z_cms = constrain_value(accel_z_cms, 0.0, 750.0);

    % jerk_z is calculated to reach full acceleration in 1000ms.
      jerk_z = accel_z_cms * POSCONTROL_JERK_RATIO;
      accel_z_max = min(accel_z_cms, sqrt(2.0 * abs(vel_desired(3) - climb_rate_cms) * jerk_z));

    accel_last_z_cms=accel_last_z_cms + jerk_z * dt;
    accel_last_z_cms = min(accel_z_max, accel_last_z_cms);

     vel_change_limit = accel_last_z_cms * dt;
    vel_desired(3) = constrain_value(climb_rate_cms, vel_desired(3) - vel_change_limit, vel_desired(3) + vel_change_limit);
    use_desvel_ff_z = 1;

    % adjust desired alt if motors have not hit their limits
    % To-Do: add check of _limit.pos_down?
    if ((vel_desired(3) < 0 && (~throttle_lower || force_descend)) || (vel_desired(3) > 0 && ~throttle_upper && ~limit_pos_up))  
        pos_target(3) =pos_target(3)+vel_desired(3) * dt;
    end
     
end

