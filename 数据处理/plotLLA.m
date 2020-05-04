prePathPoint_LLA1(prePathPoint_LLA1==0) = [];
prePathPoint_LLA0(prePathPoint_LLA0==0) = [];
curPathPoint_LLA1(curPathPoint_LLA1==0) = [];
curPathPoint_LLA0(curPathPoint_LLA0==0) = [];
nMin = min([length(prePathPoint_LLA1),length(prePathPoint_LLA0),length(curPathPoint_LLA1),length(curPathPoint_LLA0)]);
prePathPoint_LLA1 = prePathPoint_LLA1(1:nMin);
prePathPoint_LLA0 = prePathPoint_LLA0(1:nMin);
curPathPoint_LLA1 = curPathPoint_LLA1(1:nMin);
curPathPoint_LLA0 = curPathPoint_LLA0(1:nMin);
tempPre1 = prePathPoint_LLA1;
tempPre0 = prePathPoint_LLA0;
tempCur1 = curPathPoint_LLA1;
tempCur0 = curPathPoint_LLA0;
% tempPre1 = diff(prePathPoint_LLA1);tempPre1(tempPre1==0)=[];
% tempPre0 = diff(prePathPoint_LLA0);tempPre0(tempPre0==0)=[];
% tempCur1 = diff(curPathPoint_LLA1);tempCur1(tempCur1==0)=[];
% tempCur0 = diff(curPathPoint_LLA0);tempCur0(tempCur0==0)=[];
figure;
% for i = 1:20:length(tempPre1)
%     plot(tempPre1(i),tempPre0(i),'ro');hold on;
%     plot(tempCur1(i),tempCur0(i),'b*');hold on;
%     plot(tempPre1(i),tempPre0(i),'r-');hold on;
%     plot(tempCur1(i),tempCur0(i),'b--');hold on;
%     xlabel(num2str(i))
%     drawnow
% end
plot(tempPre1,tempPre0,'ro');hold on;
plot(tempCur1,tempCur0,'b*');hold on;
% plot(tempPre1,tempPre0,'r-');hold on;
% plot(tempCur1,tempCur0,'b--');hold on;
grid on;
axis equal
legend('前置航点','当前航点')
if ~isempty(tempPre1)
    figure;plot(tempPre1);hold on;plot(tempPre0+tempPre1(1)-tempPre0(1));grid on;
end
turnCenterLL1_temp = turnCenterLL1;
turnCenterLL0_temp = turnCenterLL0;
curLLA1_temp = curLLA1;
curLLA0_temp = curLLA0;
if 1 % 画当前位置和盘旋中心
    homeLat = SL.OUT_TASKFLIGHTPARAM.curHomeLLA1;
    homeLon = SL.OUT_TASKFLIGHTPARAM.curHomeLLA0;
    homeLat(homeLat==0) = [];
    homeLon(homeLon==0) = [];
    nMin = min([length(turnCenterLL1_temp),length(turnCenterLL0_temp),length(curLLA1_temp),length(curLLA0_temp)]);
    turnCenterLL1_temp = turnCenterLL1_temp(1:nMin);
    turnCenterLL0_temp = turnCenterLL0_temp(1:nMin);
    curLLA1_temp = curLLA1_temp(1:nMin);
    curLLA0_temp = curLLA0_temp(1:nMin);
    turnCenterLL1_temp(turnCenterLL1_temp==0) = [];
    turnCenterLL0_temp(turnCenterLL0_temp==0) = [];
    curLLA1_temp(curLLA1_temp==0) = [];
    curLLA0_temp(curLLA0_temp==0) = [];
    tempPre1 = turnCenterLL1_temp;
    tempPre0 = turnCenterLL0_temp;
    tempCur1 = curLLA1_temp;
    tempCur0 = curLLA0_temp;
    if length(tempCur1)<length(tempCur0)
        tempCur0(end) = [];
    elseif length(tempCur1)>length(tempCur0)
        tempCur1(end) = [];
    end
    figure;
    subplot(121)
    plot(tempPre1,tempPre0,'ko');hold on;
    plot(tempCur1,tempCur0,'b');hold on;
    plot(homeLat,homeLon,'r*');hold on;
    grid on;
    axis equal
    subplot(222)
    plot(tempPre0,'r-');hold on;
    plot(tempCur0(1:2:end),'b--');hold on;
    grid on;
    subplot(224)
    plot(tempPre1,'r-');hold on;
    plot(tempCur1(1:2:end),'b--');hold on;
    grid on;
    legend('盘旋中心','实时位置')
end

if 0
    figure;
    plot(sensors.Algo_sl.algo_NAV_alt(1:4:end));hold on;
    plot(IN_SENSOR.radar1.Range(1:4:end));hold on;
    plot(SL.OUT_TASKFLIGHTPARAM.curLLA2);
    legend('滤波高','radar高','组合高')
end