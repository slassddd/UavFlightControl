function output_armed_stabilizing()
% 
%       i;                          % general purpose counter
%        roll_thrust;                % roll thrust input value, +/- 1.0
%        pitch_thrust;               % pitch thrust input value, +/- 1.0
%        yaw_thrust;                 % yaw thrust input value, +/- 1.0
%        throttle_thrust;            % throttle thrust input value, 0.0 - 1.0
%        throttle_avg_max;           % throttle thrust average maximum value, 0.0 - 1.0
%        throttle_thrust_max;        % throttle thrust maximum value, 0.0 - 1.0
%        throttle_thrust_best_rpy;   % throttle providing maximum roll, pitch and yaw range without climbing
%        rpy_scale = 1.0;           % this is used to scale the roll, pitch and yaw to fit within the motor limits
%        yaw_allowed = 1.0;         % amount of yaw we can fit in
%        thr_adj;                    % the difference between the pilot's desired throttle and throttle_thrust_best_rpy
 global roll_in
 global pitch_in
 global yaw_in
 global throttle_filter
 global throttle_avg_max
 global thrust_boost_ratio
 global throttle_lower
 global throttle_upper
 global thrust_rpyt_out
 global roll_factor
 global pitch_factor
 global yaw_factor 
 global yaw_headroom
 global limit_roll_pitch
 global limit_yaw
 global current_tilt
 global throttle_thrust_max
 global thrust_boost
 global Kx
 rpy_scale=1;
    % apply voltage and air pressure compensation
    compensation_gain = get_compensation_gain(); % compensation for battery voltage and altitude
    roll_thrust = roll_in * compensation_gain;
    pitch_thrust = pitch_in * compensation_gain;
    yaw_thrust = yaw_in * compensation_gain;
    throttle_thrust = throttle_filter * compensation_gain;
    throttle_avg_maxi = throttle_avg_max * compensation_gain;
    throttle_thrust_max = thrust_boost_ratio + (1.0 - thrust_boost_ratio) * throttle_thrust_max;
    throttle_lower=0;
    % sanity check throttle is above zero and below current limited throttle
    if (throttle_thrust <= 0.0)  
        throttle_thrust = 0.0;
        throttle_lower = 1;
    end
    throttle_upper=0;
    if (throttle_thrust >= throttle_thrust_max)  
        throttle_thrust = throttle_thrust_max;
        throttle_upper = 1;
    end
    
    % ensure that throttle_avg_max is between the input throttle and the maximum throttle
    throttle_avg_maxi = constrain_value(throttle_avg_maxi, throttle_thrust, throttle_thrust_max);

    % calculate throttle that gives most possible room for yaw which is the lower of:
    %      1. 0.5f - (rpy_low+rpy_high)/2.0 - this would give the maximum possible margin above the highest motor and below the lowest
    %      2. the higher of:
    %            a) the pilot's throttle input
    %            b) the point _throttle_rpy_mix between the pilot's input throttle and hover-throttle
    %      Situation #2 ensure we never increase the throttle above hover throttle unless the pilot has commanded this.
    %      Situation #2b allows us to raise the throttle above what the pilot commanded but not so far that it would actually cause the copter to rise.
    %      We will choose #1 (the best throttle for yaw control) if that means reducing throttle to the motors (i.e. we favor reducing throttle *because* it provides better yaw control)
    %      We will choose #2 (a mix of pilot and hover throttle) only when the throttle is quite low.  We favor reducing throttle instead of better yaw control because the pilot has commanded it

    % Under the motor lost condition we remove the highest motor output from our calculations and let that motor go greater than 1.0
    % To ensure control and maximum righting performance Hex and Octo have some optimal settings that should be used
    % Y6               : MOT_YAW_HEADROOM = 350, ATC_RAT_RLL_IMAX = 1.0,   ATC_RAT_PIT_IMAX = 1.0,   ATC_RAT_YAW_IMAX = 0.5
    % Octo-Quad (x8) x : MOT_YAW_HEADROOM = 300, ATC_RAT_RLL_IMAX = 0.375, ATC_RAT_PIT_IMAX = 0.375, ATC_RAT_YAW_IMAX = 0.375
    % Octo-Quad (x8) + : MOT_YAW_HEADROOM = 300, ATC_RAT_RLL_IMAX = 0.75,  ATC_RAT_PIT_IMAX = 0.75,  ATC_RAT_YAW_IMAX = 0.375
    % Usable minimums below may result in attitude offsets when motors are lost. Hex aircraft are only marginal and must be handles with care
    % Hex              : MOT_YAW_HEADROOM = 0,   ATC_RAT_RLL_IMAX = 1.0,   ATC_RAT_PIT_IMAX = 1.0,   ATC_RAT_YAW_IMAX = 0.5
    % Octo-Quad (x8) x : MOT_YAW_HEADROOM = 300, ATC_RAT_RLL_IMAX = 0.25,  ATC_RAT_PIT_IMAX = 0.25,  ATC_RAT_YAW_IMAX = 0.25
    % Octo-Quad (x8) + : MOT_YAW_HEADROOM = 300, ATC_RAT_RLL_IMAX = 0.5,   ATC_RAT_PIT_IMAX = 0.5,   ATC_RAT_YAW_IMAX = 0.25
    % Quads cannot make use of motor loss handling because it doesn't have enough degrees of freedom.

    % calculate amount of yaw we can fit into the throttle range
    % this is always equal to or less than the requested yaw from the pilot or rate controller
     rp_low = 1.0;    % lowest thrust value
     rp_high = -1.0;  % highest thrust value
    for i=1:4 
             % calculate the thrust outputs for roll and pitch
            thrust_rpyt_out(i) = roll_thrust * roll_factor(i) + pitch_thrust * (pitch_factor(i)+ abs(pitch_factor(i))*Kx*0);
            
            
            % record lowest roll+pitch command
            if (thrust_rpyt_out(i) < rp_low)  
                rp_low = thrust_rpyt_out(i);
            end
            % record highest roll+pitch command
            if (thrust_rpyt_out(i) > rp_high && (~thrust_boost ))  
                rp_high = thrust_rpyt_out(i);
            end
    end
  
