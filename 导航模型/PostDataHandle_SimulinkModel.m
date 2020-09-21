function [navFilterMARGRes,t_alignment] = PostDataHandle_SimulinkModel(out,Ts_imu)
idx = 1;

stateEst = out.NavFilterRes.state.Data;
stateCovarianceDiag = out.NavFilterRes.Pdiag.Data;

idx_sub = 0;
if length(out.tout) == size(stateEst,1)
    filterRes(idx).MARG.time = out.tout;
else
    filterRes(idx).MARG.time = out.tout(1:3:end);
end
if length(filterRes(idx).MARG.time) > size(stateEst,1)
    filterRes(idx).MARG.time(end) = [];
end
filterRes(idx).MARG.q = quaternion(stateEst(1:end-idx_sub,1:4));
filterRes(idx).MARG.pos = stateEst(1:end-idx_sub,5:7);
filterRes(idx).MARG.vel = stateEst(1:end-idx_sub,8:10);
filterRes(idx).MARG.dangle = stateEst(1:end-idx_sub,11:13);
filterRes(idx).MARG.dvel = stateEst(1:end-idx_sub,14:16);
filterRes(idx).MARG.mag = stateEst(1:end-idx_sub,17:19);
filterRes(idx).MARG.dmag = stateEst(1:end-idx_sub,20:22);
filterRes(idx).MARG.P = stateCovarianceDiag(1:end-idx_sub,:);
refloc = out.NavFilterRes.refloc.Data(end,:);
% ◊˜Õº
plotOpt = setPlotOpt; % …Ë÷√plot Ù–‘
stepSpace = 1;
filterRes(idx).MARG.euler = eulerd(filterRes(idx).MARG.q,'ZYX','frame');
filterTemp = filterRes(idx).MARG;
filterTemp.eulerd = eulerd(filterTemp.q,'ZYX','frame');
filterTemp.lla = out.lla.Data;
navFilterMARGRes(idx).Algo.time_algo = filterTemp.time;
navFilterMARGRes(idx).Algo.algo_yaw = filterTemp.eulerd(:,1);
navFilterMARGRes(idx).Algo.algo_pitch = filterTemp.eulerd(:,2);
navFilterMARGRes(idx).Algo.algo_roll = filterTemp.eulerd(:,3);
navFilterMARGRes(idx).Algo.algo_curr_pos_0 = filterTemp.lla(:,1);
navFilterMARGRes(idx).Algo.algo_curr_pos_1 = filterTemp.lla(:,2);
navFilterMARGRes(idx).Algo.algo_curr_pos_2 = filterTemp.lla(:,3);
navFilterMARGRes(idx).Algo.algo_curr_vel_0 = filterTemp.vel(:,1);
navFilterMARGRes(idx).Algo.algo_curr_vel_1 = filterTemp.vel(:,2);
navFilterMARGRes(idx).Algo.algo_curr_vel_2 = filterTemp.vel(:,3);
navFilterMARGRes(idx).Algo.dAB_00 = filterTemp.dvel(:,1)*1/Ts_imu;
navFilterMARGRes(idx).Algo.dAB_11 = filterTemp.dvel(:,2)*1/Ts_imu;
navFilterMARGRes(idx).Algo.dAB_22 = filterTemp.dvel(:,3)*1/Ts_imu;
navFilterMARGRes(idx).Algo.dWB_00 = filterTemp.dangle(:,1)*1/Ts_imu*180/pi;
navFilterMARGRes(idx).Algo.dWB_11 = filterTemp.dangle(:,2)*1/Ts_imu*180/pi;
navFilterMARGRes(idx).Algo.dWB_22 = filterTemp.dangle(:,3)*1/Ts_imu*180/pi;
navFilterMARGRes(idx).Algo.magB_x = filterTemp.mag(:,1);
navFilterMARGRes(idx).Algo.magB_y = filterTemp.mag(:,2);
navFilterMARGRes(idx).Algo.magB_z = filterTemp.mag(:,3);
navFilterMARGRes(idx).Algo.dmagB_x = filterTemp.dmag(:,1);
navFilterMARGRes(idx).Algo.dmagB_y = filterTemp.dmag(:,2);
navFilterMARGRes(idx).Algo.dmagB_z = filterTemp.dmag(:,3);

navFilterMARGRes(idx).Algo.posmNED = filterRes(idx).MARG.pos;

temp = navFilterMARGRes(idx).Algo.time_algo(out.NavFilterRes.initialAlignmentCompleteFlag.Data(1:end-1)==1);
if ~isempty(temp)
    t_alignment(idx) = temp(1);
else
    t_alignment(idx) = inf;
end