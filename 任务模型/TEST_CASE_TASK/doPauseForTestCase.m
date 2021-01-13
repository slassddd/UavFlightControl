function out = doPauseForTestCase(bus,varargin)
out = bus;
% 解析赋值
for i = 1:2:length(varargin)-1
    tag = varargin{i};
    value = varargin{i+1};
    switch lower(tag)
        case 'delay'
            out.delay = value;
        case 'pointnumber'
            out.pointNumber = value;
        case 'duration'
            out.duration = value;
        case 'taskmode'
            out.taskMode = value;
    end
end