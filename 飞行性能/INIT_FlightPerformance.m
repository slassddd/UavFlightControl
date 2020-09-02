Ts_FlightPerf.Ts_base = 0.036;
FlightPerfParam.powerRate_GroundStandBy = 1/450; % 地面待机耗电率,[%/sec]
FlightPerfParam.powerRate_FixCruise = 1/53; % 固定翼巡航耗电率,[%/sec]
FlightPerfParam.powerRate_FixHoverUp = 1/25; % 固定翼HoverUp耗电率,[%/sec]
FlightPerfParam.powerRate_FixHoverDown = 1/70; % 固定翼HoverDown耗电率,[%/sec]
FlightPerfParam.powerRate_FixHoverLevel = ...
    1/2*(FlightPerfParam.powerRate_FixHoverUp + FlightPerfParam.powerRate_FixCruise); % 固定翼HoverLevel耗电率,[%/sec]
FlightPerfParam.powerRate_RotorHoverNoWind = 1/12; % 旋翼耗电率,[%/sec]
FlightPerfParam.powerRate_RotorMoveNoWind = 1/11; % 旋翼耗电率,[%/sec]
FlightPerfParam.powerRate_RotorUpNoWind = 1/10; % 旋翼耗电率,[%/sec]
FlightPerfParam.powerRate_RotorDownNoWind = 1/15; % 旋翼耗电率,[%/sec]
FlightPerfParam.reservedPowerRate = 13; % 预留电量百分比,[%]
FlightPerfParam.addedDistByEachTurnCorrect = 20; % 每个航点转换的额外里程,[m]
FlightPerfParam.maxFixWingRange = 18*3600*2; % 最大航程,[m]