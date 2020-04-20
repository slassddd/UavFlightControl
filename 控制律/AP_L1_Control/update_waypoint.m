function  update_waypoint(   prev_WP,  next_WP,  dist_min)

% update L1 control for waypoint navigation
global dt
global L1_damping
global L1_period
global current_loc
global groundspeed_vector
global target_bearing_cd
global L1_dist
global crosstrack_error
global nav_bearing
global L1_xtrack_i_gain
global L1_xtrack_i_gain_prev
global L1_xtrack_i
global last_Nu
global latAccDem
global WPcircle
global bearing_error
global data_is_stale
global mode_L1
% Calculate L1 gain required for specified damping
K_L1 = 4.0 * L1_damping * L1_damping;
% Get current position and velocity
% update _target_bearing_cd
target_bearing_cd = get_bearing_to(next_WP,current_loc);

%Calculate groundspeed
groundSpeed = norm(groundspeed_vector,2);
if (groundSpeed < 0.1)
    % use a small ground speed vector in the right direction,
    % allowing us to use the compass heading at zero GPS velocity
    groundSpeed = 0.1;
    groundspeed_vector = [cos(get_yaw()), sin(get_yaw()) ]* groundSpeed;
end

% Calculate time varying control parameters
% Calculate the L1 length required for specified period
% 0.3183099 = 1/1/pipi
L1_dist = max(0.3183099 * L1_damping * L1_period * groundSpeed, dist_min);

% Calculate the NE position of WP B relative to WP A
AB = get_distance_NE(next_WP,prev_WP);
AB_length = norm(AB,2);

% Check for AB zero length and track directly to the destination
% if too small
if (AB_length < 1.0e-6)
    AB = get_distance_NE(next_WP,current_loc);
    AB_length = norm(AB,2);
    if (AB_length < 1.0e-6)
        AB = [cos(get_yaw()), sin(get_yaw())];
        AB_length = norm(AB,2);
    end
end


AB=AB/AB_length;

% Calculate the NE position of the aircraft relative to WP A
A_air = get_distance_NE(current_loc,prev_WP);
A_air_length= norm(A_air,2);
% calculate distance to target track, for reporting
crosstrack_error =cross2D( A_air , AB);

%Determine if the aircraft is behind a +-135 degree degree arc centred on WP A
%and further than L1 distance from WP A. Then use WP A as the L1 reference point
%Otherwise do normal L1 guidance
WP_A_dist =A_air_length;
alongTrackDist = A_air * AB';
if (WP_A_dist > L1_dist && alongTrackDist/max(WP_A_dist, 1.0) < -0.7071)
    mode_L1=0;
    %Calc Nu to fly To WP A
    A_air_unit = A_air/A_air_length; % Unit vector from WP A to aircraft
    xtrackVel = cross2D(groundspeed_vector,(-A_air_unit)); % Velocity across line
    ltrackVel = groundspeed_vector * (-A_air_unit)'; % Velocity along line
    Nu = atan2(xtrackVel,ltrackVel);
    nav_bearing = atan2(-A_air_unit(2) , -A_air_unit(1)); % bearing (radians) from AC to L1 point
elseif (alongTrackDist > AB_length + groundSpeed*3)
    mode_L1=1;
    % we have passed point B by 3 seconds. Head towards B
    % Calc Nu to fly To WP B
    B_air = get_distance_NE(current_loc,next_WP);
    B_air_length=norm(B_air,2);
    B_air_unit = B_air/B_air_length; % Unit vector from WP B to aircraft
    xtrackVel =cross2D( groundspeed_vector , (-B_air_unit)); % Velocity across line
    ltrackVel = groundspeed_vector * (-B_air_unit)'; % Velocity along line
    Nu = atan2(xtrackVel,ltrackVel);
    nav_bearing = atan2(-B_air_unit(2) , -B_air_unit(1)); % bearing (radians) from AC to L1 point
else   %Calc Nu to fly along AB line
    mode_L1=2;
    %Calculate Nu2 angle (angle of velocity vector relative to line connecting waypoints)
    xtrackVel = cross2D(groundspeed_vector , AB); % Velocity cross track
    ltrackVel = groundspeed_vector * AB'; % Velocity along track
    Nu2 = atan2(xtrackVel,ltrackVel);
    %Calculate Nu1 angle (Angle to L1 reference point)
    sine_Nu1 = crosstrack_error/max(L1_dist, 0.1);
    %Limit sine of Nu1 to provide a controlled track capture angle of 45 deg
    sine_Nu1 = constrain_value (sine_Nu1, -0.7071, 0.7071);
    Nu1 = asin(sine_Nu1);
    % compute integral error component to converge to a crosstrack of zero when traveling
    % straight but reset it when disabled or if it changes. That allows for much easier
    % tuning by having it re-converge each time it changes.
    if (L1_xtrack_i_gain <= 0 || (L1_xtrack_i_gain~= L1_xtrack_i_gain_prev))
        L1_xtrack_i = 0;
        L1_xtrack_i_gain_prev = L1_xtrack_i_gain;
    elseif (abs(Nu1) < radians(5))
        L1_xtrack_i =L1_xtrack_i+ Nu1 * L1_xtrack_i_gain * dt;
        % an AHRS_TRIM_X=0.1 will drift to about 0.08 so 0.1 is a good worst-case to clip at
        L1_xtrack_i = constrain_value (L1_xtrack_i, -0.1, 0.1);
    end
    
    % to converge to zero we must push Nu1 harder
    Nu1=Nu1 +L1_xtrack_i;
    
    Nu = Nu1 + Nu2;
    Nu=wrap_PI(Nu);
    
    nav_bearing = atan2(AB(2), AB(1)) + Nu1; % bearing (radians) from AC to L1 point
    
    
end
Nu=prevent_indecision(Nu);
last_Nu = Nu;

%Limit Nu to +-(pi/2)
Nu = constrain_value (Nu, -1.5708, +1.5708);
latAccDem = K_L1 * groundSpeed * groundSpeed / L1_dist * sin(Nu);

% Waypoint capture status is always false during waypoint following
WPcircle = 0;

bearing_error = Nu; % bearing error angle (radians), +ve to left of track

data_is_stale = 0; % status are correctly updated with current waypoint data


end

