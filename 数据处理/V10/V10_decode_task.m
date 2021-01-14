%% OUT_TASKMODE
SL.OUT_TASKMODE.time_cal = V10Log.OUT_TASKMODE.TimeUS;
SL.OUT_TASKMODE.currentPointNum = V10Log.OUT_TASKMODE.currentPointNum;
SL.OUT_TASKMODE.prePointNum = V10Log.OUT_TASKMODE.prePointNum;
SL.OUT_TASKMODE.validPathNum = V10Log.OUT_TASKMODE.validPathNum;
SL.OUT_TASKMODE.headingCmd = V10Log.OUT_TASKMODE.headingCmd;
SL.OUT_TASKMODE.distToGo = V10Log.OUT_TASKMODE.distToGo;
SL.OUT_TASKMODE.dz = V10Log.OUT_TASKMODE.dz;
SL.OUT_TASKMODE.groundspeedCmd = V10Log.OUT_TASKMODE.groundspeedCmd;
SL.OUT_TASKMODE.rollCmd = V10Log.OUT_TASKMODE.rollCmd;
SL.OUT_TASKMODE.turnRadiusCmd = V10Log.OUT_TASKMODE.turnRadiusCmd;
SL.OUT_TASKMODE.heightCmd = V10Log.OUT_TASKMODE.heightCmd;
SL.OUT_TASKMODE.turnCenterLL0 = V10Log.OUT_TASKMODE.turnCenterLL(:,1);
SL.OUT_TASKMODE.turnCenterLL1 = V10Log.OUT_TASKMODE.turnCenterLL(:,2);
SL.OUT_TASKMODE.dR_turn = V10Log.OUT_TASKMODE.dR_turn;
try
    SL.OUT_TASKMODE.uavMode = V10Log.OUT_TASKMODE.uavMode;
catch
    SL.OUT_TASKMODE.uavMode = zeros(size(SL.OUT_TASKMODE.time_cal));
    warning('未解析 uavMode，用0值替代');
end
SL.OUT_TASKMODE.flightTaskMode = V10Log.OUT_TASKMODE.flightTaskMode;
SL.OUT_TASKMODE.flightControlMode = V10Log.OUT_TASKMODE.flightControlMode;
SL.OUT_TASKMODE.AutoManualMode = V10Log.OUT_TASKMODE.AutoManualMode;
SL.OUT_TASKMODE.comStatus = V10Log.OUT_TASKMODE.comStatus;
SL.OUT_TASKMODE.maxClimbSpeed = V10Log.OUT_TASKMODE.maxClimbSpeed;
SL.OUT_TASKMODE.prePathPoint_LLA0 = V10Log.OUT_TASKMODE.prePathPoint_LLA(:,1);
SL.OUT_TASKMODE.prePathPoint_LLA1 = V10Log.OUT_TASKMODE.prePathPoint_LLA(:,2);
SL.OUT_TASKMODE.prePathPoint_LLA2 = V10Log.OUT_TASKMODE.prePathPoint_LLA(:,3);
SL.OUT_TASKMODE.curPathPoint_LLA0 = V10Log.OUT_TASKMODE.curPathPoint_LLA(:,1);
SL.OUT_TASKMODE.curPathPoint_LLA1 = V10Log.OUT_TASKMODE.curPathPoint_LLA(:,2);
SL.OUT_TASKMODE.curPathPoint_LLA2 = V10Log.OUT_TASKMODE.curPathPoint_LLA(:,3);
% SL.OUT_TASKMODE.isTaskComplete = V10Log.OUT_TASKMODE.isTaskComplete;
% SL.OUT_TASKMODE.isHeadingRotate_OnGround = V10Log.OUT_TASKMODE.isHeadingRotate_OnGround;
% SL.OUT_TASKMODE.numTakeOff = V10Log.OUT_TASKMODE.numTakeOff;
% SL.OUT_TASKMODE.isAllowedToPause = V10Log.OUT_TASKMODE.isAllowedToPause;
% SL.OUT_TASKMODE.lastTargetPathPoint = V10Log.OUT_TASKMODE.lastTargetPathPoint;
% SL.OUT_TASKMODE.LLATaskInterrupt0 = V10Log.OUT_TASKMODE.LLATaskInterrupt0;
% SL.OUT_TASKMODE.LLATaskInterrupt1 = V10Log.OUT_TASKMODE.LLATaskInterrupt1;
% SL.OUT_TASKMODE.LLATaskInterrupt2 = V10Log.OUT_TASKMODE.LLATaskInterrupt2;
% SL.OUT_TASKMODE.airspeedCmd = V10Log.OUT_TASKMODE.airspeedCmd;
%% SL.Filter
SL.Filter.time_cal = V10Log.OUT_NAVI2CONTROL.TimeUS/1e6;
SL.Filter.algo_NAV_lond = V10Log.OUT_NAVI2CONTROL.lond;
SL.Filter.algo_NAV_latd = V10Log.OUT_NAVI2CONTROL.latd;
SL.Filter.algo_NAV_yawd = V10Log.OUT_NAVI2CONTROL.yawd;
SL.Filter.algo_NAV_pitchd = V10Log.OUT_NAVI2CONTROL.pitchd;
SL.Filter.algo_NAV_rolld = V10Log.OUT_NAVI2CONTROL.rolld;
SL.Filter.algo_NAV_alt = V10Log.OUT_NAVI2CONTROL.alt;
SL.Filter.algo_NAV_Vn = V10Log.OUT_NAVI2CONTROL.Vn;
SL.Filter.algo_NAV_Ve = V10Log.OUT_NAVI2CONTROL.Ve;
SL.Filter.algo_NAV_Vd = V10Log.OUT_NAVI2CONTROL.Vd;