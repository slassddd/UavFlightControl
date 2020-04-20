
% dataFileName = ['磁力计标定数据_log_1_31117磁力计标定'];
% dataFileName = ['磁力计标定数据_log_2_v31117固件遥控器解除倾转限幅及模拟磁力计校准'];
% dataFileName = ['磁力计标定数据_log_3_43#第3架次-V31117固件悬停验收0331'];
% dataFileName = ['磁力计标定数据_log_1_2020年4月1日 香河 V1000-44#新飞机悬停验收飞行'];
% dataFileName = ['磁力计标定数据_log_20200413地面模拟磁力计校准'];
clear dataFileName
[dataFileName,PathName,~] = uigetfile('*.mat'); %
try
    if dataFileName == 0
        dataFileName = [];
    end
end
if isempty(dataFileName)
    return
end
data = load(dataFileName);