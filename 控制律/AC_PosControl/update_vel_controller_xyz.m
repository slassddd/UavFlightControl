function  update_vel_controller_xyz()
global dt
global vel_desired
global pos_target
global mode_fy
global climb_rate_cms
% update_velocity_controller_xyz - run the velocity controller - should be called at 100hz or higher
%     velocity targets should we set using set_desired_velocity_xyz() method
%     callers should use get_roll() and get_pitch() methods and sent to the attitude controller
%     throttle targets will be sent directly to the motors

 
    
    
%     alt_t=1000;
%     switch mode_fy
%         case 1     
%             if(pos_target(3)<alt_t)    
%                 set_alt_target_from_climb_rate_ff(250, dt, 0); 
%                 vel_desired(1:2)=[0,1];
%             else        
%                 mode_fy=2;        
%             end        
%         case 2                          
%             set_alt_target_from_climb_rate_ff(0, dt, 0);
%              vel_desired(1:2)=[0,0];
% %             pos_target(3)=alt_t;
%         otherwise
%             pos_target(3)=0;
%             vel_desired(1:2)=0;
%     end
%     %     set_alt_target_with_slew(alt_t,dt)
    set_alt_target_from_climb_rate_ff(climb_rate_cms, dt, 0)
%     update_vel_controller_xy();
    update_z_controller();
 

end

