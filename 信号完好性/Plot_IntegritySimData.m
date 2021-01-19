function Plot_IntegritySimData(SimRes,SimDataSet,TestCase,varargin)
global GLOBAL_PARAM
idxSel = [];
if length(varargin) == 1
    idxSel = varargin{1}; % 选择进行指定数据的绘制  [2,3]
end
% 仿真数据绘制
nSim = SimDataSet.nFlightDataFile;
fprintf('[%s] 仿真曲线\n',mfilename);
%
if isempty(idxSel)
    fprintf('%s绘制全部数据（%d）\n',GLOBAL_PARAM.Print.lineHead,nSim);
    idxToPlot = 1:nSim;
else
    fprintf('%s绘制指定数据',GLOBAL_PARAM.Print.lineHead);
    for i = 1:length(idxSel)
        fprintf(' %d ',idxSel(i));
    end
    fprintf('\n');
    idxToPlot = idxSel;
end
for i_sim = idxToPlot
    thisSimRes = SimRes(i_sim);
    thisName = TestCase(i_sim).casename;    
    fprintf('%s%s数据%d %s\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead,i_sim,thisName);
    % IMU
    nSensor = 3;
    data.time = thisSimRes.SensorStatus.IMU1.Time;
    data.status = [...
        thisSimRes.SensorStatus.IMU1.Data,...
        thisSimRes.SensorStatus.IMU2.Data,...
        thisSimRes.SensorStatus.IMU3.Data];
    data.select = thisSimRes.SensorSelect.IMU.Data;
    data.lostTime = [...
        thisSimRes.SensorLostTime.IMU1.Data,...
        thisSimRes.SensorLostTime.IMU2.Data,...
        thisSimRes.SensorLostTime.IMU3.Data];
    figure('Name',[thisName,': SensorFault [IMU]']);
    subplot(3,nSensor,1)
    plotEnum(data.time,data.status(:,1));hold on;grid on;
    ylabel('IMU1 status');
    subplot(3,nSensor,2)
    plotEnum(data.time,data.status(:,2));hold on;grid on;
    ylabel('IMU2 status');
    subplot(3,nSensor,3)
    plotEnum(data.time,data.status(:,3));hold on;grid on;
    ylabel('IMU3 status');
    subplot(3,nSensor,4)
    plotEnum(data.time,data.lostTime(:,1));hold on;grid on;
    ylabel('IMU1 lostTime');
    subplot(3,nSensor,5)
    plotEnum(data.time,data.lostTime(:,2));hold on;grid on;
    ylabel('IMU2 lostTime');
    subplot(3,nSensor,6)
    plotEnum(data.time,data.lostTime(:,3));hold on;grid on;
    ylabel('IMU3 lostTime');
    subplot(3,nSensor,7)
    plotEnum(data.time,data.select);hold on;grid on;
    ylabel('IMU Select');
    % 磁力计
    nSensor = 2;
    data.time = thisSimRes.SensorStatus.mag1.Time;
    data.status = [...
        thisSimRes.SensorStatus.mag1.Data,...
        thisSimRes.SensorStatus.mag2.Data];
    data.select = thisSimRes.SensorSelect.Mag.Data;
    data.lostTime = [...
        thisSimRes.SensorLostTime.mag1.Data,...
        thisSimRes.SensorLostTime.mag2.Data];
    figure('Name',[thisName,': SensorFault [mag]']);
    subplot(3,nSensor,1)
    plotEnum(data.time,data.status(:,1));hold on;grid on;
    ylabel('mag1 status');
    subplot(3,nSensor,2)
    plotEnum(data.time,data.status(:,2));hold on;grid on;
    ylabel('mag2 status');
    subplot(3,nSensor,3)
    plotEnum(data.time,data.lostTime(:,1));hold on;grid on;
    ylabel('mag1 lostTime');
    subplot(3,nSensor,4)
    plotEnum(data.time,data.lostTime(:,2));hold on;grid on;
    ylabel('mag2 lostTime');
    subplot(3,nSensor,5)
    plotEnum(data.time,data.select);hold on;grid on;
    ylabel('mag Select');   
    % 气压计
    nSensor = 2;
    data.time = thisSimRes.SensorStatus.baro1.Time;
    data.status = [...
        thisSimRes.SensorStatus.baro1.Data,...
        thisSimRes.SensorStatus.baro2.Data];
    data.select = thisSimRes.SensorSelect.Baro.Data;
    data.lostTime = [...
        thisSimRes.SensorLostTime.baro1.Data,...
        thisSimRes.SensorLostTime.baro2.Data];
    figure('Name',[thisName,': SensorFault [baro]']);
    subplot(3,nSensor,1)
    plotEnum(data.time,data.status(:,1));hold on;grid on;
    ylabel('baro1 status');
    subplot(3,nSensor,2)
    plotEnum(data.time,data.status(:,2));hold on;grid on;
    ylabel('baro2 status');
    subplot(3,nSensor,3)
    plotEnum(data.time,data.lostTime(:,1));hold on;grid on;
    ylabel('baro1 lostTime');
    subplot(3,nSensor,4)
    plotEnum(data.time,data.lostTime(:,2));hold on;grid on;
    ylabel('baro2 lostTime');
    subplot(3,nSensor,5)
    plotEnum(data.time,data.select);hold on;grid on;
    ylabel('baro Select');    
    % 空速计
    nSensor = 3;
    data.time = thisSimRes.SensorStatus.airspeed1.Time;
    data.status = [...
        thisSimRes.SensorStatus.airspeed1.Data,...
        thisSimRes.SensorStatus.airspeed2.Data,...
        thisSimRes.SensorStatus.airspeed3.Data];
    data.select = thisSimRes.SensorSelect.Airspeed.Data;
    data.lostTime = [...
        thisSimRes.SensorLostTime.airspeed1.Data,...
        thisSimRes.SensorLostTime.airspeed2.Data,...
        thisSimRes.SensorLostTime.airspeed3.Data];
    figure('Name',[thisName,': SensorFault [airspeed]']);
    subplot(3,nSensor,1)
    plotEnum(data.time,data.status(:,1));hold on;grid on;
    ylabel('airspeed1 status');
    subplot(3,nSensor,2)
    plotEnum(data.time,data.status(:,2));hold on;grid on;
    ylabel('airspeed2 status');
    subplot(3,nSensor,3)
    plotEnum(data.time,data.status(:,3));hold on;grid on;
    ylabel('airspeed3 status');
    subplot(3,nSensor,4)
    plotEnum(data.time,data.lostTime(:,1));hold on;grid on;
    ylabel('airspeed1 lostTime');
    subplot(3,nSensor,5)
    plotEnum(data.time,data.lostTime(:,2));hold on;grid on;
    ylabel('airspeed2 lostTime');
    subplot(3,nSensor,6)
    plotEnum(data.time,data.lostTime(:,3));hold on;grid on;
    ylabel('airspeed3 lostTime');
    subplot(3,nSensor,7)
    plotEnum(data.time,data.select);hold on;grid on;
    ylabel('airspeed Select');    
    % 雷达/激光高度计
    nSensor = 3;
    data.time = thisSimRes.SensorStatus.radar1.Time;
    data.status = [...
        thisSimRes.SensorStatus.radar1.Data,...
        thisSimRes.SensorStatus.radar2.Data,...
        thisSimRes.SensorStatus.radar3.Data];
    data.select = thisSimRes.SensorSelect.Radar.Data;
    data.lostTime = [...
        thisSimRes.SensorLostTime.radar1.Data,...
        thisSimRes.SensorLostTime.radar2.Data,...
        thisSimRes.SensorLostTime.radar3.Data];
    figure('Name',[thisName,': SensorFault [radar]']);
    subplot(3,nSensor,1)
    plotEnum(data.time,data.status(:,1));hold on;grid on;
    ylabel('radar1 status');
    subplot(3,nSensor,2)
    plotEnum(data.time,data.status(:,2));hold on;grid on;
    ylabel('radar2 status');
    subplot(3,nSensor,3)
    plotEnum(data.time,data.status(:,3));hold on;grid on;
    ylabel('radar3 status');
    subplot(3,nSensor,4)
    plotEnum(data.time,data.lostTime(:,1));hold on;grid on;
    ylabel('radar1 lostTime');
    subplot(3,nSensor,5)
    plotEnum(data.time,data.lostTime(:,2));hold on;grid on;
    ylabel('radar2 lostTime');
    subplot(3,nSensor,6)
    plotEnum(data.time,data.lostTime(:,3));hold on;grid on;
    ylabel('radar3 lostTime');
    subplot(3,nSensor,7)
    plotEnum(data.time,data.select);hold on;grid on;
    ylabel('radar Select');      
end