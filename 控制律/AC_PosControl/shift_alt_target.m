function    shift_alt_target(  z_cm)
% shift altitude target (positive means move altitude up)
  global pos_target
  global freeze_ff_z
    pos_target(3)=pos_target(3) + z_cm;

    % freeze feedforward to avoid jump
    if (~z_cm)  
        freeze_ff_z=1;
    end
end

