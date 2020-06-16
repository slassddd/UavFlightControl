%mode_Multicopter
load bus_comper.mat
pianzhuanjiao
m_kg=5;
% g=9.8;
Jx=186222*1e-6;
Jy=164400*1e-6;
Jz=336920*1e-6;
% Jx=186222*1e-5;
% Jy=164400*1e-5;
% Jz=336920*1e-5;
J=diag([Jx Jy Jz]);

Lux=310/1000;
Luy=210/1000;
Ldx=205/1000;
Ldy=355.5/1000;
Lu=hypot(Lux,Luy);
Ld=hypot(Ldx,Ldy);
Ku=32;
% Kd=18;
Kd=Ku*Luy/Ldy;
Kx=(Ku-Kd)/(Ku+Kd);
Qd=10;
Qu=asind(Kd*sind(Qd)*Ld/(Ku*Lu));
Kc=(Ku*Lux)/(Ldx*Kd);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    mode=0;
    mode_state=0;
    ts=0;
    dt=0.012;
    thrust_slew_time=0.5;%%%%%%%%%%%%%%%%油门时间
    throttle_slewrate=100;%%%%%%%%%%%%%%%%TECS 油门变化率
    disable_integrator_pitch=0;
    disable_integrator_roll=0;
    disable_integrator_yaw=0;
    aspeed_c2p=8;
    p_plane_c2p=0.1;
    yaw_max_c2p=0.3;

    throttle_hover=0.48;
    throttle_cruise=30;
%     current_tilt=0.55;%0.69
%     tail_tilt=10;

    current_tilt=0;%0.69
    tail_tilt=0;
    p_tail_tilt=1;
    p_tilt_pitch_target=0.01;

    pwm_max=2000;
    pwm_min=1000;
    pwm_out=[1000 1000 1000 1000]+throttle_hover*1000;
    highest_airspeed=35;
    scaling_speed=17;
    airspeed_max=25;
    airspeed_min=13;

    TASmax=23;
    TASmin=14;
    THRmaxf=1;
    THRminf=0;
    throttle_min=0;
    throttle_max=100; 
    pitch_limit_min_cd=-1500;
    pitch_limit_max_cd=2000;
    pitch_max_limit=90;
    roll_limit_cd=2500;
    roll_limit_cd_inint=4500;

    nav_pitch_cd=0;
    nav_roll_cd=0;
    inverted_flight=0;
    k_rudder=0;
    k_aileron=0;
    k_throttle=0.0;
    k_elevator=0;
    POSCONTROL_ACC_Z_FILT_HZ_c2p=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% wind %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5    
%      @Param: WVANE_MINROLL
%      @DisplayName: Weathervaning min roll
%      @Description: This set the minimum roll in degrees before active weathervaning will start. This may need to be larger if your aircraft has bad roll trim.
%      @Range: 0 10
%      @Increment: 0.1
%      @User: Standard
    weathervane_min_roll=8;
%      @Param: WVANE_GAIN
%      @DisplayName: Weathervaning gain
%      @Description: This controls the tendency to yaw to face into the wind. A value of 0.1 is to start with and will give a slow turn into the wind. Use a value of 0.4 for more rapid response. The weathervaning works by turning into the direction of roll.
%      @Range: 0 1
%      @Increment: 0.01
%      @User: Standard
    weathervane_gain=0.01;       
%      @Param: YAW_RATE_MAX
%      @DisplayName: Maximum yaw rate
%      @Description: This is the maximum yaw rate for pilot input on rudder stick in degrees/second
%      @Units: deg/s
%      @Range: 50 500
%      @Increment: 1
%      @User: Standard
    yaw_rate_max=50;
   weathervane_last_output=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    

    kff_throttle_to_pitch=0;
    smoothed_airspeed=0;
    aerodynamic_load_factor=1;
    kff_rudder_mix=0;
    vdot_filter=zeros(5,1);
    rot_body_to_ned=eye(3,3);
    desired_rate_roll=0;
    imu_filt=10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    HD=180/pi;

    pitch=0;
    roll=0;
    yaw=0;
    wy=0;
    wx=0;
    wz=0;
    
     curr_vel=[0 0 0];
     curr_pos=[0 0 ];

    gyro_x=0;
    gyro_y=0;
    gyro_z=0;

    accel_x=0;
    accel_y=0;    
    accel_z=0;
    VN=0;
    VE=0;  
    Vz=0;
    EAS=17;
    aspeed=17;
    EAS2TAS=1;   
    GRAVITY_MSS=9.80665;

    groundspeed_vector=[0.1 0.1];

    current_loc=[40,100]*1e7;
    loc_origin=[40,100]*1e7;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    center_WP=[40,100]*1e7;
    radius=60;
    L1_radius=30;
    loiter_direction=1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    prev_WP=[40,100]*1e7;
    next_WP=[40,100.01]*1e7;
    dist_min=50;
%     loc=[0,      40*1e7,     100*1e7;
%          1,      40.01*1e7,  100.01*1e7;
%          2,      40.02*1e7,  100.01*1e7;
%          3,      40.02*1e7,  100.02*1e7;
%          4,      40.01*1e7,  100.02*1e7;
%          5,      40.01*1e7,  100.01*1e7;
%          99,     0*1e7,      0*1e7;    ];
    loc.num=[0     1     2     3     4      5	99  99  99  99  99    ];
    loc.lat=[4.0000    4.0010    4.0020    4.0020    4.0010  4.0015     4.0010  0   0   0   0]*1e8;
    loc.lon=[1.0000    1.0001    1.0001    1.0002    1.0002  1.00025    1.0001  0   0   0	0]*1e9;
    
    mode_L1=0;
    roll_target_pilot=0;
    pitch_target_pilot=0;
    
    EAS_dem_cm=1700;
    hgt_dem_cm=0;
    arspeed_filt=35;
    arspeed_temp=0;
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%AC_AttitudeControl matlab sim  
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

ATC_ACCEL_P_MAX = 36397.976562;
ATC_ACCEL_R_MAX = 33111.574219;
ATC_ACCEL_Y_MAX = 36397.976562;

ATC_RAT_PIT_D =   0.00;
ATC_RAT_PIT_FF =  0.000000;
ATC_RAT_PIT_FILT =20.000000;
ATC_RAT_PIT_I   = 0.0;
ATC_RAT_PIT_IMAX =0.0;
ATC_RAT_PIT_P   = 0.09;

