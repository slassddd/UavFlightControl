speed_fix = 20;

power_hoverup = 1/(115/4); % 每秒耗电%
power_path = 1/(115);

du_hoverup = 1400/3; % 时长
cost_hoverup = du_hoverup * power_hoverup;

cost_all = 65;
cost_path = cost_all - cost_hoverup;
du_path = cost_path/power_path;
du_takeOfToHoverup = 30; 

du_hoverdown = 1400/2;
du_gohome = 2000/speed_fix;
du_land = 30;

du_all = du_takeOfToHoverup + du_hoverup + du_path + du_gohome + du_hoverdown + du_land;
fprintf('总留空时间: %.0f [sec]\n',du_all);