SimulinkRunMode = 1;
% [ALGO_SET,sensorFs] = step2_setALGOparam_flightData();
%% �����ʳ�ʼ��
Ts_Control.Ts_base = 0.012;
INIT_Control
%% ���ģ��
Ts_Architechure.Ts_base = 0.012;
%% ����ģ���ʼ��
% INIT_CONTROL
%% ��ϵ�����ʼ��
INIT_Navi
%% 
INIT_UAV
%% �����ʼ��
INIT_TASK
% �򻯵��˶�ģ��
INIT_SIMPLEUAVMOTION
%% ����վָ��
INIT_GROUNDSTATION
%% ���������ϲ���
INIT_SensorFault
%% ��������װ����
INIT_SensorAlignment
%% �źż��
INIT_SensorIntegrity
%% ���з���
modelname = 'model_navfilter';
% nSim = 1;
% SIM_FLIGHTDATA_IN(nSim) = Simulink.SimulationInput(modelname);
% for i = 1:nSim    
%     SIM_FLIGHTDATA_IN(i) = Simulink.SimulationInput(modelname);
% %     SIM_FLIGHTDATA_IN(i) = SIM_FLIGHTDATA_IN(i).setVariable('ALGO_SET.noise_std.std_mag',i*ALGO_SET.noise_std.std_mag);    
% end
% out = parsim(SIM_FLIGHTDATA_IN,'RunInBackground','on',...
%                                'TransferBaseWorkspaceVariables','on');                        
out = sim(modelname);
%% ���ݺ���
[navFilterMARGRes,t_alignment] = PostDataHandle_SimulinkModel(out,sensorFs);