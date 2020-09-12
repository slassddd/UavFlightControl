Ts_FlightPerf.Ts_base = 0.036;
FlightPerfParam_V1000.powerRate_GroundStandBy = 1/450; % 地面待机耗电率,[%/sec]
FlightPerfParam_V1000.powerRate_FixCruise = 1/53; % 固定翼巡航耗电率,[%/sec]
FlightPerfParam_V1000.powerRate_FixHoverUp = 1/25; % 固定翼HoverUp耗电率,[%/sec]
FlightPerfParam_V1000.powerRate_FixHoverDown = 1/70; % 固定翼HoverDown耗电率,[%/sec]
FlightPerfParam_V1000.powerRate_FixHoverLevel = ...
    1/2*(FlightPerfParam_V1000.powerRate_FixHoverUp + FlightPerfParam_V1000.powerRate_FixCruise); % 固定翼HoverLevel耗电率,[%/sec]
FlightPerfParam_V1000.powerRate_RotorHoverNoWind = 1/12; % 旋翼耗电率,[%/sec]
FlightPerfParam_V1000.powerRate_RotorMoveNoWind = 1/11; % 旋翼耗电率,[%/sec]
FlightPerfParam_V1000.powerRate_RotorUpNoWind = 1/10; % 旋翼耗电率,[%/sec]
FlightPerfParam_V1000.powerRate_RotorDownNoWind = 1/15; % 旋翼耗电率,[%/sec]
FlightPerfParam_V1000.reservedPowerRate = 13; % 预留电量百分比,[%]
FlightPerfParam_V1000.addedDistByEachTurnCorrect = 20; % 每个航点转换的额外里程,[m]
FlightPerfParam_V1000.maxFixWingRange = 18*3600*2; % 最大航程,[m]
FlightPerfParam_V1000.powerRatio_Altitude = 0.2; % 6000m海拔相对0m海拔的额外耗系数
% FlightPerfParam_V1000 = FlightPerfParam_V1000;