ATC_RAT_RLL_D  =  0;
ATC_RAT_RLL_FF =  0.000000;
ATC_RAT_RLL_FILT= 20.000000;
ATC_RAT_RLL_I    =0.0;
ATC_RAT_RLL_IMAX =0.0;
ATC_RAT_RLL_P    =0.1;

ATC_RAT_YAW_D    =0.00000;
ATC_RAT_YAW_FF  = 0.000000;
ATC_RAT_YAW_FILT =5.000000;
ATC_RAT_YAW_I    =0.0;
ATC_RAT_YAW_IMAX =0.0;
ATC_RAT_YAW_P    =0.1;

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    POSCONTROL_POS_Z_P=3;    % vertical position controller P gain default
    POSCONTROL_VEL_Z_P=1;    % vertical velocity controller P gain default
    POSCONTROL_ACC_Z_P=1;    % vertical acceleration controller P gain default
    POSCONTROL_ACC_Z_I=0.0;    % vertical acceleration controller I gain default
    POSCONTROL_ACC_Z_D=0.0;    % vertical acceleration controller D gain default
    POSCONTROL_ACC_Z_IMAX=800;    % vertical acceleration controller IMAX gain default
    POSCONTROL_ACC_Z_FILT_HZ=20.0;    % vertical acceleration controller input filter default
    POSCONTROL_ACC_Z_DT=0.0025;    % vertical acceleration controller dt default
    
    POSCONTROL_POS_XY_P=0.8;    % horizontal position controller P gain default
    POSCONTROL_VEL_XY_P=2;    % horizontal velocity controller P gain default
    POSCONTROL_VEL_XY_I=0.1;    % horizontal velocity controller I gain default
    POSCONTROL_VEL_XY_D=0.0;    % horizontal velocity controller D gain default
    POSCONTROL_VEL_XY_IMAX=1000.0;    % horizontal velocity controller IMAX gain default
    POSCONTROL_VEL_XY_FILT_HZ=5.0;    % horizontal velocity controller input filter
    POSCONTROL_VEL_XY_FILT_D_HZ=5.0;    % horizontal velocity controller input filter for D
  
    POSCONTROL_ACCELERATION_MIN=50.0;% minimum horizontal acceleration in cm/s/s - used for sanity checking acceleration in leash length calculation
    POSCONTROL_ACCEL_XY=        100.0;%default horizontal acceleration in cm/s/s.  This is overwritten by waypoint and loiter controllers
    POSCONTROL_ACCEL_XY_MAX=    357.0;%max horizontal acceleration in cm/s/s that the position velocity controller will ask from the lower accel controller
    POSCONTROL_STOPPING_DIST_UP_MAX=         300.0;%max stopping distance (in cm) vertically while climbing
    POSCONTROL_STOPPING_DIST_DOWN_MAX=       200.0;%max stopping distance (in cm) vertically while descending

    POSCONTROL_SPEED=           500.0;%default horizontal speed in cm/s
    POSCONTROL_SPEED_DOWN=     -300.0;%default descent rate in cm/s
    POSCONTROL_SPEED_UP=        300.0;%default climb rate in cm/s

    POSCONTROL_ACCEL_Z=         250.0;%default vertical acceleration in cm/s/s.

    POSCONTROL_LEASH_LENGTH_MIN=100.0;%minimum leash lengths in cm

    POSCONTROL_DT_50HZ=         0.02;% time difference in seconds for 50hz update rate
    POSCONTROL_DT_400HZ=        0.0025;% time difference in seconds for 400hz update rate

    POSCONTROL_ACTIVE_TIMEOUT_US=200000 ;% position controller is considered active if it has been called within the past 0.2 seconds

    POSCONTROL_VEL_ERROR_CUTOFF_FREQ=4.0;% low-pass filter on velocity error (unit: hz)
    POSCONTROL_THROTTLE_CUTOFF_FREQ=2.0;% low-pass filter on accel error (unit: hz)
    POSCONTROL_ACCEL_FILTER_HZ= 2.0;% low-pass filter on acceleration (unit: hz)
    POSCONTROL_JERK_RATIO=      1.0;% Defines the time it takes to reach the requested acceleration

    POSCONTROL_OVERSPEED_GAIN_Z=2.0;% gain controlling rate at which z-axis speed is brought back within SPEED_UP and SPEED_DOWN range
    
  
    %0 was used for HOVER

    %@Param: _ACC_XY_FILT
    %@DisplayName: XY Acceleration filter cutoff frequency
    %@Description: Lower values will slow the response of the navigation controller and reduce twitchiness
    %@Units: Hz
    %@Range: 0.5 5
    %@Increment: 0.1
    %@User: Advanced
    accel_xy_filt_hz=POSCONTROL_ACCEL_FILTER_HZ;
    %@Param: _POSZ_P
    %@DisplayName: Position (vertical) controller P gain
    %@Description: Position (vertical) controller P gain.  Converts the difference between the desired altitude and actual altitude into a climb or descent rate which is passed to the throttle rate controller
    %@Range: 1.000 3.000
    %@User: Standard
%     p_pos_z=1.5;

    %@Param: _VELZ_P
    %@DisplayName: Velocity (vertical) controller P gain
    %@Description: Velocity (vertical) controller P gain.  Converts the difference between desired vertical speed and actual speed into a desired acceleration that is passed to the throttle acceleration controller
    %@Range: 1.000 8.000
    %@User: Standard
%     p_vel_z=1.5;

    %@Param: _ACCZ_P
    %@DisplayName: Acceleration (vertical) controller P gain
    %@Description: Acceleration (vertical) controller P gain.  Converts the difference between desired vertical acceleration and actual acceleration into a motor output
    %@Range: 0.500 1.500
    %@Increment: 0.05
    %@User: Standard

    %@Param: _ACCZ_I
    %@DisplayName: Acceleration (vertical) controller I gain
    %@Description: Acceleration (vertical) controller I gain.  Corrects long-term difference in desired vertical acceleration and actual acceleration
    %@Range: 0.000 3.000
    %@User: Standard

    %@Param: _ACCZ_IMAX
    %@DisplayName: Acceleration (vertical) controller I gain maximum
    %@Description: Acceleration (vertical) controller I gain maximum.  Constrains the maximum pwm that the I term will generate
    %@Range: 0 1000
    %@Units: d%
    %@User: Standard

    %@Param: _ACCZ_D
    %@DisplayName: Acceleration (vertical) controller D gain
    %@Description: Acceleration (vertical) controller D gain.  Compensates for short-term change in desired vertical acceleration vs actual acceleration
    %@Range: 0.000 0.400
    %@User: Standard

    %@Param: _ACCZ_FILT
    %@DisplayName: Acceleration (vertical) controller filter
    %@Description: Filter applied to acceleration to reduce noise.  Lower values reduce noise but add delay.
    %@Range: 1.000 100.000
    %@Units: Hz
    %@User: Standard

