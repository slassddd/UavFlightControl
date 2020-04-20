	AC_AttitudeControl_data
    mode_Multicopter
    POSCONTROL_POS_Z_P=1;    % vertical position controller P gain default
    POSCONTROL_VEL_Z_P=4.0;    % vertical velocity controller P gain default
    POSCONTROL_ACC_Z_P=1;    % vertical acceleration controller P gain default
    POSCONTROL_ACC_Z_I=0.1;    % vertical acceleration controller I gain default
    POSCONTROL_ACC_Z_D=0.01;    % vertical acceleration controller D gain default
    POSCONTROL_ACC_Z_IMAX=800;    % vertical acceleration controller IMAX gain default
    POSCONTROL_ACC_Z_FILT_HZ=20.0;    % vertical acceleration controller input filter default
    POSCONTROL_ACC_Z_DT=0.0025;    % vertical acceleration controller dt default
    
    POSCONTROL_POS_XY_P=0.8;    % horizontal position controller P gain default
    POSCONTROL_VEL_XY_P=2.0;    % horizontal velocity controller P gain default
    POSCONTROL_VEL_XY_I=0.1;    % horizontal velocity controller I gain default
    POSCONTROL_VEL_XY_D=0.3;    % horizontal velocity controller D gain default
    POSCONTROL_VEL_XY_IMAX=1000.0;    % horizontal velocity controller IMAX gain default
    POSCONTROL_VEL_XY_FILT_HZ=5.0;    % horizontal velocity controller input filter
    POSCONTROL_VEL_XY_FILT_D_HZ=5.0;    % horizontal velocity controller input filter for D
  
    POSCONTROL_ACCELERATION_MIN=50.0;% minimum horizontal acceleration in cm/s/s - used for sanity checking acceleration in leash length calculation
    POSCONTROL_ACCEL_XY=        100.0;%default horizontal acceleration in cm/s/s.  This is overwritten by waypoint and loiter controllers
    POSCONTROL_ACCEL_XY_MAX=    980.0;%max horizontal acceleration in cm/s/s that the position velocity controller will ask from the lower accel controller
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
    p_pos_z=1.5;

    %@Param: _VELZ_P
    %@DisplayName: Velocity (vertical) controller P gain
    %@Description: Velocity (vertical) controller P gain.  Converts the difference between desired vertical speed and actual speed into a desired acceleration that is passed to the throttle acceleration controller
    %@Range: 1.000 8.000
    %@User: Standard
    p_vel_z=1.5;

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

 GRAVITY_MSS=9.80665;
 HD=180/pi;

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
 curr_vel=[0 0 0];
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
 roll_target=000;
 pitch_target=0;
 yaw_target=0;
 target_yaw_rate=0;
 
 pitch=-0/HD;
 roll=0;
 yaw=0;
 qtemp=from_euler([roll pitch yaw]);
 rot_body_to_ned=rotation_matrix(qtemp);

 
 attitude_target_euler_angle=[roll_target pitch_target yaw_target]*0.01/HD;
 attitude_target_quat=from_euler(attitude_target_euler_angle);

attitude_target_ang_vel=[0 0 0];
attitude_target_euler_rate=[0 0 0];
attitude_ang_error=[1 0 0 0];
use_sqrt_controller=1;
 
 %%%%%%%%%%%%%%%%%%%%%%
 throttle_rpy_mix=0;
 curr_pos=[0 0 0];
 VN=0;
 VE=0;
 pid_vel_xy_reset_filter=1;
 pid_vel_xy_input=[0 0];
 pid_vel_xy_derivative=[0 0];
 pid_vel_xy_integrator=[0 0];
 limit_accel_xy=0;
 motors_limit_throttle_upper=0;
 reset_accel_to_lean_xy=1;
 accel_xy_input=[0 0];
 accel_xy_angle_max=1500;%%dai cha

 AC_ATTITUDE_CONTROL_ANGLE_LIMIT_THROTTLE_MAX=0.8;
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
current_tilt=0;
air_density_ratio=1;
thrust_boost=0;
pwm_max=2000;
pwm_min=1000;
thrust_slew_time=0.01;%%%%%%%%%%%%%%%%”Õ√≈ ±º‰

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

throttle_hover=0.4816;
throttle_in=0.4816;
throttle_filter=0;
pwm_out=ones(1,4)*(throttle_hover*0+1000);

thrust_boost_ratio=0;
thrust_rpyt_out=[0 0 0 0];
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thrust_error_angle=0;
rate_target_ang_vel=[0 0 0];
gyro_x=0;
gyro_y=0;
gyro_z=0;
accel_x=0;
accel_y=0;
accel_z=0;

dt=0.024;
attitude_error_vector=[0 0 0];
mode_fy=1;
climb_rate_cms=0;
mode=0;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%