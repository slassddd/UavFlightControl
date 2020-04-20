% 计算圆切点
function [tangencyLL1,tangencyLL2] = findTangencyPointsLLA(centerLL,curLL,R)
% centerLL：圆心,【lat,lon】
% curLL：圆外一点,【lat,lon】
% tangencyLL1：绕飞切入点，顺时针进入盘旋
% tangencyLL2：绕飞切入点，逆时针进入盘旋
LL0 = centerLL; 
centerPos = [0,0];
curPos = lla2ned([curLL,0],LL0(1:2));
if norm(curPos)<=R
    tangencyLL1 = centerLL;
    tangencyLL2 = centerLL;
    fprintf('Function:findTangencyPointsLLA, distance less than R!\n');
    return;
end
[post1_a,post1_b] = findTangencyPointsNED(centerPos(1),centerPos(2),curPos(1),curPos(2),R);
vec1 = curPos - [post1_a,0];
vec2 = [post1_a,0] - [centerPos,0];
k = 1/111e3;
if cross(vec1,vec2)>=0
    idxsel = 1;
    tangencyLL1 = LL0 + k*[post1_a(1),post1_a(2)/cos(LL0(1)*pi/180)];
    tangencyLL2 = LL0 + k*[post1_b(1),post1_b(2)/cos(LL0(1)*pi/180)];
else
    idxsel = 2;
    tangencyLL2 = LL0 + k*[post1_a(1),post1_a(2)/cos(LL0(1)*pi/180)];
    tangencyLL1 = LL0 + k*[post1_b(1),post1_b(2)/cos(LL0(1)*pi/180)];    
end

%% test
% figure(111);
% plot(centerLL(2),centerLL(1),'r*');hold on
% plot(curLL(2),curLL(1),'ro');hold on
% plot(tangencyLL1(2),tangencyLL1(1),'bo');hold on
% plot(tangencyLL2(2),tangencyLL2(1),'bo');hold on
% text(tangencyLL1(2),tangencyLL1(1),'右转绕飞');hold on
% text(tangencyLL2(2),tangencyLL2(1),'左转绕飞');hold on
% tt = 0:pi/180:2*pi;
% posCircle = R*[cos(tt)',sin(tt)'];
% k = 1/111e3;
% llCircle = centerLL + k*[posCircle(:,1),posCircle(:,2)/cos(centerLL(1)*pi/180)];
% plot(llCircle(:,2),llCircle(:,1),'k');hold on;
% grid on;
% xlabel('lon(deg)')
% xlabel('lat(deg)')