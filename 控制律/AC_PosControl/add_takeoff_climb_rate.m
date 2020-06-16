function  add_takeoff_climb_rate(  climb_rate_cms,   dt)

% add_takeoff_climb_rate - adjusts alt target up or down using a climb rate in cm/s
%     should be called continuously (with dt set to be the expected time between calls)
%     almost no checks are performed on the input
global pos_target
    pos_target(3) =pos_target(3)+climb_rate_cms * dt;
 
end

