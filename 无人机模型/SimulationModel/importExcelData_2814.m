%% ������ӱ���е�����
% ���ڴ����µ��ӱ�������ݵĽű�:
%
%    ������: G:\PROJECT_FEIMA\��ϵ���\V1000_firmware\���˻�ģ��\V1000Dynamics\2814���������������Ӧ��.xls
%    ������: 2814��10X7��21.6V��ӯ���
%
% �� MATLAB �� 2020-01-11 21:15:50 �Զ�����

%% ���õ���ѡ���������
opts = spreadsheetImportOptions("NumVariables", 18);

% ָ��������ͷ�Χ
opts.Sheet = "2814��10X7��21.6V��ӯ���";
opts.DataRange = "A3:R467";

% ָ�������ƺ�����
opts.VariableNames = ["num1", "sampleTime1", "throttle1", "PWM_transfer1", "volatage1", "electricity1", "rev1", "torque1", "inflowVel1", "pull1", "powerInPower1", "powerOutPower1", "rotorPower1", "rotorEfficient1", "VarName1", "VarName2", "VarName3", "VarName4"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% ��������
tbl = readtable("2814���������������Ӧ��.xls", opts, "UseExcel", false);

%% ת��Ϊ�������
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
plot(rev_rev,pull_rev,'r');hold on;
grid on;
xlabel('rev')
ylabel('����');
subplot(312)
plot(rev_rev,torque_rev,'r');hold on;
grid on;
xlabel('rev')
ylabel('����');
subplot(313)
plot(rev_rev(torque_rev~=0),pull_rev(torque_rev~=0)./torque_rev(torque_rev~=0),'r');hold on;
grid on;
xlabel('rev')
%% ��/�������
% revΪ����
pull2814_poly = polyfit(rev_rev,pull_rev,2);
torque2814_poly = polyfit(rev_rev,torque_rev,2);
pullvalue_poly = polyval(pull2814_poly,rev_rev);
torquevalue_poly = polyval(torque2814_poly,rev_rev);
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
pull2814_pwm_poly = polyfit(pwm_pwm,pull_pwm,2);
torque2814_pwm_poly = polyfit(pwm_pwm,torque_pwm,2);
pullvalue_pwm_poly = polyval(pull2814_pwm_poly,pwm_pwm);
torquevalue_pwm_poly = polyval(torque2814_pwm_poly,pwm_pwm);
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