function  output_to_motors()
global thrust_rpyt_out
global pwm_max
global pwm_min
global pwm_out
global thrust_slew_time
global dt
global tail_tilt
global p_tail_tilt
global mode
    % convert output to PWM and send to each motor
    thrust_dt=(pwm_max-pwm_min)*dt/thrust_slew_time;
    

switch(mode)
   case {1,2,3}
       tail_tilt=0;       
   case {4,5,6}
       tail_tilt=-9556;
%        tail_tilt=0;
end
    tail_tilt_temp=constrain_value(tail_tilt,-5000,700);
    thrust_rpyt_out([2 4])=thrust_rpyt_out([2 4])*((1/cosd(tail_tilt_temp/100)-1)*p_tail_tilt+1);
    for i=1:4
        pwm_out_temp=pwm_min+(pwm_max-pwm_min)*thrust_rpyt_out(i);
        pwm_out(i)=constrain_value(pwm_out_temp,pwm_out(i)-thrust_dt,pwm_out(i)+thrust_dt);
        pwm_out(i)=constrain_value(pwm_out(i),pwm_min,pwm_max);
    end