%     AP_SUBGROUPINFO(pid_accel_z, "_ACCZ_", 4, AC_PosControl, AC_PID)

    %@Param: _POSXY_P
    %@DisplayName: Position (horizonal) controller P gain
    %@Description: Position controller P gain.  Converts the distance (in the latitude direction) to the target location into a desired speed which is then passed to the loiter latitude rate controller
    %@Range: 0.500 2.000
    %@User: Standard
%     AP_SUBGROUPINFO(_p_pos_xy, "_POSXY_", 5, AC_PosControl, AC_P)

    %@Param: _VELXY_P
    %@DisplayName: Velocity (horizontal) P gain
    %@Description: Velocity (horizontal) P gain.  Converts the difference between desired velocity to a target acceleration
    %@Range: 0.1 6.0
    %@Increment: 0.1
    %@User: Advanced

    %@Param: _VELXY_I
    %@DisplayName: Velocity (horizontal) I gain
    %@Description: Velocity (horizontal) I gain.  Corrects long-term difference in desired velocity to a target acceleration
    %@Range: 0.02 1.00
    %@Increment: 0.01
    %@User: Advanced

    %@Param: _VELXY_D
    %@DisplayName: Velocity (horizontal) D gain
    %@Description: Velocity (horizontal) D gain.  Corrects short-term changes in velocity
    %@Range: 0.00 1.00
    %@Increment: 0.001
    %@User: Advanced

    %@Param: _VELXY_IMAX
    %@DisplayName: Velocity (horizontal) integrator maximum
    %@Description: Velocity (horizontal) integrator maximum.  Constrains the target acceleration that the I gain will output
    %@Range: 0 4500
    %@Increment: 10
    %@Units: cm/s/s
    %@User: Advanced

    %@Param: _VELXY_FILT
    %@DisplayName: Velocity (horizontal) input filter
    %@Description: Velocity (horizontal) input filter.  This filter (in hz) is applied to the input for P and I terms
    %@Range: 0 100
    %@Units: Hz
    %@User: Advanced

    %@Param: _VELXY_D_FILT
    %@DisplayName: Velocity (horizontal) input filter
    %@Description: Velocity (horizontal) input filter.  This filter (in hz) is applied to the input for P and I terms
    %@Range: 0 100
    %@Units: Hz
    %@User: Advanced
%     AP_SUBGROUPINFO(_pid_vel_xy, "_VELXY_", 6, AC_PosControl, AC_PID_2D),

    %@Param: _ANGLE_MAX
    %@DisplayName: Position Control Angle Max
    %@Description: Maximum lean angle autopilot can request.  Set to zero to use ANGLE_MAX parameter value
    %@Units: deg
    %@Range: 0 45
    %@Increment: 1
    %@User: Advanced
%     AP_GROUPINFO("_ANGLE_MAX", 7, AC_PosControl, _lean_angle_max, 0.0f),


 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 recalc_leash_z=1;
 limit_pos_down=0;
 limit_pos_up=0;
 pos_error=[0 0 0];
 pos_target=[0 0 0];
 vel_target=[0 0 0];
 limit_vel_up=0;
 limit_vel_down=0;
 use_desvel_ff_z=1;
 reset_rate_to_accel_z=1;
 curr_alt=0;
 vel_desired=[0 0 0];
 vel_last=[0 0 0];
 accel_desired=[0 0 0];
 freeze_ff_z=0;
 vel_error=[0 0 0];
 vel_error_input=0;
 accel_target=[0 0 0];
 reset_accel_to_throttle=1;
 accel_error=[0 0 0];
 z_accel_meas=0;
 pid_accel_z_reset_filter=1;
 pid_accel_z_input=0;
 pid_accel_z_derivative=0;
 pid_accel_z_integrator=0;
 throttle_lower=0;
 throttle_upper=0;
 throttle_input=0;
 %%%%%%%%%%%%%%%%%%
 roll_target=0;
 pitch_target=0;
 yaw_target=0;
 target_yaw_rate=0;
 
 attitude_target_euler_angle=[roll_target pitch_target yaw_target]*0.01/HD;
 attitude_target_quat=from_euler(attitude_target_euler_angle);

attitude_target_ang_vel=[0 0 0];
attitude_target_euler_rate=[0 0 0];
attitude_ang_error=[1 0 0 0];
use_sqrt_controller=1;
 
 %%%%%%%%%%%%%%%%%%%%%%
 throttle_rpy_mix=0;

 pid_vel_xy_reset_filter=1;
 pid_vel_xy_input=[0 0];
 pid_vel_xy_derivative=[0 0];
 pid_vel_xy_integrator=[0 0];
 limit_accel_xy=0;
 motors_limit_throttle_upper=0;
 reset_accel_to_lean_xy=1;
 accel_xy_input=[0 0];
 accel_xy_angle_max=2000;%%dai cha

 recalc_leash_xy=1;
 reset_desired_vel_to_pos=1;
 accel_last_z_cms=0;
 is_active_z=1;
 is_active_xy=1;

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 inint=1;
 AP_MOTORS_MATRIX_YAW_FACTOR_CW=-1;
 AP_MOTORS_MATRIX_YAW_FACTOR_CCW=1;

roll_factor=[0 0 0 0];
pitch_factor=[0 0 0 0];
yaw_factor=[0 0 0 0];

limit_roll_pitch=0;
limit_yaw=0;
yaw_headroom=0;
air_density_ratio=1;
thrust_boost=0;

