function  set_target_to_stopping_point_xy()
% set_target_to_stopping_point_xy - sets horizontal target to reasonable stopping position in cm from home
global pos_target
    % check if xy leash needs to be recalculated
    calc_leash_length_xy();

    pos_target(1:2)=get_stopping_point_xy();
 
end

