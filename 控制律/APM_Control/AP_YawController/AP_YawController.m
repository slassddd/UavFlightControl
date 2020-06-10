%  AP_YawController 

	% @Param: SLIP
	% @DisplayName: Sideslip control gain
	% @Description: Gain from lateral acceleration to demanded yaw rate for aircraft with enough fuselage area to detect lateral acceleration and sideslips. Do not enable for flying wings and gliders. Actively coordinates flight more than just yaw damping. Set after YAW2SRV_DAMP and YAW2SRV_INT are tuned.
	% @Range: 0 4
	% @Increment: 0.25
    % @User: Advanced
% 	AP_GROUPINFO("SLIP",    0, AP_YawController, _K_A,    0),
K_A_yaw=0;
	% @Param: INT
	% @DisplayName: Sideslip control integrator
	% @Description: Integral gain from lateral acceleration error. Effectively trims rudder to eliminate long-term sideslip.
	% @Range: 0 2
	% @Increment: 0.25
    % @User: Advanced
% 	AP_GROUPINFO("INT",    1, AP_YawController, _K_I,    0),
K_I_yaw=0;
	% @Param: DAMP
	% @DisplayName: Yaw damping
	% @Description: Gain from yaw rate to rudder. Most effective at yaw damping and should be tuned after KFF_RDDRMIX. Also disables YAW2SRV_INT if set to 0.
	% @Range: 0 2
	% @Increment: 0.25
    % @User: Advanced
% 	AP_GROUPINFO("DAMP",   2, AP_YawController, _K_D,    0),
K_D_yaw=0;
	% @Param: RLL
	% @DisplayName: Yaw coordination gain
	% @Description: Gain to the yaw rate required to keep it consistent with the turn rate in a coordinated turn. Corrects for yaw tendencies after the turn is established. Increase yaw into the turn by raising. Increase yaw out of the turn by decreasing. Values outside of 0.9-1.1 range indicate airspeed calibration problems.
	% @Range: 0.8 1.2
	% @Increment: 0.05
    % @User: Advanced
% 	AP_GROUPINFO("RLL",   3, AP_YawController, _K_FF,   1),
K_FF_yaw=0;
     
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
    
    dt=0.012;
    pitch=0;
    roll=0;
    wz=0;
    airspeed_min=13;       
    GRAVITY_MSS=9.80665;
    eas2tas=1;
    aspeed=17;
    HD=180/pi;
    accel_y=0;