angle_boost=0;
throttle_avg_max=1;
throttle_cutoff_frequency=1;
throttle_thrust_max=1;
althold_lean_angle_max=0;
throttle_rpy_mix_desired=0;
AC_ATTITUDE_CONTROL_MAX=5;
roll_in=0;
pitch_in=0;
yaw_in=0;
armed=1;
% throttle_hover=0.4816;
% throttle_in=0.4816;
% throttle_filter=throttle_in;
% pwm_out=ones(1,4)*(throttle_hover*1000+1000);

throttle_in=0.4816;
throttle_filter=0;
thrust_boost_ratio=0;
thrust_rpyt_out=[0 0 0 0];
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thrust_error_angle=0;
rate_target_ang_vel=[0 0 0];
attitude_error_vector=[0 0 0];
climb_rate_cms=0;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AP_PitchController
	% @Param: TCONST
	% @DisplayName: Pitch Time Constant
	% @Description: Time constant in seconds from demanded to achieved pitch angle. Most models respond well to 0.5. May be reduced for faster responses, but setting lower than a model can achieve will not help.
	% @Range: 0.4 1.0
	% @Units: s
	% @Increment: 0.1
	% @User: Advanced
% 	AP_GROUPINFO("TCONST",      0, AP_PitchController, gains.tau,       0.5f),
    gains_tau_pitch=0.5;
	% @Param: P
	% @DisplayName: Proportional Gain
	% @Description: Proportional gain from pitch angle demands to elevator. Higher values allow more servo response but can cause oscillations. Automatically set and adjusted by AUTOTUNE mode.
	% @Range: 0.1 3.0
	% @Increment: 0.1
	% @User: User
% 	AP_GROUPINFO("P",        1, AP_PitchController, gains.P,          1.0f),
    gains_P_pitch=2.5;
	% @Param: D
	% @DisplayName: Damping Gain
	% @Description: Damping gain from pitch acceleration to elevator. Higher values reduce pitching in turbulence, but can cause oscillations. Automatically set and adjusted by AUTOTUNE mode.
	% @Range: 0 0.2
	% @Increment: 0.01
	% @User: User
%     AP_GROUPINFO("D",        2, AP_PitchController, gains.D,        0.04f),
    gains_D_pitch=0.1;
	% @Param: I
	% @DisplayName: Integrator Gain
	% @Description: Integrator gain from long-term pitch angle offsets to elevator. Higher values "trim" out offsets faster but can cause oscillations. Automatically set and adjusted by AUTOTUNE mode.
	% @Range: 0 0.5
	% @Increment: 0.05
	% @User: User
% 	AP_GROUPINFO("I",        3, AP_PitchController, gains.I,        0.3f),
    gains_I_pitch=0.1;
	% @Param: RMAX_UP
	% @DisplayName: Pitch up max rate
	% @Description: Maximum pitch up rate that the pitch controller demands (degrees/sec) in ACRO mode.
	% @Range: 0 100
	% @Units: deg/s
	% @Increment: 1
	% @User: Advanced
% 	AP_GROUPINFO("RMAX_UP",     4, AP_PitchController, gains.rmax,   0.0f),
    gains_rmax_pitch=0;
	% @Param: RMAX_DN
	% @DisplayName: Pitch down max rate
	% @Description: This sets the maximum nose down pitch rate that the controller will demand (degrees/sec). Setting it to zero disables the limit.
	% @Range: 0 100
	% @Units: deg/s
	% @Increment: 1
	% @User: Advanced
% 	AP_GROUPINFO("RMAX_DN",     5, AP_PitchController, _max_rate_neg,   0.0f),
    max_rate_neg=0;
	% @Param: RLL
	% @DisplayName: Roll compensation
	% @Description: Gain added to pitch to keep aircraft from descending or ascending in turns. Increase in increments of 0.05 to reduce altitude loss. Decrease for altitude gain.
	% @Range: 0.7 1.5
	% @Increment: 0.05
	% @User: User
% 	AP_GROUPINFO("RLL",      6, AP_PitchController, _roll_ff,        1.0f),
    roll_ff_pitch=1;
	% @Param: IMAX
	% @DisplayName: Integrator limit
	% @Description: Limit of pitch integrator gain in centi-degrees of servo travel. Servos are assumed to have +/- 4500 centi-degrees of travel, so a value of 3000 allows trim of up to 2/3 of servo travel range.
	% @Range: 0 4500
	% @Increment: 1
	% @User: Advanced
% 	AP_GROUPINFO("IMAX",      7, AP_PitchController, gains.imax,     3000),
    gains_imax_pitch=3000;
	% @Param: FF
	% @DisplayName: Feed forward Gain
	% @Description: Gain from demanded rate to elevator output.
	% @Range: 0.1 4.0
	% @Increment: 0.1
	% @User: User
% 	AP_GROUPINFO("FF",        8, AP_PitchController, gains.FF,       0.0f),
    last_out_pitch=0;
    pid_info_I_pitch=0;
    pid_info_P_pitch=0;
    pid_info_FF_pitch=0;
    pid_info_D_pitch=0;
    pid_info_desired_pitch=0;
    pid_info_actual_pitch=0;
    gains_FF_pitch=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%AP_RollController
	% @Param: TCONST
	% @DisplayName: Roll Time Constant
	% @Description: Time constant in seconds from demanded to achieved roll angle. Most models respond well to 0.5. May be reduced for faster responses, but setting lower than a model can achieve will not help.
	% @Range: 0.4 1.0
	% @Units: s
	% @Increment: 0.1
	% @User: Advanced
% 	AP_GROUPINFO("TCONST",      0, AP_RollController, gains.tau,       0.5f),
gains_tau_roll=0.5;
	% @Param: P
	% @DisplayName: Proportional Gain
	% @Description: Proportional gain from roll angle demands to ailerons. Higher values allow more servo response but can cause oscillations. Automatically set and adjusted by AUTOTUNE mode.
	% @Range: 0.1 4.0
	% @Increment: 0.1
	% @User: User
% 	AP_GROUPINFO("P",        1, AP_RollController, gains.P,        1.0f),
gains_P_roll=1;
	% @Param: D
	% @DisplayName: Damping Gain
	% @Description: Damping gain from roll acceleration to ailerons. Higher values reduce rolling in turbulence, but can cause oscillations. Automatically set and adjusted by AUTOTUNE mode.
	% @Range: 0 0.2
	% @Increment: 0.01
	% @User: User
