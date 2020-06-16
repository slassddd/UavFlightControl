
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
gains_D_roll=0.08;
	% @Param: I
	% @DisplayName: Integrator Gain
	% @Description: Integrator gain from long-term roll angle offsets to ailerons. Higher values "trim" out offsets faster but can cause oscillations. Automatically set and adjusted by AUTOTUNE mode.
	% @Range: 0 1.0
	% @Increment: 0.05
	% @User: User
% 	AP_GROUPINFO("I",        3, AP_RollController, gains.I,        0.3f),
gains_I_roll=0.3;
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
    
    
    HD=180/pi;    
    dt=0.012;
    pitch=0;
    roll=0;
    wy=0;
    wx=0;
    airspeed_min=13;
    GRAVITY_MSS=9.80665;
    eas2tas=1;
    aspeed=17;


