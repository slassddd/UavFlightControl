function  update_z_controller()
%update_z_controller - fly to altitude in cm above home
 
    % check for ekf altitude reset
%     check_for_ekf_z_reset();

    % check if leash lengths need to be recalculated
    calc_leash_length_z();

    % call z-axis position controller
    run_z_controller();
 

end

