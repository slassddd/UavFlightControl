function    calc_throttle()
 global throttle_dem
 global k_throttle
%     if (aparm.throttle_cruise <= 1)  
% %         user has asked for zero throttle - this may be done by a
% %         mission which wants to turn off the engine for a parachute
% %         landing
%         set_output_scaled(k_throttle, 0);
%         return;
%     end

%      commanded_throttle = throttle_dem;

    % Received an external msg that guides throttle in the last 3 seconds?
%     if ((control_mode == &mode_guided || control_mode == &mode_avoidADSB) &&
%             plane.guided_state.last_forced_throttle_ms > 0 &&
%             millis() - plane.guided_state.last_forced_throttle_ms < 3000)  
%         commanded_throttle = plane.guided_state.forced_throttle;
%     end
k_throttle=throttle_dem;
%     set_output_scaled(k_throttle, commanded_throttle);
end

