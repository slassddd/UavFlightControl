function [turnPoint,turnPointLL,useTurnPoint] = calPreTurnPointLL(P0_in,P1_in,curP_in,R)
% P0_in: 航线进入点的纬度、经度
% P1_in: 航线结束点的纬度、经度
% curP_in: 当前点的纬度、经度
% R: 转弯半径
LL0 = [reshape(P0_in,[1,2]),0];
LL1 = [reshape(P1_in,[1,2]),0];
curLL = [reshape(curP_in,[1,2]),0];
pos0 = lla2ned(LL0,LL0(1:2));
pos1 = lla2ned(LL1,LL0(1:2));
curPos = lla2ned(curLL,LL0(1:2));
%
heading_tmp = atan2(pos0(2)-curLL(2),pos0(1)-curLL(1));
heading = atan2(pos1(2)-pos0(2),pos1(1)-pos0(1));
if abs(angdiff(heading,heading_tmp))*180/pi < 30 % 进入角度平缓
    useTurnPoint = false;
    turnPoint = [0,0];
    turnPointLL = [LL0(1:2),0]+[eps,eps,eps];
    return;
else
    useTurnPoint = true;
end
% 计算圆心和切点
[dLat1,dLon1,dPx1,dPy1] = calDLatLonOfRotateCenterFromCurPos(LL0,heading,R,'left');
[dLat2,dLon2,dPx2,dPy2] = calDLatLonOfRotateCenterFromCurPos(LL0,heading,R,'right');
centerPos1 = pos0(1:2) + [dPx1,dPy1];
centerPos2 = pos0(1:2) + [dPx2,dPy2];
[post1_a,post1_b] = findTangencyPointsNED(centerPos1(1),centerPos1(2),curPos(1),curPos(2),R);
[post2_a,post2_b] = findTangencyPointsNED(centerPos2(1),centerPos2(2),curPos(1),curPos(2),R);
% 计算直线方程`
if 0
    [k1_a,b1_a] = calLineEqu(curPos(1),curPos(2),post1_a(1),post1_a(2));
    [k1_b,b1_b] = calLineEqu(curPos(1),curPos(2),post1_b(1),post1_b(2));
    [k2_a,b2_a] = calLineEqu(curPos(1),curPos(2),post2_a(1),post2_a(2));
    [k2_b,b2_b] = calLineEqu(curPos(1),curPos(2),post2_b(1),post2_b(2));
end
% 计算直线交点
% pos = calLineCrossPoint(k1_a,b1_a,k2,b2);
% 确定切点
flag1_a = isTurnPointValid(curPos(1:2),post1_a,pos0(1:2),pos1(1:2));
flag2_a = isTurnPointValid(curPos(1:2),post2_a,pos0(1:2),pos1(1:2));
flag1_b = isTurnPointValid(curPos(1:2),post1_b,pos0(1:2),pos1(1:2));
flag2_b = isTurnPointValid(curPos(1:2),post2_b,pos0(1:2),pos1(1:2));
dist1_a = norm(curPos(1:2)-post1_a);
dist1_b = norm(curPos(1:2)-post1_b);
dist2_a = norm(curPos(1:2)-post2_a);
dist2_b = norm(curPos(1:2)-post2_b);
if dist1_a <= dist2_a
    if flag1_a == 1
        turnPoint = post1_a;
    else
        turnPoint = post1_b;
    end
else
    if flag2_a == 1
        turnPoint = post2_a;
    else
        turnPoint = post2_b;
    end
end
k = 1/111e3;
turnPointLL = LL0 + k*[turnPoint(1),turnPoint(2)/cos(LL0(1)*pi/180),0];
%% 画图分析
% test = 1;
% if test
%     figure(123);
%     plot(pos0(1),pos0(2),'ko');hold on;
%     plot(pos1(1),pos1(2),'k*');hold on;
%     plot(curPos(1),curPos(2),'ro');hold on;
%     % 圆心
%     plot(centerPos1(1),centerPos1(2),'y+');hold on;
%     plot(centerPos2(1),centerPos2(2),'c+');hold on;
%     % 切点
%     plot(post1_a(1),post1_a(2),'b*');hold on;text(post1_a(1),post1_a(2),'1_a');
%     plot(post1_b(1),post1_b(2),'b*');hold on;text(post1_b(1),post1_b(2),'1_b');
%     plot(post2_a(1),post2_a(2),'bo');hold on;text(post2_a(1),post2_a(2),'2_a');
%     plot(post2_b(1),post2_b(2),'bo');hold on;text(post2_b(1),post2_b(2),'2_b');
%     % 切点连线
%     tmp = post1_a(1);tmpk = k1_a;tmpb = b1_a;
%     tempx = [curPos(1):sign(tmp-curPos(1)):tmp];
%     tempy = tmpk*tempx+tmpb;
%     plot(tempx,tempy,'b');hold on;
%     tmp = post1_b(1);tmpk = k1_b;tmpb = b1_b;
%     tempx = [curPos(1):sign(tmp-curPos(1)):tmp];
%     tempy = tmpk*tempx+tmpb;
%     plot(tempx,tempy,'b');hold on;
%     tmp = post2_a(1);tmpk = k2_a;tmpb = b2_a;
%     tempx = [curPos(1):sign(tmp-curPos(1)):tmp];
%     tempy = tmpk*tempx+tmpb;
%     plot(tempx,tempy,'b');hold on;
%     tmp = post2_b(1);tmpk = k2_b;tmpb = b2_b;
%     tempx = [curPos(1):sign(tmp-curPos(1)):tmp];
%     tempy = tmpk*tempx+tmpb;
%     plot(tempx,tempy,'b');hold on;
%     % 候选航线
%     plot([curPos(1),turnPoint(1),pos0(1),pos1(1)],[curPos(2),turnPoint(2),pos0(2),pos1(2)],'r');hold on;
%     %
%     grid on;
%     axis equal
%     legend('P0','P1','curP','C1','C2','T1_a','T1_b','T2_a','T2_b')
% end
%% ----------------------------------------------------------------
% 确定有效切点
function flag = isTurnPointValid(poscur,post,pos0,pos1)
vec0 = -poscur+post;
vec1 = -post+pos0;
vec2 = -pos0+pos1;
vec0 = [vec0,0];
vec1 = [vec1,0];
vec2 = [vec2,0];
angle1 = cross(vec2,vec1)/norm(vec1)/norm(vec2);
angle2 = cross(vec1,vec0)/norm(vec0)/norm(vec1);
if angle1(3)*angle2(3) <= 0
    flag = false;
else
    flag = true;
end
% 计算两直线交点
function pos = calLineCrossPoint(k1,b1,k2,b2)
temp = k1 - k2;
if abs(temp) < 0.1
    temp = 0.1;
end
x = -(b1 - b2)/temp;
y = -(b1*k2 - b2*k1)/temp;
pos = [x,y];
% 计算直线方程
function [k,b] = calLineEqu(x1,y1,x2,y2)
tmp = x1-x2;
if abs(tmp) < 0.5
    tmp = 0.5;
end
k = (y1 - y2)/tmp;
b = (x1*y2 - x2*y1)/tmp;


% %%
% syms k1 k2 b1 b2 x1 x2 y1 y2 k b x y
% % x = sym('x','real');
% % y = sym('y','real');
% % Cx = sym('Cx','real');
% % Cy = sym('Cy','real');
% % Px = sym('Px','real');
% % Py = sym('Py','real');
% % R = sym('R','real');
% f1 = k*x1+b-y1;
% f2 = k*x2+b-y2;
% ss = solve([f1;f2],[k,b]);
% % ss.k,ss.b
% f3 = k1*x+b1-y;
% f4 = k2*x+b2-y;
% ss1 = solve([f3;f4],[x,y]);
% ss1.x,ss1.y
%
% % fsym = x^2+(k*x+b)^2-R^2

