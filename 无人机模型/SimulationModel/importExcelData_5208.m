%% ������ӱ���е�����
% ���ڴ����µ��ӱ�������ݵĽű�:
%
%    ������: G:\PROJECT_FEIMA\��ϵ���\V1000_firmware\���˻�ģ��\V1000Dynamics\5208�����2814���������������Ӧ��.xls
%    ������: 5208��1758��21.6V��ӯ���
%
% �� MATLAB �� 2020-01-11 20:56:05 �Զ�����

%% ���õ���ѡ���������
opts = spreadsheetImportOptions("NumVariables", 18);

% ָ��������ͷ�Χ
opts.Sheet = "5208��1758��21.6V��ӯ���";
opts.DataRange = "A3:R478";

% ָ�������ƺ�����
opts.VariableNames = ["num", "sampleTime", "throttle", "PWM_transfer", "volatage", "electricity", "rev", "torque", "inflowVel", "pull", "powerInPower", "powerOutPower", "rotorPower", "rotorEfficient", "VarName15", "VarName16", "VarName17", "VarName18"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% ��������
tbl = readtable("G:\PROJECT_FEIMA\��ϵ���\V1000_firmware\���˻�ģ��\V1000Dynamics\5208���������������Ӧ��.xls", opts, "UseExcel", false);

%% ת��Ϊ�������
num = tbl.num;
sampleTime = tbl.sampleTime;
throttle = tbl.throttle;
PWM_transfer = tbl.PWM_transfer;
volatage = tbl.volatage;
electricity = tbl.electricity;
rev = tbl.rev;
torque = tbl.torque;
inflowVel = tbl.inflowVel;
pull = tbl.pull;
powerInPower = tbl.powerInPower;
powerOutPower = tbl.powerOutPower;
rotorPower = tbl.rotorPower;
rotorEfficient = tbl.rotorEfficient;
VarName15 = tbl.VarName15;
VarName16 = tbl.VarName16;
VarName17 = tbl.VarName17;
VarName18 = tbl.VarName18;

%% �����ʱ����
clear opts tbl

%% ���ݴ�����throttle��������
[~,idx_throttle] = sort(throttle);
[~,idx_rev] = sort(rev);
[~,idx_pwm] = sort(PWM_transfer);
rev_rev = rev(idx_rev);
pull_rev = pull(idx_rev);
torque_rev = torque(idx_rev);

pwm_pwm = PWM_transfer(idx_pwm);
pull_pwm = pull(idx_pwm);
torque_pwm = torque(idx_pwm);
%% ��ͼ
figure(21);
subplot(311)
plot(rev_rev,pull_rev,'b');hold on;
grid on;
xlabel('rev')
ylabel('����');
subplot(312)
plot(rev_rev,torque_rev,'b');hold on;
grid on;
xlabel('rev')
ylabel('����');
subplot(313)
plot(rev_rev(torque_rev~=0),pull_rev(torque_rev~=0)./torque_rev(torque_rev~=0),'b');hold on;
grid on;
xlabel('rev')
ylabel('��/����');
%% ��/�������
% revΪ����
pull5208_poly = polyfit(rev_rev,pull_rev,2);
torque5208_poly = polyfit(rev_rev,torque_rev,2);
pullvalue_poly = polyval(pull5208_poly,rev_rev);
torquevalue_poly = polyval(torque5208_poly,rev_rev);
figure;
subplot(121)
plot(rev_rev,pull_rev,'r');hold on;
plot(rev_rev,pullvalue_poly,'k--');hold on;
xlabel('rev');
ylabel('����');
subplot(122)
plot(rev_rev,torque_rev,'r');hold on;
plot(rev_rev,torquevalue_poly,'k--');hold on;
xlabel('rev');
ylabel('����');
% PWMΪ����
pull5208_pwm_poly = polyfit(pwm_pwm,pull_pwm,2);
torque5208_pwm_poly = polyfit(pwm_pwm,torque_pwm,2);
pullvalue_pwm_poly = polyval(pull5208_pwm_poly,pwm_pwm);
torquevalue_pwm_poly = polyval(torque5208_pwm_poly,pwm_pwm);
figure;
subplot(121)
plot(pwm_pwm,pull_pwm,'r');hold on;
plot(pwm_pwm,pullvalue_pwm_poly,'k--');hold on;
xlabel('pwm');
ylabel('����');
subplot(122)
plot(pwm_pwm,torque_pwm,'r');hold on;
plot(pwm_pwm,torquevalue_pwm_poly,'k--');hold on;
xlabel('pwm');
ylabel('����');