% 	AP_GROUPINFO("D",        2, AP_RollController, gains.D,        0.08f),
gains_D_roll=0.05;
	% @Param: I
	% @DisplayName: Integrator Gain
	% @Description: Integrator gain from long-term roll angle offsets to ailerons. Higher values "trim" out offsets faster but can cause oscillations. Automatically set and adjusted by AUTOTUNE mode.
	% @Range: 0 1.0
	% @Increment: 0.05
	% @User: User
% 	AP_GROUPINFO("I",        3, AP_RollController, gains.I,        0.3f),
gains_I_roll=0.1;
	% @Param: RMAX
	% @DisplayName: Maximum Roll Rate
	% @Description: Maximum roll rate that the roll controller demands (degrees/sec) in ACRO mode.
	% @Range: 0 180
	% @Units: deg/s
	% @Increment: 1
	% @User: Advanced
% 	AP_GROUPINFO("RMAX",   4, AP_RollController, gains.rmax,       0),
gains_rmax_roll=0;
	% @Param: IMAX
	% @DisplayName: Integrator limit
	% @Description: Limit of roll integrator gain in centi-degrees of servo travel. Servos are assumed to have +/- 4500 centi-degrees of travel, so a value of 3000 allows trim of up to 2/3 of servo travel range.
	% @Range: 0 4500
	% @Increment: 1
	% @User: Advanced
% 	AP_GROUPINFO("IMAX",      5, AP_RollController, gains.imax,        3000),
gains_imax_roll=3000;
	% @Param: FF
	% @DisplayName: Feed forward Gain
	% @Description: Gain from demanded rate to aileron output. 
	% @Range: 0.1 4.0
	% @Increment: 0.1
	% @User: User
% 	AP_GROUPINFO("FF",        6, AP_RollController, gains.FF,          0.0f),
gains_FF_roll=0;
    last_out_roll=0;
    pid_info_I_roll=0;
    pid_info_P_roll=0;
    pid_info_FF_roll=0;
    pid_info_D_roll=0;
    pid_info_desired_roll=0;
    pid_info_actual_roll=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%  AP_YawController 
	% @Param: SLIP
	% @DisplayName: Sideslip control gain
	% @Description: Gain from lateral acceleration to demanded yaw rate for aircraft with enough fuselage area to detect lateral acceleration and sideslips. Do not enable for flying wings and gliders. Actively coordinates flight more than just yaw damping. Set after YAW2SRV_DAMP and YAW2SRV_INT are tuned.
	% @Range: 0 4
	% @Increment: 0.25
    % @User: Advanced
% 	AP_GROUPINFO("SLIP",    0, AP_YawController, _K_A,    0),
K_A_yaw=0.0;
	% @Param: INT
	% @DisplayName: Sideslip control integrator
	% @Description: Integral gain from lateral acceleration error. Effectively trims rudder to eliminate long-term sideslip.
	% @Range: 0 2
	% @Increment: 0.25
    % @User: Advanced
% 	AP_GROUPINFO("INT",    1, AP_YawController, _K_I,    0),
K_I_yaw=0.1;
	% @Param: DAMP
	% @DisplayName: Yaw damping
	% @Description: Gain from yaw rate to rudder. Most effective at yaw damping and should be tuned after KFF_RDDRMIX. Also disables YAW2SRV_INT if set to 0.
	% @Range: 0 2
	% @Increment: 0.25
    % @User: Advanced
% 	AP_GROUPINFO("DAMP",   2, AP_YawController, _K_D,    0),
K_D_yaw=0.5;
	% @Param: RLL
	% @DisplayName: Yaw coordination gain
	% @Description: Gain to the yaw rate required to keep it consistent with the turn rate in a coordinated turn. Corrects for yaw tendencies after the turn is established. Increase yaw into the turn by raising. Increase yaw out of the turn by decreasing. Values outside of 0.9-1.1 range indicate airspeed calibration problems.
	% @Range: 0.8 1.2
	% @Increment: 0.05
    % @User: Advanced
% 	AP_GROUPINFO("RLL",   3, AP_YawController, _K_FF,   1),
K_FF_yaw=1;
     
%       Note: index 4 should not be used - it was used for an incorrect
%       AP_Int8 version of the IMAX in the 2.74 release
%   
	% @Param: IMAX
	% @DisplayName: Integrator limit
	% @Description: Limit of yaw integrator gain in centi-degrees of servo travel. Servos are assumed to have +/- 4500 centi-degrees of travel, so a value of 1500 allows trim of up to 1/3 of servo travel range.
	% @Range: 0 4500
	% @Increment: 1
	% @User: Advanced
% 	AP_GROUPINFO("IMAX",  5, AP_YawController, _imax,        1500),
    imax_yaw=1500;
    
    K_D_last_yaw=0;
    integrator_yaw=0;
    last_out_yaw=0;
    pid_info_I_yaw=0;
    pid_info_D_yaw=0;
    last_rate_hp_out_yaw=0;
    last_rate_hp_in_yaw=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%AP_TECS
    % @Param: CLMB_MAX
    % @DisplayName: Maximum Climb Rate (metres/sec)
    % @Description: Maximum demanded climb rate. Do not set higher than the climb speed at THR_MAX at TRIM_ARSPD_CM when the battery is at low voltage. Reduce value if airspeed cannot be maintained on ascent. Increase value if throttle does not increase significantly to ascend.
    % @Increment: 0.1
    % @Range: 0.1 20.0
    % @User: Standard
%     AP_GROUPINFO("CLMB_MAX",    0, AP_TECS, _maxClimbRate, 5.0f),
maxClimbRate=5;
    % @Param: SINK_MIN
    % @DisplayName: Minimum Sink Rate (metres/sec)
    % @Description: Minimum sink rate when at THR_MIN and TRIM_ARSPD_CM.
    % @Increment: 0.1
    % @Range: 0.1 10.0
    % @User: Standard
%     AP_GROUPINFO("SINK_MIN",    1, AP_TECS, _minSinkRate, 2.0f),
minSinkRate=3;
    % @Param: TIME_CONST
    % @DisplayName: Controller time constant (sec)
    % @Description: Time constant of the TECS control algorithm. Small values make faster altitude corrections but can cause overshoot and aggressive behavior.
    % @Range: 3.0 10.0
    % @Increment: 0.2
    % @User: Advanced
