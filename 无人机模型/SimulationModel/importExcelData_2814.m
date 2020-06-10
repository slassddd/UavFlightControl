%% 导入电子表格中的数据
% 用于从以下电子表格导入数据的脚本:
%
%    工作簿: G:\PROJECT_FEIMA\组合导航\V1000_firmware\无人机模型\V1000Dynamics\2814电机油门与拉力对应表.xls
%    工作表: 2814配10X7桨21.6V好盈电调
%
% 由 MATLAB 于 2020-01-11 21:15:50 自动生成

%% 设置导入选项并导入数据
opts = spreadsheetImportOptions("NumVariables", 18);

% 指定工作表和范围
opts.Sheet = "2814配10X7桨21.6V好盈电调";
opts.DataRange = "A3:R467";

% 指定列名称和类型
opts.VariableNames = ["num1", "sampleTime1", "throttle1", "PWM_transfer1", "volatage1", "electricity1", "rev1", "torque1", "inflowVel1", "pull1", "powerInPower1", "powerOutPower1", "rotorPower1", "rotorEfficient1", "VarName1", "VarName2", "VarName3", "VarName4"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% 导入数据
tbl = readtable("2814电机油门与拉力对应表.xls", opts, "UseExcel", false);

%% 转换为输出类型
num = tbl.num1;
sampleTime = tbl.sampleTime1;
throttle = tbl.throttle1;
PWM_transfer = tbl.PWM_transfer1;
volatage = tbl.volatage1;
electricity = tbl.electricity1;
rev = tbl.rev1;
torque = tbl.torque1;
inflowVel = tbl.inflowVel1;
pull = tbl.pull1;
powerInPower = tbl.powerInPower1;
powerOutPower = tbl.powerOutPower1;
rotorPower = tbl.rotorPower1;
rotorEfficient = tbl.rotorEfficient1;
VarName1 = tbl.VarName1;
VarName2 = tbl.VarName2;
VarName3 = tbl.VarName3;
VarName4 = tbl.VarName4;

%% 清除临时变量
clear opts tbl
%% 数据处理，按throttle升序排列
[~,idx_throttle] = sort(throttle);
[~,idx_rev] = sort(rev);
[~,idx_pwm] = sort(PWM_transfer);
rev_rev = rev(idx_rev);
pull_rev = pull(idx_rev);
torque_rev = torque(idx_rev);

pwm_pwm = PWM_transfer(idx_pwm);
pull_pwm = pull(idx_pwm);
torque_pwm = torque(idx_pwm);
%% 绘图
figure(21);
subplot(311)
plot(rev_rev,pull_rev,'r');hold on;
grid on;
xlabel('rev')
ylabel('拉力');
subplot(312)
plot(rev_rev,torque_rev,'r');hold on;
grid on;
xlabel('rev')
ylabel('力矩');
subplot(313)
plot(rev_rev(torque_rev~=0),pull_rev(torque_rev~=0)./torque_rev(torque_rev~=0),'r');hold on;
grid on;
xlabel('rev')
%% 力/力矩拟合
% rev为参数
pull2814_poly = polyfit(rev_rev,pull_rev,2);
torque2814_poly = polyfit(rev_rev,torque_rev,2);
pullvalue_poly = polyval(pull2814_poly,rev_rev);
torquevalue_poly = polyval(torque2814_poly,rev_rev);
figure;
subplot(121)
plot(rev_rev,pull_rev,'r');hold on;
plot(rev_rev,pullvalue_poly,'k--');hold on;
xlabel('rev');
ylabel('拉力');
subplot(122)
plot(rev_rev,torque_rev,'r');hold on;
plot(rev_rev,torquevalue_poly,'k--');hold on;
xlabel('rev');
ylabel('力矩');
% PWM为参数
pull2814_pwm_poly = polyfit(pwm_pwm,pull_pwm,2);
torque2814_pwm_poly = polyfit(pwm_pwm,torque_pwm,2);
pullvalue_pwm_poly = polyval(pull2814_pwm_poly,pwm_pwm);
torquevalue_pwm_poly = polyval(torque2814_pwm_poly,pwm_pwm);
figure;
subplot(121)
plot(pwm_pwm,pull_pwm,'r');hold on;
plot(pwm_pwm,pullvalue_pwm_poly,'k--');hold on;
xlabel('pwm');
ylabel('拉力');
subplot(122)
plot(pwm_pwm,torque_pwm,'r');hold on;
plot(pwm_pwm,torquevalue_pwm_poly,'k--');hold on;
xlabel('pwm');
ylabel('力矩');