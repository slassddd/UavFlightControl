function printSimEnd(varargin)
global GLOBAL_PARAM
if nargin == 1
    timeSpend = varargin{1};
else
    timeSpend = nan;
end
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);
fprintf('%s[END] 仿真完成, 耗时 %.2f [s]\n',GLOBAL_PARAM.Print.lineHead,timeSpend);
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);