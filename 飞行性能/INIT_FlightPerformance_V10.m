Ts_FlightPerf.Ts_base = 0.036;
FLIGHT_PERF_PARAM_V10.powerRate_GroundStandBy = 1/450; % 地面待机耗电率,[%/sec]
FLIGHT_PERF_PARAM_V10.powerRate_FixCruise = 1/53; % 固定翼巡航耗电率,[%/sec]
FLIGHT_PERF_PARAM_V10.powerRate_FixHoverUp = 1/25; % 固定翼HoverUp耗电率,[%/sec]
FLIGHT_PERF_PARAM_V10.powerRate_FixHoverDown = 1/70; % 固定翼HoverDown耗电率,[%/sec]
FLIGHT_PERF_PARAM_V10.powerRate_FixHoverLevel = ...
    1/2*(FLIGHT_PERF_PARAM_V10.powerRate_FixHoverUp + FLIGHT_PERF_PARAM_V10.powerRate_FixCruise); % 固定翼HoverLevel耗电率,[%/sec]
FLIGHT_PERF_PARAM_V10.powerRate_RotorHoverNoWind = 1/12; % 旋翼耗电率,[%/sec]
FLIGHT_PERF_PARAM_V10.powerRate_RotorMoveNoWind = 1/11; % 旋翼耗电率,[%/sec]
FLIGHT_PERF_PARAM_V10.powerRate_RotorUpNoWind = 1/10; % 旋翼耗电率,[%/sec]
FLIGHT_PERF_PARAM_V10.powerRate_RotorDownNoWind = 1/15; % 旋翼耗电率,[%/sec]
FLIGHT_PERF_PARAM_V10.reservedPowerRate = 15; % 预留电量百分比,[%]
FLIGHT_PERF_PARAM_V10.addedDistByEachTurnCorrect = 20; % 每个航点转换的额外里程,[m]
FLIGHT_PERF_PARAM_V10.maxFixWingRange = 18*3600*2; % 最大航程,[m]
FLIGHT_PERF_PARAM_V10.powerRatio_Altitude = 0.5; % 6000m海拔相对0m海拔的额外耗系数
% FlightPerfParam_V10 = FlightPerfParam_V10;