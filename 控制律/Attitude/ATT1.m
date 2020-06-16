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
    gains_P_pitch=3;
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
    gains_I_pitch=0.0;
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
gains_P_roll=0.1;
	% @Param: D
	% @DisplayName: Damping Gain
	% @Description: Damping gain from roll acceleration to ailerons. Higher values reduce rolling in turbulence, but can cause oscillations. Automatically set and adjusted by AUTOTUNE mode.
	% @Range: 0 0.2
	% @Increment: 0.01
	% @User: User
% 	AP_GROUPINFO("D",        2, AP_RollController, gains.D,        0.08f),
gains_D_roll=0.1;
	% @Param: I
	% @DisplayName: Integrator Gain
	% @Description: Integrator gain from long-term roll angle offsets to ailerons. Higher values "trim" out offsets faster but can cause oscillations. Automatically set and adjusted by AUTOTUNE mode.
	% @Range: 0 1.0
	% @Increment: 0.05
	% @User: User
% 	AP_GROUPINFO("I",        3, AP_RollController, gains.I,        0.3f),
gains_I_roll=0.0;
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
K_I_yaw=0.0;
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
vertAccLim=7;
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
ptchDamp=0.3;
    % @Param: SINK_MAX
    % @DisplayName: Maximum Descent Rate (metres/sec)
    % @Description: Maximum demanded descent rate. Do not set higher than the vertical speed the aircraft can maintain at THR_MIN, TECS_PITCH_MIN, and ARSPD_FBW_MAX.
    % @Increment: 0.1
    % @Range: 0.0 20.0
    % @User: User
%     AP_GROUPINFO("SINK_MAX",  11, AP_TECS, _maxSinkRate, 5.0f),
maxSinkRate=5;
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
L1_xtrack_i_gain=0.02;
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pwm_max=2000;
    pwm_min=1000;
    pwm_out=zeros(4,1);
    highest_airspeed=35;
    scaling_speed=17;
    airspeed_max=25;
    airspeed_min=13;

    TASmax=23;
    TASmin=14;
    throttle_slewrate=100;
    THRmaxf=1;
    THRminf=0;
    throttle_min=0;
    throttle_max=100; 
    throttle_cruise=23;
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
    

    kff_throttle_to_pitch=0;
    smoothed_airspeed=0;
    aerodynamic_load_factor=1;
    kff_rudder_mix=0;
    vdot_filter=zeros(5,1);
    rot_body_to_ned=eye(3,3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    HD=180/pi;
    dt=0.001;
    pitch=0;
    roll=0;
    yaw=0;
    wy=0;
    wx=0;
    wz=0;
    accel_x=0;
    accel_y=0;    
    accel_z=0;
    Vz=0;
    EAS=17;
    aspeed=17;
    EAS2TAS=1;   
    GRAVITY_MSS=9.80665;
   
    groundspeed_vector=[0 0];
    current_loc=[40,110];
    center_WP=[40,110]*1e7;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m=5;
Jx=186222*1e-6;
Jy=164400*1e-6;
Jz=336920*1e-6;
% Jx=186222*1e-5;
% Jy=164400*1e-5;
% Jz=336920*1e-5;
J=diag([Jx Jy Jz]);