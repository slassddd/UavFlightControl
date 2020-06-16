function  stabilize_yaw(  speed_scaler)
 
 
%     if (landing.is_flaring())  
%         % in flaring then enable ground steering
%         steering_control.ground_steering = true;
%       else  
%         % otherwise use ground steering when no input control and we
%         % are below the GROUND_STEER_ALT
%         steering_control.ground_steering = (channel_roll->get_control_in() == 0 && 
%                                             fabsf(relative_altitude) < g.ground_steer_alt);
%         if (!landing.is_ground_steering_allowed())  
%             % don't use ground steering on landing approach
%             steering_control.ground_steering = false;
%          
%      
% 
% 
%     
% %       first calculate steering_control.steering for a nose or tail
% %       wheel. We use "course hold" mode for the rudder when either performing
% %       a flare (when the wings are held level) or when in course hold in
% %       FBWA mode (when we are below GROUND_STEER_ALT)
%      
%     if (landing.is_flaring() ||
%         (steer_state.hold_course_cd != -1 && steering_control.ground_steering))  
%         calc_nav_yaw_course();
%       else if (steering_control.ground_steering)  
%         calc_nav_yaw_ground();
     

 
%       now calculate steering_control.rudder for the rudder
 
    calc_nav_yaw_coordinated(speed_scaler);
 
end

