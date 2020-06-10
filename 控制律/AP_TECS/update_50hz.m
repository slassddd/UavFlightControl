function update_50hz()

 
 %  Written by Paul Riseborough 2013 to provide:
 %  - Combined control of speed and height using throttle to control
 %    total energy and pitch angle to control exchange of energy between
 %    potential and kinetic.
 %    Selectable speed or height priority modes when calculating pitch angle
 %  - Fallback mode when no airspeed measurement is available that
 %    sets throttle based on height rate demand and switches pitch angle control to
 %    height priority
 %  - Underspeed protection that demands maximum throttle and switches pitch angle control
 %    to speed priority mode
 %  - Relative ease of tuning through use of intuitive time constant, integrator and damping gains and the use
 %    of easy to measure aircraft performance data
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    % Implement third order complementary filter for height and height rate
    % estimated height rate = _climb_rate
    % estimated height above field elevation  = _height
    % Reference Paper :
    % Optimizing the Gains of the Baro-Inertial Vertical Channel
    % Widnall W.S, Sinha P.K,
    % AIAA Journal of Guidance and Control, 78-1307R

     
%       if we have a vertical position estimate from the EKF then use
%       it, otherwise use barometric altitude
global dt 
global usEKF
global Vz
global climb_rate
global baro_alt
global accel_ef_z
global GRAVITY_MSS
global hgtCompFiltOmega
global height_filter_height
global height_filter_dd_height
global rot_body_to_ned
global accel_x
global vdot_filter
global vel_dot
% %    Calculate time in seconds since last update
% % 
% %     Use inertial nav verical velocity and height if available
%     if (usEKF)  
%         % if possible use the EKF vertical velocity
%         climb_rate = -vz;
%     else           
% %           use a complimentary filter to calculate climb_rate. This is
% %           designed to minimise lag      
%          % Get height acceleration
%           hgt_ddot_mea = -(accel_ef_z + GRAVITY_MSS);
%         % Perform filter calculation using backwards Euler integration
%         % Coefficients selected to place all three filter poles at omega
%           omega2 = hgtCompFiltOmega*hgtCompFiltOmega;
%           hgt_err = baro_alt - height_filter_height;
%           integ1_input = hgt_err * omega2 * hgtCompFiltOmega;
%           height_filter_dd_height=height_filter_dd_height + integ1_input * dt;
%           integ2_input = height_filter_dd_height + hgt_ddot_mea + hgt_err * omega2 * 3.0;
%           climb_rate=climb_rate + integ2_input * dt;
%           integ3_input = climb_rate + hgt_err * hgtCompFiltOmega * 3.0;
%         % If more than 1 second has elapsed since last update then reset the integrator state
%         % to the measured height
%             height_filter_height=height_filter_height + integ3_input*dt;
%      end
     climb_rate = -Vz;

    % Update and average speed rate of change
    % Get DCM
    % Calculate speed rate of change
      temp = rot_body_to_ned(3,1) * GRAVITY_MSS + accel_x;
    % take 5 point moving average
   
    vdot_filter(5)=vdot_filter(4);   
    vdot_filter(4)=vdot_filter(3); 
    vdot_filter(3)=vdot_filter(2);
    vdot_filter(2)=vdot_filter(1);
    vdot_filter(1)=temp;
    vel_dot = sum(vdot_filter(1:5))/5;
end

