function  stabilize()
% %   main stabilization function for all 3 axes
%  
%  
      speed_scaler = get_speed_scaler();
% 
% %     if (quadplane.in_tailsitter_vtol_transition())  
% %          
% % %           during transition to vtol in a tailsitter try to raise the
% % %           nose rapidly while keeping the wings level        
% %         nav_pitch_cd = constrain_value((quadplane.tailsitter.transition_angle+5)*100, 5500, 8500),
% %         nav_roll_cd = 0;
% %     end
%     
%     if (control_mode == &mode_training)  
%         stabilize_training(speed_scaler);
%       else if (control_mode == &mode_acro)  
%         stabilize_acro(speed_scaler);
%       else if ((control_mode == &mode_qstabilize ||
%                 control_mode == &mode_qhover ||
%                 control_mode == &mode_qloiter ||
%                 control_mode == &mode_qland ||
%                 control_mode == &mode_qrtl ||
%                 control_mode == &mode_qacro ||
%                 control_mode == &mode_qautotune) &&
%                !quadplane.in_tailsitter_vtol_transition())  
%         quadplane.control_run();
%       else  
%         if (g.stick_mixing == STICK_MIXING_FBW && control_mode != &mode_stabilize)  
%             stabilize_stick_mixing_fbw();
%          
%         stabilize_roll(speed_scaler);
%         stabilize_pitch(speed_scaler);
%         if (g.stick_mixing == STICK_MIXING_DIRECT || control_mode == &mode_stabilize)  
%             stabilize_stick_mixing_direct();
%           stabilize_roll(speed_scaler);
%         stabilize_pitch(speed_scaler);       
%         stabilize_yaw(speed_scaler);
%      
% 
%     /*
%       see if we should zero the attitude controller integrators. 
%      */
%     if (get_throttle_input() == 0 &&
%         fabsf(relative_altitude) < 5.0f && 
%         fabsf(barometer.get_climb_rate()) < 0.5f &&
%         gps.ground_speed() < 3)  
%         % we are low, with no climb rate, and zero throttle, and very
%         % low ground speed. Zero the attitude controller
%         % integrators. This prevents integrator buildup pre-takeoff.
%         rollController.reset_I();
%         pitchController.reset_I();
%         stabilize_rollyawController.reset_I();
% 
%         % if moving very slowly also zero the steering integrator
%         if (gps.ground_speed() < 1)  
%             steerController.reset_I();            
%          
%      
        stabilize_roll(speed_scaler);
        stabilize_pitch(speed_scaler);       
        stabilize_yaw(speed_scaler); 

end

