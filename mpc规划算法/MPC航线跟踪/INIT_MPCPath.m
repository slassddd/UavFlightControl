clear nlmpcObj_path
MPCParam_path.Ts = 0.036*3;
MPCParam_path.Ts_mpc = 0.036*3;
MPCParam_path.p = 5;
MPCParam_path.m = 3;
MPCParam_path.maxRoll = 50*pi/180;
MPCParam_path.maxRollRate = 60*pi/180*MPCParam_path.Ts;
MPCParam_path.nx = 2; % yaw,dz
MPCParam_path.ny = 2; % yaw,dz
MPCParam_path.nu = 1; % phi
MPCParam_path.V = 18;
MPCParam_path.StateFcn = "uavPathFollowStateFcn";
MPCParam_path.StateJacobianFcn = "uavPathFollowStateJacobianFcn";
[nlmpcObj_path,nloptions] = nlmpc_pathfollow(MPCParam_path);