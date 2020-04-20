%AC_AttitudeControl matlab sim

      rate_yaw_pid_reset_filter=0;
      rate_yaw_pid_input=0;
      rate_yaw_pid_derivative=0;
      rate_yaw_pid_integrator=0;
      motors_limit_yaw=0;

      rate_roll_pid_reset_filter=0;
      rate_roll_pid_input=0;
      rate_roll_pid_derivative=0;
      rate_roll_pid_integrator=0;
      motors_limit_roll_pitch=0;

      rate_pitch_pid_reset_filter=0;
      rate_pitch_pid_input=0;
      rate_pitch_pid_derivative=0;
      rate_pitch_pid_integrator=0;
    


    
%      @Param: SLEW_YAW
%      @DisplayName: Yaw target slew rate
%      @Description: Maximum rate the yaw target can be updated in Loiter, RTL, Auto flight modes
%      @Units: cdeg/s
%      @Range: 500 18000
%      @Increment: 100
%      @User: Advanced
slew_yaw=6000;
%      @Param: ACCEL_Y_MAX
%      @DisplayName: Acceleration Max for Yaw
%      @Description: Maximum acceleration in yaw axis
%      @Units: cdeg/s/s
%      @Range: 0 72000
%      @Values: 0:Disabled, 9000:VerySlow, 18000:Slow, 36000:Medium, 54000:Fast
%      @Increment: 1000
%      @User: Advanced
accel_yaw_max=18000;
%      @Param: RATE_FF_ENAB
%      @DisplayName: Rate Feedforward Enable
%      @Description: Controls whether body-frame rate feedfoward is enabled or disabled
%      @Values: 0:Disabled, 1:Enabled
%      @User: Advanced
rate_bf_ff_enabled=1;
%      @Param: ACCEL_R_MAX
%      @DisplayName: Acceleration Max for Roll
%      @Description: Maximum acceleration in roll axis
%      @Units: cdeg/s/s
%      @Range: 0 180000
%      @Increment: 1000
%      @Values: 0:Disabled, 30000:VerySlow, 72000:Slow, 108000:Medium, 162000:Fast
%      @User: Advanced
accel_roll_max=72000;
%      @Param: ACCEL_P_MAX
%      @DisplayName: Acceleration Max for Pitch
%      @Description: Maximum acceleration in pitch axis
%      @Units: cdeg/s/s
%      @Range: 0 180000
%      @Increment: 1000
%      @Values: 0:Disabled, 30000:VerySlow, 72000:Slow, 108000:Medium, 162000:Fast
%      @User: Advanced
accel_pitch_max=30000; 
%      @Param: ANGLE_BOOST
%      @DisplayName: Angle Boost
%      @Description: Angle Boost increases output throttle as the vehicle leans to reduce loss of altitude
%      @Values: 0:Disabled, 1:Enabled
%      @User: Advanced
angle_boost_enabled=1;
%      @Param: ANG_RLL_P
%      @DisplayName: Roll axis angle controller P gain
%      @Description: Roll axis angle controller P gain.  Converts the error between the desired roll angle and actual angle to a desired roll rate
%      @Range: 3.000 12.000
%      @Range{Sub}: 0.0 12.000
%      @User: Standard
p_angle_roll=3;
%      @Param: ANG_PIT_P
%      @DisplayName: Pitch axis angle controller P gain
%      @Description: Pitch axis angle controller P gain.  Converts the error between the desired pitch angle and actual angle to a desired pitch rate
%      @Range: 3.000 12.000
%      @Range{Sub}: 0.0 12.000
%      @User: Standard
p_angle_pitch=3;
%      @Param: ANG_YAW_P
%      @DisplayName: Yaw axis angle controller P gain
%      @Description: Yaw axis angle controller P gain.  Converts the error between the desired yaw angle and actual angle to a desired yaw rate
%      @Range: 3.000 6.000
%      @Range{Sub}: 0.0 6.000
%      @User: Standard
p_angle_yaw=3;
%      @Param: ANG_LIM_TC
%      @DisplayName: Angle Limit (to maintain altitude) Time Constant
%      @Description: Angle Limit (to maintain altitude) Time Constant
%      @Range: 0.5 10.0
%      @User: Advanced
angle_limit_tc=1;
%      @Param: RATE_R_MAX
%      @DisplayName: Angular Velocity Max for Roll
%      @Description: Maximum angular velocity in roll axis
%      @Units: deg/s
%      @Range: 0 1080
%      @Increment: 1
%      @Values: 0:Disabled, 360:Slow, 720:Medium, 1080:Fast
%      @User: Advanced
ang_vel_roll_max=0;

