function Nuo=prevent_indecision( Nu)
 global last_Nu
 global target_bearing_cd
 global HD
%    prevent indecision in our turning by using our previous turn
%    decision if we are in a narrow angle band pointing away from the
%    target and the turn angle has changed sign
        Nu_limit = 0.9*pi;
        Nuo=Nu;
    if (abs(Nu) > Nu_limit && abs(last_Nu) > Nu_limit &&abs(wrap_PI(target_bearing_cd/HD/100 - get_yaw())) > 12000/HD/100 &&Nu * last_Nu < 0.0)  
        % we are moving away from the target waypoint and pointing
        % away from the waypoint (not flying backwards). The sign
        % of Nu has also changed, which means we are
        % oscillating in our decision about which way to go
        Nuo = last_Nu;
    end
end