%     AP_GROUPINFO("TIME_CONST",  2, AP_TECS, _timeConst, 5.0f),
timeConstant=5;%timeConstant
    % @Param: THR_DAMP
    % @DisplayName: Controller throttle damping
    % @Description: Damping gain for throttle demand loop. Slows the throttle response to correct for speed and height oscillations.
    % @Range: 0.1 1.0
    % @Increment: 0.1
    % @User: Advanced
%     AP_GROUPINFO("THR_DAMP",    3, AP_TECS, _thrDamp, 0.5f),
thrDamp=0.7;
    % @Param: INTEG_GAIN
    % @DisplayName: Controller integrator
    % @Description: Integrator gain to trim out long-term speed and height errors.
    % @Range: 0.0 0.5
    % @Increment: 0.02
    % @User: Advanced
%     AP_GROUPINFO("INTEG_GAIN", 4, AP_TECS, _integGain, 0.1f),
integGain=0.0;
    % @Param: VERT_ACC
    % @DisplayName: Vertical Acceleration Limit (metres/sec^2)
    % @Description: Maximum vertical acceleration used to correct speed or height errors.
    % @Range: 1.0 10.0
    % @Increment: 0.5
    % @User: Advanced
%     AP_GROUPINFO("VERT_ACC",  5, AP_TECS, _vertAccLim, 7.0f),
vertAccLim=5;
    % @Param: HGT_OMEGA
    % @DisplayName: Height complementary filter frequency (radians/sec)
    % @Description: This is the cross-over frequency of the complementary filter used to fuse vertical acceleration and baro alt to obtain an estimate of height rate and height.
    % @Range: 1.0 5.0
    % @Increment: 0.05
    % @User: Advanced
%     AP_GROUPINFO("HGT_OMEGA", 6, AP_TECS, _hgtCompFiltOmega, 3.0f),
% hgtCompFiltOmega=3;
%     % @Param: SPD_OMEGA
%     % @DisplayName: Speed complementary filter frequency (radians/sec)
%     % @Description: This is the cross-over frequency of the complementary filter used to fuse longitudinal acceleration and airspeed to obtain a lower noise and lag estimate of airspeed.
%     % @Range: 0.5 2.0
%     % @Increment: 0.05
%     % @User: Advanced
% %     AP_GROUPINFO("SPD_OMEGA", 7, AP_TECS, _spdCompFiltOmega, 2.0f),
spdCompFiltOmega=2;
    % @Param: RLL2THR
    % @DisplayName: Bank angle compensation gain
    % @Description: Gain from bank angle to throttle to compensate for loss of airspeed from drag in turns. Set to approximately 10x the sink rate in m/s caused by a 45-degree turn. High efficiency models may need less while less efficient aircraft may need more. Should be tuned in an automatic mission with waypoints and turns greater than 90 degrees. Tune with PTCH2SV_RLL and KFF_RDDRMIX to achieve constant airspeed, constant altitude turns.
    % @Range: 5.0 30.0
    % @Increment: 1.0
    % @User: Advanced
%     AP_GROUPINFO("RLL2THR",  8, AP_TECS, _rollComp, 10.0f),
rollComp=10;
    % @Param: SPDWEIGHT
    % @DisplayName: Weighting applied to speed control
    % @Description: Mixing of pitch and throttle correction for height and airspeed errors. Pitch controls altitude and throttle controls airspeed if set to 0. Pitch controls airspeed and throttle controls altitude if set to 2 (good for gliders). Blended if set to 1.
    % @Range: 0.0 2.0
    % @Increment: 0.1
    % @User: Advanced
%     AP_GROUPINFO("SPDWEIGHT", 9, AP_TECS, _spdWeight, 1.0f),
spdWeight=1;
    % @Param: PTCH_DAMP
    % @DisplayName: Controller pitch damping
    % @Description: Damping gain for pitch control from TECS control.  Increasing may correct for oscillations in speed and height, but too much may cause additional oscillation and degraded control.
    % @Range: 0.1 1.0
    % @Increment: 0.1
    % @User: Advanced
%     AP_GROUPINFO("PTCH_DAMP", 10, AP_TECS, _ptchDamp, 0.0f),
ptchDamp=0.7;
    % @Param: SINK_MAX
    % @DisplayName: Maximum Descent Rate (metres/sec)
    % @Description: Maximum demanded descent rate. Do not set higher than the vertical speed the aircraft can maintain at THR_MIN, TECS_PITCH_MIN, and ARSPD_FBW_MAX.
    % @Increment: 0.1
    % @Range: 0.0 20.0
    % @User: User
%     AP_GROUPINFO("SINK_MAX",  11, AP_TECS, _maxSinkRate, 5.0f),
maxSinkRate=7;
    % @Param: LAND_ARSPD
    % @DisplayName: Airspeed during landing approach (m/s)
    % @Description: When performing an autonomus landing, this value is used as the goal airspeed during approach.  Note that this parameter is not useful if your platform does not have an airspeed sensor (use TECS_LAND_THR instead).  If negative then this value is not used during landing.
    % @Range: -1 127
    % @Increment: 1
    % @User: User
%     AP_GROUPINFO("LAND_ARSPD", 12, AP_TECS, _landAirspeed, -1),
% landAirspeed=-1;
%     % @Param: LAND_THR
%     % @DisplayName: Cruise throttle during landing approach (percentage)
%     % @Description: Use this parameter instead of LAND_ARSPD if your platform does not have an airspeed sensor.  It is the cruise throttle during landing approach.  If this value is negative then it is disabled and TECS_LAND_ARSPD is used instead.
%     % @Range: -1 100
%     % @Increment: 0.1
%     % @User: User
% %     AP_GROUPINFO("LAND_THR", 13, AP_TECS, _landThrottle, -1),
% landThrottle=-1;
%     % @Param: LAND_SPDWGT
%     % @DisplayName: Weighting applied to speed control during landing.
%     % @Description: Same as SPDWEIGHT parameter, with the exception that this parameter is applied during landing flight stages.  A value closer to 2 will result in the plane ignoring height error during landing and our experience has been that the plane will therefore keep the nose up -- sometimes good for a glider landing (with the side effect that you will likely glide a ways past the landing point).  A value closer to 0 results in the plane ignoring speed error -- use caution when lowering the value below 1 -- ignoring speed could result in a stall. Values between 0 and 2 are valid values for a fixed landing weight. When using -1 the weight will be scaled during the landing. At the start of the landing approach it starts with TECS_SPDWEIGHT and scales down to 0 by the time you reach the land point. Example: Halfway down the landing approach you'll effectively have a weight of TECS_SPDWEIGHT/2.
%     % @Range: -1.0 2.0
%     % @Increment: 0.1
%     % @User: Advanced
% %     AP_GROUPINFO("LAND_SPDWGT", 14, AP_TECS, _spdWeightLand, -1.0f),
% spdWeightLand=-1;
    % @Param: PITCH_MAX
    % @DisplayName: Maximum pitch in auto flight
    % @Description: Overrides LIM_PITCH_MAX in automatic throttle modes to reduce climb rates. Uses LIM_PITCH_MAX if set to 0. For proper TECS tuning, set to the angle that the aircraft can climb at TRIM_ARSPD_CM and THR_MAX.
    % @Range: 0 45
    % @Increment: 1
    % @User: Advanced
