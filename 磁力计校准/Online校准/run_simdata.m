clear,clc
tf = 100;
%% 生成测量数据
hardIronEffectEnable = 1;
softIronEffectEnable = 1;
% 理想测量
N = 500;
rng(1);
acc = zeros(N,3);
av = zeros(N,3);
q = randrot(N,1); % uniformly distributed random rotations
imu = imuSensor('accel-mag');
% hard iron effect
if hardIronEffectEnable
    imu.Magnetometer.ConstantBias = 0.01*[2 10 40];
end
% soft iron effect
if softIronEffectEnable
    nedmf = 1e-2*imu.MagneticField;
    Rsoft = [2.5 0.3 0.5; 0.3 2 .2; 0.5 0.2 3];
    soft = rotateframe(conj(q),rotateframe(q,nedmf)*Rsoft);
end
for ii=1:numel(q)
    if softIronEffectEnable
        imu.MagneticField = soft(ii,:);
    end
    [~,x(ii,:)] = imu(acc(ii,:),av(ii,:),q(ii));
end
figure;
scatter3(x(:,1),x(:,2),x(:,3));
axis equal
figure(12);
subplot(121)
scatter3(x(:,1),x(:,2),x(:,3));hold on;
subplot(122)
scatter3(x(:,1),x(:,2),x(:,3));hold on;
xlabel('x')
ylabel('y')
zlabel('z')
axis equal
%% 进行标定
Ts = 0.001;
A0 = eye(3);
b0 = zeros(1,3);
magB0 = 10;
xSim1.time = [0:Ts:N*Ts-Ts];
xSim1.signals.values = x;
xSim1.signals.dimensions = 3;
xSim2.time = [0:Ts:N*Ts-Ts];
xSim2.signals.values = x;
xSim2.signals.dimensions = 3;
modeloutput =  sim('calibModel');
% %% 显示
%% 显示
A{1} = modeloutput.simout1_A.Data(:,:,end);
b{1} = modeloutput.simout1_b.Data(:,:,end);
k{1} = modeloutput.simout1_magB.Data(end);
res1_xCorrect = k{1}*(x-b{1})*A{1};
A{2} = modeloutput.simout2_A.Data(:,:,end);
b{2} = modeloutput.simout2_b.Data(:,:,end);
k{2} = modeloutput.simout2_magB.Data(end);
res2_xCorrect = k{2}*(x-b{2})*A{2};
% 写txt
dataFileName = 'MagCalibSim';
for i = 1:2
    [~,tempName] = fileparts(dataFileName);
    fileID = fopen(['res_',tempName,'_mag',num2str(i),'.txt'],'w');
    fprintf(fileID,'矫正公式: x_correct = k*(x-b)*A\n');
    fprintf(fileID,'a11: %.3f\n',A{i}(1,1));
    fprintf(fileID,'a12: %.3f\n',A{i}(1,2));
    fprintf(fileID,'a13: %.3f\n',A{i}(1,3));
    fprintf(fileID,'a22: %.3f\n',A{i}(2,2));
    fprintf(fileID,'a23: %.3f\n',A{i}(2,3));
    fprintf(fileID,'a33: %.3f\n',A{i}(3,3));
    fprintf(fileID,'b11: %.3f\n',b{i}(1));
    fprintf(fileID,'b21: %.3f\n',b{i}(2));
    fprintf(fileID,'b31: %.3f\n',b{i}(3));
    fprintf(fileID,'k: %.3f\n',k{i});
    fclose(fileID);   
end
save(['CalibParam_',dataFileName],'A','b','k');
% 绘图
figure(12);
subplot(121)
scatter3(res1_xCorrect(:,1),res1_xCorrect(:,2),res1_xCorrect(:,3),'r*');
axis equal
subplot(122)
scatter3(res2_xCorrect(:,1),res2_xCorrect(:,2),res2_xCorrect(:,3),'r*');
axis equal
% res_A = modeloutput.simout_A.Data(:,:,end);
% res_b = modeloutput.simout_b.Data(:,:,end);
% res_mgB = modeloutput.simout_magB.Data(end);
% res_xCorrect = (x-res_b)*res_A;
% % res_xCorrect = permute(modeloutput.simout_xCorrect.Data,[3,2,1]);
% de = HelperDrawEllipsoid;
% de.plotCalibrated(res_A,res_b,res_mgB,x,res_xCorrect,'best');