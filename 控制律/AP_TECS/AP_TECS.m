%"AP_TECS.h"
 
%Debug("%.2f %.2f %.2f %.2f \n", var1, var2, var3, var4);

% table of user settable parameters
 
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
timeConst=5;
    % @Param: THR_DAMP
    % @DisplayName: Controller throttle damping
    % @Description: Damping gain for throttle demand loop. Slows the throttle response to correct for speed and height oscillations.
    % @Range: 0.1 1.0
    % @Increment: 0.1
    % @User: Advanced
%     AP_GROUPINFO("THR_DAMP",    3, AP_TECS, _thrDamp, 0.5f),
thrDamp=0.5;
    % @Param: INTEG_GAIN
    % @DisplayName: Controller integrator
    % @Description: Integrator gain to trim out long-term speed and height errors.
    % @Range: 0.0 0.5
    % @Increment: 0.02
    % @User: Advanced
%     AP_GROUPINFO("INTEG_GAIN", 4, AP_TECS, _integGain, 0.1f),
integGain=0.1;
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
hgtCompFiltOmega=3;
    % @Param: SPD_OMEGA
    % @DisplayName: Speed complementary filter frequency (radians/sec)
    % @Description: This is the cross-over frequency of the complementary filter used to fuse longitudinal acceleration and airspeed to obtain a lower noise and lag estimate of airspeed.
    % @Range: 0.5 2.0
    % @Increment: 0.05
    % @User: Advanced
%     AP_GROUPINFO("SPD_OMEGA", 7, AP_TECS, _spdCompFiltOmega, 2.0f),
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
ptchDamp=0;
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
landAirspeed=-1;
    % @Param: LAND_THR
    % @DisplayName: Cruise throttle during landing approach (percentage)
    % @Description: Use this parameter instead of LAND_ARSPD if your platform does not have an airspeed sensor.  It is the cruise throttle during landing approach.  If this value is negative then it is disabled and TECS_LAND_ARSPD is used instead.
    % @Range: -1 100
    % @Increment: 0.1
    % @User: User
%     AP_GROUPINFO("LAND_THR", 13, AP_TECS, _landThrottle, -1),
landThrottle=-1;
    % @Param: LAND_SPDWGT
    % @DisplayName: Weighting applied to speed control during landing.
    % @Description: Same as SPDWEIGHT parameter, with the exception that this parameter is applied during landing flight stages.  A value closer to 2 will result in the plane ignoring height error during landing and our experience has been that the plane will therefore keep the nose up -- sometimes good for a glider landing (with the side effect that you will likely glide a ways past the landing point).  A value closer to 0 results in the plane ignoring speed error -- use caution when lowering the value below 1 -- ignoring speed could result in a stall. Values between 0 and 2 are valid values for a fixed landing weight. When using -1 the weight will be scaled during the landing. At the start of the landing approach it starts with TECS_SPDWEIGHT and scales down to 0 by the time you reach the land point. Example: Halfway down the landing approach you'll effectively have a weight of TECS_SPDWEIGHT/2.
    % @Range: -1.0 2.0
    % @Increment: 0.1
    % @User: Advanced
%     AP_GROUPINFO("LAND_SPDWGT", 14, AP_TECS, _spdWeightLand, -1.0f),
spdWeightLand=-1;
    % @Param: PITCH_MAX
    % @DisplayName: Maximum pitch in auto flight
    % @Description: Overrides LIM_PITCH_MAX in automatic throttle modes to reduce climb rates. Uses LIM_PITCH_MAX if set to 0. For proper TECS tuning, set to the angle that the aircraft can climb at TRIM_ARSPD_CM and THR_MAX.
    % @Range: 0 45
    % @Increment: 1
    % @User: Advanced
%     AP_GROUPINFO("PITCH_MAX", 15, AP_TECS, _pitch_max, 15),
pitch_max=15;
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
land_sink=0.25;
    % @Param: LAND_TCONST
    % @DisplayName: Land controller time constant (sec)
    % @Description: This is the time constant of the TECS control algorithm when in final landing stage of flight. It should be smaller than TECS_TIME_CONST to allow for faster flare
    % @Range: 1.0 5.0
    % @Increment: 0.2
    % @User: Advanced
%     AP_GROUPINFO("LAND_TCONST", 18, AP_TECS, _landTimeConst, 2.0f),
landTimeConst=2;
    % @Param: LAND_DAMP
    % @DisplayName: Controller sink rate to pitch gain during flare
    % @Description: This is the sink rate gain for the pitch demand loop when in final landing stage of flight. It should be larger than TECS_PTCH_DAMP to allow for better sink rate control during flare.
    % @Range: 0.1 1.0
    % @Increment: 0.1
    % @User: Advanced
%     AP_GROUPINFO("LAND_DAMP", 19, AP_TECS, _landDamp, 0.5f),
landDamp=0.5;
    % @Param: LAND_PMAX
    % @DisplayName: Maximum pitch during final stage of landing
    % @Description: This limits the pitch used during the final stage of automatic landing. During the final landing stage most planes need to keep their pitch small to avoid stalling. A maximum of 10 degrees is usually good. A value of zero means to use the normal pitch limits.
    % @Range: -5 40
    % @Increment: 1
    % @User: Advanced