%      @Param: RATE_P_MAX
%      @DisplayName: Angular Velocity Max for Pitch
%      @Description: Maximum angular velocity in pitch axis
%      @Units: deg/s
%      @Range: 0 1080
%      @Increment: 1
%      @Values: 0:Disabled, 360:Slow, 720:Medium, 1080:Fast
%      @User: Advanced
ang_vel_pitch_max=0;
%      @Param: RATE_Y_MAX
%      @DisplayName: Angular Velocity Max for Yaw
%      @Description: Maximum angular velocity in yaw axis
%      @Units: deg/s
%      @Range: 0 1080
%      @Increment: 1
%      @Values: 0:Disabled, 360:Slow, 720:Medium, 1080:Fast
%      @User: Advanced
ang_vel_yaw_max=0;
%      @Param: INPUT_TC
%      @DisplayName: Attitude control input time constant (aka smoothing)
%      @Description: Attitude control input time constant.  Low numbers lead to sharper response, higher numbers to softer response
%      @Units: s
%      @Range: 0 1
%      @Increment: 0.01
%      @Values: 0.5:Very Soft, 0.2:Soft, 0.15:Medium, 0.1:Crisp, 0.05:Very Crisp
%      @User: Standard
input_tc=0.3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AC_ATTITUDE_ACCEL_RP_CONTROLLER_MIN_RADSS= radians(40.0) ;    %minimum body-frame acceleration limit for the stability controller (for roll and pitch axis)
AC_ATTITUDE_ACCEL_RP_CONTROLLER_MAX_RADSS= radians(720.0);   %maximum body-frame acceleration limit for the stability controller (for roll and pitch axis)
AC_ATTITUDE_ACCEL_Y_CONTROLLER_MIN_RADSS= radians(10.0) ;   % minimum body-frame acceleration limit for the stability controller (for yaw axis)
AC_ATTITUDE_ACCEL_Y_CONTROLLER_MAX_RADSS=radians(120.0) ;   % maximum body-frame acceleration limit for the stability controller (for yaw axis)
AC_ATTITUDE_THRUST_ERROR_ANGLE=radians(30.0);               %Thrust angle error above which yaw corrections are limited
AC_ATTITUDE_CONTROL_ANGLE_LIMIT_THROTTLE_MAX=0.8;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FRAME_CLASS=      1.000000;
FRAME_TYPE =      6.000000;
ATC_ACCEL_P_MAX = 36397.976562;
ATC_ACCEL_R_MAX = 33111.574219;
ATC_ACCEL_Y_MAX = 36397.976562;

% ATC_ANG_PIT_P =   6.496104;
% ATC_ANG_RLL_P =   6.125903;
% ATC_ANG_YAW_P =   3.144684;

% ATC_RAT_PIT_D =   0.006864;
% ATC_RAT_PIT_FF =  0.000000;
% ATC_RAT_PIT_FILT =20.000000;
% ATC_RAT_PIT_I   = 0.292808;
% ATC_RAT_PIT_IMAX =0.500000;
% ATC_RAT_PIT_P   = 0.292808;


ATC_RAT_PIT_D =   0.0;
ATC_RAT_PIT_FF =  0.000000;
ATC_RAT_PIT_FILT =20.000000;
ATC_RAT_PIT_I   = 0.0;
ATC_RAT_PIT_IMAX =0.0;
ATC_RAT_PIT_P   = 0.2;

% ATC_RAT_RLL_D  =  0.007893;
% ATC_RAT_RLL_FF =  0.000000;
% ATC_RAT_RLL_FILT= 20.000000;
% ATC_RAT_RLL_I    =0.255515;
% ATC_RAT_RLL_IMAX =0.500000;
% ATC_RAT_RLL_P    =0.255515;

ATC_RAT_RLL_D  =  0;
ATC_RAT_RLL_FF =  0.000000;
ATC_RAT_RLL_FILT= 20.000000;
ATC_RAT_RLL_I    =0.0;
ATC_RAT_RLL_IMAX =0.0;
ATC_RAT_RLL_P    =0.15;


% ATC_RAT_YAW_D    =0.000000;
% ATC_RAT_YAW_FF  = 0.000000;
% ATC_RAT_YAW_FILT =5.000000;
% ATC_RAT_YAW_I    =0.093384;
% ATC_RAT_YAW_IMAX =0.500000;
% ATC_RAT_YAW_P    =0.933841;
ATC_RAT_YAW_D    =0.030000;
ATC_RAT_YAW_FF  = 0.000000;
ATC_RAT_YAW_FILT =5.000000;
ATC_RAT_YAW_I    =0.0;
ATC_RAT_YAW_IMAX =0.0;
ATC_RAT_YAW_P    =0.2;







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%motor
