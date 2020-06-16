% "AP_L1_Control.h"
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
%     AP_GROUPINFO_FRAME("LIM_BANK",   3, AP_L1_Control, _loiter_bank_limit, 0.0f, AP_PARAM_FRAME_PLANE),
    loiter_bank_limit=0;
    HD=180/pi;
    % scaling factor from 1e-7 degrees to meters at equator
    % == 1.0e-7 * DEG_TO_RAD * RADIUS_OF_EARTH
     LOCATION_SCALING_FACTOR = 0.011131884502145034;
    % inverse of LOCATION_SCALING_FACTOR
     LOCATION_SCALING_FACTOR_INV = 89.83204953368922;
    dt=0.01;
    current_loc=[40,110];
    groundspeed_vector=[14,14];
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
    yaw=0;
    reverse=0;
    GRAVITY_MSS=9.8;
    target_airspeed=17;
    EAS2TAS=1;
%Bank angle command based on angle between aircraft velocity vector and reference vector to path.
%S. Park, J. Deyst, and J. P. How, "A New Nonlinear Guidance Logic for Trajectory Tracking,"
%Proceedings of the AIAA Guidance, Navigation and Control
%Conference, Aug 2004. AIAA-2004-4900.
%Modified to use PD control for circle tracking to enable loiter radius less than L1 length
%Modified to enable period and damping of guidance loop to be set explicitly
%Modified to provide explicit control over capture angle
