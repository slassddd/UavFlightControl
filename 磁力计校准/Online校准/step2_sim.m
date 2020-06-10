x1 = data.mag1B;
x2 = data.mag2B;
N = size(x1,1);
Ts = 0.012;
A0 = eye(3);
b0 = zeros(1,3);
magB0 = 10;
xSim1.time = [0:Ts:N*Ts-Ts];
xSim1.signals.values = x1;
xSim1.signals.dimensions = 3;
xSim2.time = [0:Ts:N*Ts-Ts];
xSim2.signals.values = x2;
xSim2.signals.dimensions = 3;
Tf = xSim1.time(end);
%%
mdlname = {'calibModel','RefModel_magCalib_memoryGood'}; % Top模型在第一位
for i = 1:length(mdlname)
%     load_system(mdlname{i});
%     open_system(mdlname{i});
    assignin('base','xSim1',xSim1)
    assignin('base','xSim2',xSim2)
    assignin('base','Ts',Ts)
    assignin('base','Tf',Tf)
%     mdlWks(i) = get_param(mdlname{i},'ModelWorkspace');
%     assignin(mdlWks(i),'xSim1',xSim1)
%     assignin(mdlWks(i),'xSim2',xSim2)
%     assignin(mdlWks(i),'Ts',Ts)
%     assignin(mdlWks(i),'Tf',Tf)
end
modeloutput =  sim(mdlname{1});
% save_system(mdlname{1},mdlname{1},'SaveDirtyReferencedModels','on');
% for i = length(mdlname):-1:1
%     close_system(mdlname{i});
% end