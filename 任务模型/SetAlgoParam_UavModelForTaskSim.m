function SUavSimParam = SetAlgoParam_UavModelForTaskSim()
global GLOBAL_PARAM
SUavSimParam.Ts_base = 0.036;

fprintf('[%s]\n',mfilename);
fprintf('%s周期: %.3f [sec]\n',GLOBAL_PARAM.Print.lineHead,SUavSimParam.Ts_base);
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);