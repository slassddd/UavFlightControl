
 
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
    gains_P_pitch=0.3;
	% @Param: D
	% @DisplayName: Damping Gain
	% @Description: Damping gain from pitch acceleration to elevator. Higher values reduce pitching in turbulence, but can cause oscillations. Automatically set and adjusted by AUTOTUNE mode.
	% @Range: 0 0.2
	% @Increment: 0.01
	% @User: User
%     AP_GROUPINFO("D",        2, AP_PitchController, gains.D,        0.04f),
    gains_D_pitch=0.15;
	% @Param: I
	% @DisplayName: Integrator Gain
	% @Description: Integrator gain from long-term pitch angle offsets to elevator. Higher values "trim" out offsets faster but can cause oscillations. Automatically set and adjusted by AUTOTUNE mode.
	% @Range: 0 0.5
	% @Increment: 0.05
	% @User: User
% 	AP_GROUPINFO("I",        3, AP_PitchController, gains.I,        0.3f),
    gains_I_pitch=0.01;
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    HD=180/pi;
    dt=0.012;
    pitch=0;
    roll=0;
    wy=0;
    airspeed_min=13;
    GRAVITY_MSS=9.80665;
    eas2tas=1;
    roll_limit_cd=4500;
    aspeed=17;
    