%     AP_GROUPINFO("PITCH_MAX", 15, AP_TECS, _pitch_max, 15),
pitch_max=0;
    % @Param: PITCH_MIN
    % @DisplayName: Minimum pitch in auto flight
    % @Description: Overrides LIM_PITCH_MIN in automatic throttle modes to reduce descent rates. Uses LIM_PITCH_MIN if set to 0. For proper TECS tuning, set to the angle that the aircraft can descend at without overspeeding.
    % @Range: -45 0
    % @Increment: 1
    % @User: Advanced
%     AP_GROUPINFO("PITCH_MIN", 16, AP_TECS, _pitch_min, 0),
pitch_min=0;
    % @Param: LAND_SINK
    % @DisplayName: Sink rate for final landing stage
    % @Description: The sink rate in meters/second for the final stage of landing.
    % @Range: 0.0 2.0
    % @Increment: 0.1
    % @User: Advanced
%     AP_GROUPINFO("LAND_SINK", 17, AP_TECS, _land_sink, 0.25f),
% land_sink=0.25;
%     % @Param: LAND_TCONST
%     % @DisplayName: Land controller time constant (sec)
%     % @Description: This is the time constant of the TECS control algorithm when in final landing stage of flight. It should be smaller than TECS_TIME_CONST to allow for faster flare
%     % @Range: 1.0 5.0
%     % @Increment: 0.2
%     % @User: Advanced
% %     AP_GROUPINFO("LAND_TCONST", 18, AP_TECS, _landTimeConst, 2.0f),
% landTimeConst=2;
%     % @Param: LAND_DAMP
%     % @DisplayName: Controller sink rate to pitch gain during flare
%     % @Description: This is the sink rate gain for the pitch demand loop when in final landing stage of flight. It should be larger than TECS_PTCH_DAMP to allow for better sink rate control during flare.
%     % @Range: 0.1 1.0
%     % @Increment: 0.1
%     % @User: Advanced
% %     AP_GROUPINFO("LAND_DAMP", 19, AP_TECS, _landDamp, 0.5f),
% landDamp=0.5;
%     % @Param: LAND_PMAX
%     % @DisplayName: Maximum pitch during final stage of landing
%     % @Description: This limits the pitch used during the final stage of automatic landing. During the final landing stage most planes need to keep their pitch small to avoid stalling. A maximum of 10 degrees is usually good. A value of zero means to use the normal pitch limits.
%     % @Range: -5 40
%     % @Increment: 1
%     % @User: Advanced
% %     AP_GROUPINFO("LAND_PMAX", 20, AP_TECS, _land_pitch_max, 10),
% land_pitch_max=10;
%     % @Param: APPR_SMAX
%     % @DisplayName: Sink rate max for landing approach stage
%     % @Description: The sink rate max for the landing approach stage of landing. This will need to be large for steep landing approaches especially when using reverse thrust. If 0, then use TECS_SINK_MAX.
%     % @Range: 0.0 20.0
%     % @Units: m/s
%     % @Increment: 0.1
%     % @User: Advanced
% %     AP_GROUPINFO("APPR_SMAX", 21, AP_TECS, _maxSinkRate_approach, 0),
% maxSinkRate_approach=0;
%     % @Param: LAND_SRC
%     % @DisplayName: Land sink rate change
%     % @Description: When zero, the flare sink rate (TECS_LAND_SINK) is a fixed sink demand. With this enabled the flare sinkrate will increase/decrease the flare sink demand as you get further beyond the LAND waypoint. Has no effect before the waypoint. This value is added to TECS_LAND_SINK proportional to distance traveled after wp. With an increasing sink rate you can still land in a given distance if you're traveling too fast and cruise passed the land point. A positive value will force the plane to land sooner proportional to distance passed land point. A negative number will tell the plane to slowly climb allowing for a pitched-up stall landing. Recommend 0.2 as initial value.
%     % @Range: -2.0 2.0
%     % @Units: m/s/m
%     % @Increment: 0.1
%     % @User: Advanced
% %     AP_GROUPINFO("LAND_SRC", 22, AP_TECS, _land_sink_rate_change, 0),
% land_sink_rate_change=0;
%     % @Param: LAND_TDAMP
%     % @DisplayName: Controller throttle damping when landing
%     % @Description: This is the damping gain for the throttle demand loop during and auto-landing. Same as TECS_THR_DAMP but only in effect during an auto-land. Increase to add damping to correct for oscillations in speed and height. When set to 0 landing throttle damp is controlled by TECS_THR_DAMP.
%     % @Range: 0.1 1.0
%     % @Increment: 0.1
%     % @User: Advanced
% %     AP_GROUPINFO("LAND_TDAMP", 23, AP_TECS, _land_throttle_damp, 0),
% land_throttle_damp=0;
%     % @Param: LAND_IGAIN
%     % @DisplayName: Controller integrator during landing
%     % @Description: This is the integrator gain on the control loop during landing. When set to 0 then TECS_INTEG_GAIN is used. Increase to increase the rate at which speed and height offsets are trimmed out. Typically values lower than TECS_INTEG_GAIN work best
%     % @Range: 0.0 0.5
%     % @Increment: 0.02
%     % @User: Advanced
% %     AP_GROUPINFO("LAND_IGAIN", 24, AP_TECS, _integGain_land, 0),
% integGain_land=0;
%     % @Param: TKOFF_IGAIN
%     % @DisplayName: Controller integrator during takeoff
%     % @Description: This is the integrator gain on the control loop during takeoff. When set to 0 then TECS_INTEG_GAIN is used. Increase to increase the rate at which speed and height offsets are trimmed out. Typically values higher than TECS_INTEG_GAIN work best
%     % @Range: 0.0 0.5
%     % @Increment: 0.02
%     % @User: Advanced
% %     AP_GROUPINFO("TKOFF_IGAIN", 25, AP_TECS, _integGain_takeoff, 0),
% integGain_takeoff=0;
%     % @Param: LAND_PDAMP
%     % @DisplayName: Pitch damping gain when landing
%     % @Description: This is the damping gain for the pitch demand loop during landing. Increase to add damping  to correct for oscillations in speed and height. If set to 0 then TECS_PTCH_DAMP will be used instead.
%     % @Range: 0.1 1.0
%     % @Increment: 0.1
%     % @User: Advanced
% %     AP_GROUPINFO("LAND_PDAMP", 26, AP_TECS, _land_pitch_damp, 0),
% land_pitch_damp=0;
%     % @Param: SYNAIRSPEED
%     % @DisplayName: Enable the use of synthetic airspeed
%     % @Description: This enable the use of synthetic airspeed for aircraft that don't have a real airspeed sensor. This is useful for development testing where the user is aware of the considerable limitations of the synthetic airspeed system, such as very poor estimates when a wind estimate is not accurate. Do not enable this option unless you fully understand the limitations of a synthetic airspeed estimate.
%     % @Values: 0:Disable,1:Enable
%     % @User: Advanced
% %     AP_GROUPINFO("SYNAIRSPEED", 27, AP_TECS, _use_synthetic_airspeed, 0),
%  use_synthetic_airspeed=0;   
   
    SKE_dem=0;
    SPE_dem=0;
    SPE_est=0;
    SKE_est=0;
    STE_error=0;
    SPEdot_dem=0;
    SKEdot_dem=0;
    STEdot_min=0;
    STEdot_max=0;
    SPEdot=0;
    SKEdot=0;
    STEdotErrLast=0;
    throttle_dem=0;
    last_throttle_dem=0;
    integTHR_state=0;
    hgt_dem=0;
    PITCHmaxf=0;
    PITCHminf=0;
    TAS_rate_dem=0;
    hgt_dem_in_old=0;
    max_sink_rate=0;
    hgt_dem_prev=0;
    hgt_dem_adj=0;
    hgt_dem_adj_last=0;
    hgt_rate_dem=0;
    height=0;
    climb_rate=0;
    pitch_dem=0;
    integSEB_state=0;
    pitch_dem_unc=0;
    last_pitch_dem=0;

    EAS_dem=17;
    TAS_dem=17;
    TAS_dem_adj=TAS_dem;
    TAS_state=17;
    integDTAS_state=0;
    vel_dot=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%AP_L1_Control
    % @Param: PERIOD
    % @DisplayName: L1 control period
    % @Description: Period in seconds of L1 tracking loop. This parameter is the primary control for agressiveness of turns in auto mode. This needs to be larger for less responsive airframes. The default of 20 is quite conservative, but for most RC aircraft will lead to reasonable flight. For smaller more agile aircraft a value closer to 15 is appropriate, or even as low as 10 for some very agile aircraft. When tuning, change this value in small increments, as a value that is much too small (say 5 or 10 below the right value) can lead to very radical turns, and a risk of stalling.
    % @Units: s
    % @Range: 1 60
    % @Increment: 1
    % @User: Standard
