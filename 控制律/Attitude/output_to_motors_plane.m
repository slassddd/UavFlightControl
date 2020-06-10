function  output_to_motors_plane()
global k_throttle
global pwm_max
global pwm_min
global pwm_out
global thrust_slew_time
global dt
global tail_tilt
global mode

    % convert output to PWM and send to each motor
 switch(mode)
   case {1,2,3}
       tail_tilt=0;       
   case {4,5,6}
       tail_tilt=-9556;
%        tail_tilt=0;
end       
        thrust_dt=(pwm_max-pwm_min)*dt/thrust_slew_time;
    for i=2:2:4
        pwm_out_temp=pwm_min+(pwm_max-pwm_min)*k_throttle;
        pwm_out(i)=constrain_value(pwm_out_temp,pwm_out(i)-thrust_dt,pwm_out(i)+thrust_dt);
        pwm_out(i)=constrain_value(pwm_out(i),pwm_min,pwm_max);
    end
    for i=1:2:3
        pwm_out_temp=pwm_min;
        pwm_out(i)=constrain_value(pwm_out_temp,pwm_out(i)-thrust_dt,pwm_out(i)+thrust_dt);
        pwm_out(i)=constrain_value(pwm_out(i),pwm_min,pwm_max);
    end
