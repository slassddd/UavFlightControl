function FLIGHT_PERF_PARAM_V1000 = INIT_FlightPerformance_V1000()
FLIGHT_PERF_PARAM_V1000 = Simulink.Bus.createMATLABStruct('BUS_FLIGHTPERF_PARAM');
FLIGHT_PERF_PARAM_V1000.powerRate_GroundStandBy = 1/450; % 地面待机耗电率,[%/sec]
FLIGHT_PERF_PARAM_V1000.powerRate_FixCruise = 1/53; % 固定翼巡航耗电率,[%/sec]
FLIGHT_PERF_PARAM_V1000.powerRate_FixHoverUp = 1/25; % 固定翼HoverUp耗电率,[%/sec]
FLIGHT_PERF_PARAM_V1000.powerRate_FixHoverDown = 1/140; % 固定翼HoverDown耗电率,[%/sec]
FLIGHT_PERF_PARAM_V1000.powerRate_FixHoverLevel = ...
    1/2*(FLIGHT_PERF_PARAM_V1000.powerRate_FixHoverUp + FLIGHT_PERF_PARAM_V1000.powerRate_FixCruise); % 固定翼HoverLevel耗电率,[%/sec]
FLIGHT_PERF_PARAM_V1000.powerRate_RotorHoverNoWind = 1/12; % 旋翼耗电率,[%/sec]
FLIGHT_PERF_PARAM_V1000.powerRate_RotorMoveNoWind = 1/11; % 旋翼耗电率,[%/sec]
FLIGHT_PERF_PARAM_V1000.powerRate_RotorUpNoWind = 1/10; % 旋翼耗电率,[%/sec]
FLIGHT_PERF_PARAM_V1000.powerRate_RotorDownNoWind = 1/13; % 旋翼耗电率,[%/sec]
FLIGHT_PERF_PARAM_V1000.reservedPowerRate_normal = 15; % 预留电量百分比,[%]
FLIGHT_PERF_PARAM_V1000.reservedPowerRate_rotor = 10; % 预留电量百分比,[%]
FLIGHT_PERF_PARAM_V1000.addedDistByEachTurnCorrect = 20; % 每个航点转换的额外里程,[m]
FLIGHT_PERF_PARAM_V1000.maxFixWingRange = 18*3600*1; % 最大航程,[m]
FLIGHT_PERF_PARAM_V1000.powerRatio_Altitude = 0.5; % 6000m海拔相对0m海拔的额外耗系数
