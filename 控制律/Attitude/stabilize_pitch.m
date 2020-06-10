function stabilize_pitch(  speed_scaler)
 
%   this is the main pitch stabilization function. It takes the
%   previously set nav_pitch and calculates servo_out values to try to
%   stabilize the plane at the given attitude.
global nav_pitch_cd
global kff_throttle_to_pitch
global k_elevator
global k_throttle
global pitch
global HD
global disable_integrator_pitch
%     int8_t force_elevator = takeoff_tail_hold();
%     if (force_elevator != 0)  
%         % we are holding the tail down during takeoff. Just convert
%         % from a percentage to a -4500..4500 centidegree angle
%         SRV_Channels::set_output_scaled(SRV_Channel::k_elevator, 45*force_elevator);
%         return;
%     end
  demanded_pitch = nav_pitch_cd  + k_throttle * kff_throttle_to_pitch;
  k_elevator=get_servo_out_pitch(demanded_pitch - pitch*HD*100,  speed_scaler, disable_integrator_pitch);
  
%   set_output_scaled( k_elevator, get_servo_out_pitch(demanded_pitch - ahrs.pitch_sensor, 
%                                                                                            speed_scaler, 
%                                                                                            disable_integrator));
%  
end