%     AP_GROUPINFO("LAND_PMAX", 20, AP_TECS, _land_pitch_max, 10),
land_pitch_max=10;
    % @Param: APPR_SMAX
    % @DisplayName: Sink rate max for landing approach stage
    % @Description: The sink rate max for the landing approach stage of landing. This will need to be large for steep landing approaches especially when using reverse thrust. If 0, then use TECS_SINK_MAX.
    % @Range: 0.0 20.0
    % @Units: m/s
    % @Increment: 0.1
    % @User: Advanced
%     AP_GROUPINFO("APPR_SMAX", 21, AP_TECS, _maxSinkRate_approach, 0),
maxSinkRate_approach=0;
    % @Param: LAND_SRC
    % @DisplayName: Land sink rate change
    % @Description: When zero, the flare sink rate (TECS_LAND_SINK) is a fixed sink demand. With this enabled the flare sinkrate will increase/decrease the flare sink demand as you get further beyond the LAND waypoint. Has no effect before the waypoint. This value is added to TECS_LAND_SINK proportional to distance traveled after wp. With an increasing sink rate you can still land in a given distance if you're traveling too fast and cruise passed the land point. A positive value will force the plane to land sooner proportional to distance passed land point. A negative number will tell the plane to slowly climb allowing for a pitched-up stall landing. Recommend 0.2 as initial value.
    % @Range: -2.0 2.0
    % @Units: m/s/m
    % @Increment: 0.1
    % @User: Advanced
%     AP_GROUPINFO("LAND_SRC", 22, AP_TECS, _land_sink_rate_change, 0),
land_sink_rate_change=0;
    % @Param: LAND_TDAMP
    % @DisplayName: Controller throttle damping when landing
    % @Description: This is the damping gain for the throttle demand loop during and auto-landing. Same as TECS_THR_DAMP but only in effect during an auto-land. Increase to add damping to correct for oscillations in speed and height. When set to 0 landing throttle damp is controlled by TECS_THR_DAMP.
    % @Range: 0.1 1.0
    % @Increment: 0.1
    % @User: Advanced
%     AP_GROUPINFO("LAND_TDAMP", 23, AP_TECS, _land_throttle_damp, 0),
land_throttle_damp=0;
    % @Param: LAND_IGAIN
    % @DisplayName: Controller integrator during landing
    % @Description: This is the integrator gain on the control loop during landing. When set to 0 then TECS_INTEG_GAIN is used. Increase to increase the rate at which speed and height offsets are trimmed out. Typically values lower than TECS_INTEG_GAIN work best
    % @Range: 0.0 0.5
    % @Increment: 0.02
    % @User: Advanced
%     AP_GROUPINFO("LAND_IGAIN", 24, AP_TECS, _integGain_land, 0),
integGain_land=0;
    % @Param: TKOFF_IGAIN
    % @DisplayName: Controller integrator during takeoff
    % @Description: This is the integrator gain on the control loop during takeoff. When set to 0 then TECS_INTEG_GAIN is used. Increase to increase the rate at which speed and height offsets are trimmed out. Typically values higher than TECS_INTEG_GAIN work best
    % @Range: 0.0 0.5
    % @Increment: 0.02
    % @User: Advanced
%     AP_GROUPINFO("TKOFF_IGAIN", 25, AP_TECS, _integGain_takeoff, 0),
integGain_takeoff=0;
    % @Param: LAND_PDAMP
    % @DisplayName: Pitch damping gain when landing
    % @Description: This is the damping gain for the pitch demand loop during landing. Increase to add damping  to correct for oscillations in speed and height. If set to 0 then TECS_PTCH_DAMP will be used instead.
    % @Range: 0.1 1.0
    % @Increment: 0.1
    % @User: Advanced
%     AP_GROUPINFO("LAND_PDAMP", 26, AP_TECS, _land_pitch_damp, 0),
land_pitch_damp=0;
    % @Param: SYNAIRSPEED
    % @DisplayName: Enable the use of synthetic airspeed
    % @Description: This enable the use of synthetic airspeed for aircraft that don't have a real airspeed sensor. This is useful for development testing where the user is aware of the considerable limitations of the synthetic airspeed system, such as very poor estimates when a wind estimate is not accurate. Do not enable this option unless you fully understand the limitations of a synthetic airspeed estimate.
    % @Values: 0:Disable,1:Enable
    % @User: Advanced
%     AP_GROUPINFO("SYNAIRSPEED", 27, AP_TECS, _use_synthetic_airspeed, 0),
 use_synthetic_airspeed=0;   

    TASmax=23;
    SKE_dem=0;
    TASmin=14;
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

    rot_body_to_ned=eye(3,3);
    THRmaxf=1;
    THRminf=0;
    throttle_slewrate=100;
    throttle_dem=0;
    last_throttle_dem=0;
    DT=0.01;
    integTHR_state=0;
    
  hgt_dem=0;
  throttle_min=0;
  throttle_max=100;
  PITCHmaxf=0;
  PITCHminf=0;
  pitch_limit_max_cd=2500;
  pitch_limit_min_cd=-1300;
  pitch_max_limit=30;
  
  timeConstant=0.15;
  throttle_cruise=40;
  k_ff_throttle=1;
  EAS_dem=17;
  EAS2TAS=1;
  TAS_dem=EAS_dem*EAS2TAS;
  TAS_dem_adj=TAS_dem;

  airspeed_max=23;
  airspeed_min=14;
  EAS=17;
  TAS_state=EAS*EAS2TAS;
  integDTAS_state=0;
  vel_dot=0;
  
GRAVITY_MSS=9.8;
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