%     AP_GROUPINFO("PERIOD",    0, AP_L1_Control, _L1_period, 17),
L1_period=17;
    % @Param: DAMPING
    % @DisplayName: L1 control damping ratio
    % @Description: Damping ratio for L1 control. Increase this in increments of 0.05 if you are getting overshoot in path tracking. You should not need a value below 0.7 or above 0.85.
    % @Range: 0.6 1.0
    % @Increment: 0.05
    % @User: Advanced
%     AP_GROUPINFO("DAMPING",   1, AP_L1_Control, _L1_damping, 0.75f),
L1_damping=0.75;
    % @Param: XTRACK_I
    % @DisplayName: L1 control crosstrack integrator gain
    % @Description: Crosstrack error integrator gain. This gain is applied to the crosstrack error to ensure it converges to zero. Set to zero to disable. Smaller values converge slower, higher values will cause crosstrack error oscillation.
    % @Range: 0 0.1
    % @Increment: 0.01
    % @User: Advanced
%     AP_GROUPINFO("XTRACK_I",   2, AP_L1_Control, _L1_xtrack_i_gain, 0.02),
L1_xtrack_i_gain=0.00;
    % @Param: LIM_BANK
    % @DisplayName: Loiter Radius Bank Angle Limit
    % @Description: The sealevel bank angle limit for a continous loiter. (Used to calculate airframe loading limits at higher altitudes). Setting to 0, will instead just scale the loiter radius directly
    % @Units: deg
    % @Range: 0 89
    % @User: Advanced
% AP_GROUPINFO_FRAME("LIM_BANK",   3, AP_L1_Control, _loiter_bank_limit, 0.0f, AP_PARAM_FRAME_PLANE),
loiter_bank_limit=0;
% scaling factor from 1e-7 degrees to meters at equator
% == 1.0e-7 * DEG_TO_RAD * RADIUS_OF_EARTH
 LOCATION_SCALING_FACTOR = 0.011131884502145034;
% inverse of LOCATION_SCALING_FACTOR
 LOCATION_SCALING_FACTOR_INV = 89.83204953368922;

    
    target_bearing_cd=0;
    L1_dist=0;
    crosstrack_error=0;
    nav_bearing=0;
    L1_xtrack_i_gain_prev=0;
    L1_xtrack_i=0;
    last_Nu=0;
    latAccDem=0;
    WPcircle=0;
    bearing_error=0;
    data_is_stale=0;
    reverse=0;
%Bank angle command based on angle between aircraft velocity vector and reference vector to path.
%S. Park, J. Deyst, and J. P. How, "A New Nonlinear Guidance Logic for Trajectory Tracking,"
%Proceedings of the AIAA Guidance, Navigation and Control
%Conference, Aug 2004. AIAA-2004-4900.
%Modified to use PD control for circle tracking to enable loiter radius less than L1 length
%Modified to enable period and damping of guidance loop to be set explicitly
%Modified to provide explicit control over capture angle



