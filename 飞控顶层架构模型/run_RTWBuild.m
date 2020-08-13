modelname = 'RefModel_SystemArchitecture';
prompt = {'版本号','时间'};
dlgtitle = '系统信息';
dims = [1 55];
tempTime = clock;
tempTimeStr = [num2str(tempTime(1)),...年
               num2str(tempTime(2)),...月
               num2str(tempTime(3));];%日
definput = {'',tempTimeStr};
answer = inputdlg(prompt,dlgtitle,dims,definput);
systemInfo.version = answer{1};
systemInfo.date = answer{2};
set_param([modelname,'/SystemInfo/version'],'value',systemInfo.version)
set_param([modelname,'/SystemInfo/date'],'value',systemInfo.date)
rtwbuild(modelname)