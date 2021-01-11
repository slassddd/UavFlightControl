%% 注意，当前磁力计标定固件的数据解析需要用 V1000_to_mat_256
clear,clc
%% 载入数据
step1_loaddata
%% 离线计算
step2_sim
%% 显示
step3_savedata
%% 绘图
step4_plot