%     % include the lost motor scaled by _thrust_boost_ratio
%     if (_thrust_boost && motor_enabled[_motor_lost_index])  
%         % record highest roll+pitch command
%         if (_thrust_rpyt_out[_motor_lost_index] > rp_high)  
%             rp_high = _thrust_boost_ratio*rp_high + (1.0f-_thrust_boost_ratio)*_thrust_rpyt_out[_motor_lost_index];
%         end    
%     end
     

    % check for roll and pitch saturation
    if (rp_high-rp_low > 1.0 || throttle_avg_maxi < -rp_low)  
        % Full range is being used by roll and pitch.
        limit_roll_pitch = 1;
    end

    % calculate the highest allowed average thrust that will provide maximum control range
    throttle_thrust_best_rpy = min(0.5, throttle_avg_maxi);

    % calculate the maximum yaw control that can be used
    % todo: make _yaw_headroom 0 to 1
    yaw_allowed = yaw_headroom / 1000.0;
    yaw_allowed = thrust_boost_ratio*0.5 + (1.0- thrust_boost_ratio) * yaw_allowed;
    yaw_allowed = max(min(throttle_thrust_best_rpy+rp_low, 1.0 - (throttle_thrust_best_rpy + rp_high)), yaw_allowed)/2.5599;
    if (abs(yaw_thrust) > yaw_allowed)  
        % not all commanded yaw can be used
        yaw_thrust = constrain_value(yaw_thrust, -yaw_allowed, yaw_allowed);
        limit_yaw = 1;
    end

    % add yaw control to thrust outputs
     rpy_low = 1.0;   % lowest thrust value
     rpy_high = -1.0; % highest thrust value
    for i=1:4
             thrust_rpyt_out(i) = thrust_rpyt_out(i) + yaw_thrust * yaw_factor(i);
            % record lowest roll+pitch+yaw command
            if (thrust_rpyt_out(i) < rpy_low)  
                rpy_low = thrust_rpyt_out(i);
            end
            % record highest roll+pitch+yaw command
            if (thrust_rpyt_out(i) > rpy_high )  
                rpy_high = thrust_rpyt_out(i);
            end            
    end
         
     
    % include the lost motor scaled by _thrust_boost_ratio
%     if (_thrust_boost)  
%         % record highest roll+pitch+yaw command
%         if (_thrust_rpyt_out[_motor_lost_index] > rpy_high && motor_enabled[_motor_lost_index])  
%             rpy_high = _thrust_boost_ratio*rpy_high + (1.0f-_thrust_boost_ratio)*_thrust_rpyt_out[_motor_lost_index];
%          
     

    % calculate any scaling needed to make the combined thrust outputs fit within the output range
    if (rpy_high-rpy_low > 1.0)  
        rpy_scale = 1.0 / (rpy_high-rpy_low);
    end
    if (rpy_low<0)  
        rpy_scale = min(rpy_scale, -throttle_avg_maxi / rpy_low);
    end

    % calculate how close the motors can come to the desired throttle
    rpy_high =rpy_high* rpy_scale;
    rpy_low=rpy_low* rpy_scale;
    throttle_thrust_best_rpy = -rpy_low;
    thr_adj = throttle_thrust - throttle_thrust_best_rpy;
    if (rpy_scale < 1.0)  
        % Full range is being used by roll, pitch, and yaw.
        limit_roll_pitch = 1;
        limit_yaw = 1;
        if (thr_adj > 0.0)  
            throttle_upper = 1;
        end
        thr_adj = 0.0;     
    else  
        if (thr_adj < 0.0)  
            % Throttle can't be reduced to desired value
            % todo: add lower limit flag and ensure it is handled correctly in altitude controller
            thr_adj = 0.0;
        elseif (thr_adj > 1.0 - (throttle_thrust_best_rpy + rpy_high))  
            % Throttle can't be increased to desired value
            thr_adj = 1.0 - (throttle_thrust_best_rpy + rpy_high);
            throttle_upper = 1;
        end
    end
     

    % add scaled roll, pitch, constrained yaw and throttle for each motor
    for i=1:4  
             thrust_rpyt_out(i) = throttle_thrust_best_rpy + thr_adj + (rpy_scale * thrust_rpyt_out(i));   
    end
     thrust_rpyt_out([2 4])=thrust_rpyt_out([2 4])*cos(current_tilt);

    % check for failed motor
%     check_for_failed_motor(throttle_thrust_best_rpy + thr_adj);
 
end

