function plotOpt = setPlotOpt()
plotOpt.color = {'k','r','b','g','y','c',...
    [0 0.4470 0.7410], [0.8500 0.3250 0.0980], [0.9290 0.6940 0.1250], [0.4940 0.1840 0.5560],...
    [0.4660 0.6740 0.1880], [0.3010 0.7450 0.9330],[0.6350 0.0780 0.1840]};
plotOpt.linewidth = 0.7;
plotOpt.linestyle = {'--','-','-.',':'};
plotOpt.hold = 'on'; % 'on'  'off'
plotOpt.grid = 'on'; % 'on'  'off'
plotOpt.xlabel = {'time [s]'};
plotOpt.ylabel_eulerd = {'yaw [deg]','pitch [deg]','roll [deg]'};
plotOpt.ylabel_omegad = {'wx [deg/s]','wy [deg/s]','wz [deg/s]'};
plotOpt.ylabel_AB_ms2 = {'ABx [m/s^2]','ABy [m/s^2]','ABz [m/s^2]'};
plotOpt.ylabel_posm = {'Pn [m]','Pe [m]','Pd [m]'};
plotOpt.ylabel_lla = {'lat [deg]','lon [deg]','height [m]'};
plotOpt.ylabel_velm = {'Vn [m]','Ve [m]','Vd [m]'};
plotOpt.ylabel_dAB_ms2 = {'dABx [m/s^2]','dABy [m/s^2]','dABz [m/s^2]'};
plotOpt.ylabel_dWB_degs = {'dWBx [deg/s]','dWBy [deg/s]','dWBz [deg/s]'};
plotOpt.ylabel_magB_Gs = {'magBx [uT]','magBy [uT]','magBz [Gs]'};
plotOpt.ylabel_dMagB_Gs = {'dMagB [uT]','dMagB [uT]','dMagB [Gs]'};
plotOpt.ylim_eulerd = 'auto'; %  [-50,50] or 'auto'
plotOpt.ylim_omegad = 'auto'; %  [-50,50] or 'auto'
plotOpt.ylim_AB_ms2 = 'auto'; %  [-50,50] or 'auto'
plotOpt.ylim_posm = 'auto'; %  [-50,50] or 'auto'
plotOpt.ylim_velm = 'auto'; %  [-50,50] or 'auto'
plotOpt.ylim_dAB_ms2 = 'auto'; %  [-50,50] or 'auto'
plotOpt.ylim_dWB_degs = 'auto'; %  [-50,50] or 'auto'
plotOpt.ylim_magB_Gs = 'auto'; %  [-50,50] or 'auto'
plotOpt.ylim_dMagB_Gs = 'auto'; %  [-50,50] or 'auto'
plotOpt.xlim_time = 'auto'; % or 'auto'


 