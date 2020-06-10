function reset_rate_controller_I_terms()
global rate_pitch_pid_integrator
global rate_roll_pid_ingegrator
global rate_yaw_pid_integrator
 
  rate_pitch_pid_integrator=0;
  rate_roll_pid_ingegrator=0;
  rate_yaw_pid_integrator=0;
 
end

