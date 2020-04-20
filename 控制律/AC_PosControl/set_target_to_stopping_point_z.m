function  set_target_to_stopping_point_z()
% set_target_to_stopping_point_z - returns reasonable stopping altitude in cm above home
global pos_target
    % check if z leash needs to be recalculated
    calc_leash_length_z();

    pos_target(3)=get_stopping_point_z();
end

