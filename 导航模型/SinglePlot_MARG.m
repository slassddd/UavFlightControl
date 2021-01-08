fid = figure(300+i_sim);
fid.Name = 'MARG';
postplot_marg_flightdata(SimRes.Navi.MARG,plotOpt,3,idx_style,stepSpace) %显示组合导航数据