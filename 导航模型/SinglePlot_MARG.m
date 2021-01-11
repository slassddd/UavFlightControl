try
    fid = figure(300+i_sim);
    fid.Name = 'MARG';    
    Plot_NaviMARG(navFilterMARGRes,3,2,1) 
catch
    figure('name','MARG');
    Plot_NaviMARG(SimRes.Navi.MARG(1),3,2,1) 
    warning('%s 执行单数据绘图，确认是否符合预期',mfilename)
end

