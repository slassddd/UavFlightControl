function  output=get_althold_lean_angle_max()  
% Return tilt angle limit for pilot input that prioritises altitude hold over lean angle
  global althold_lean_angle_max
  global AC_ATTITUDE_CONTROL_ANGLE_LIMIT_MIN
 
   %convert to centi-degrees for public interface
     output=max(ToDeg(althold_lean_angle_max), AC_ATTITUDE_CONTROL_ANGLE_LIMIT_MIN) * 100.0;

 

end

