function [MARGRes,t_alignment] = getSimRes_Navi(out,Ts_imu)
idx = 1;
stateEst = out.NavFilterRes.state.Data;
stateCovarianceDiag = out.NavFilterRes.stateCovariance.Data;

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
refloc = out.NavFilterRes.InitValue.refloc.Data(end,:);
% 浣滃浘
plotOpt = setPlotOpt; % 璁剧疆plot灞炴��
stepSpace = 1;
filterRes(idx).MARG.euler = eulerd(filterRes(idx).MARG.q,'ZYX','frame');
filterTemp = filterRes(idx).MARG;
filterTemp.eulerd = eulerd(filterTemp.q,'ZYX','frame');
filterTemp.lla = out.NavFilterRes.lla.Data; %out.lla.Data;
MARGRes(idx).time = filterTemp.time;
MARGRes(idx).yawd = filterTemp.eulerd(:,1);
MARGRes(idx).pitchd = filterTemp.eulerd(:,2);
MARGRes(idx).rolld = filterTemp.eulerd(:,3);
MARGRes(idx).lat = filterTemp.lla(:,1);
MARGRes(idx).lon = filterTemp.lla(:,2);
MARGRes(idx).alt = filterTemp.lla(:,3);
MARGRes(idx).velN = filterTemp.vel(:,1);
MARGRes(idx).velE = filterTemp.vel(:,2);
MARGRes(idx).velD = filterTemp.vel(:,3);
MARGRes(idx).dABx = filterTemp.dvel(:,1)*1/Ts_imu;
MARGRes(idx).dABy = filterTemp.dvel(:,2)*1/Ts_imu;
MARGRes(idx).dABz = filterTemp.dvel(:,3)*1/Ts_imu;
MARGRes(idx).dGBx = filterTemp.dangle(:,1)*1/Ts_imu*180/pi;
MARGRes(idx).dGBy = filterTemp.dangle(:,2)*1/Ts_imu*180/pi;
MARGRes(idx).dGBz = filterTemp.dangle(:,3)*1/Ts_imu*180/pi;
MARGRes(idx).magNEDx = filterTemp.mag(:,1);
MARGRes(idx).magNEDy = filterTemp.mag(:,2);
MARGRes(idx).magNEDz = filterTemp.mag(:,3);
MARGRes(idx).dmagBx = filterTemp.dmag(:,1);
MARGRes(idx).dmagBy = filterTemp.dmag(:,2);
MARGRes(idx).dmagBz = filterTemp.dmag(:,3);
MARGRes(idx).posmNED = filterRes(idx).MARG.pos;

temp = MARGRes(idx).time(out.NavFilterRes.Status.initialAlignmentComplete.Data(1:end-1)==1);
if ~isempty(temp)
    t_alignment(idx) = temp(1);
else
    t_alignment(idx) = inf;
end