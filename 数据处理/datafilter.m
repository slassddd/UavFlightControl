function dataFiltered = datafilter(filterName,varargin)
switch filterName
    case 'lowpass'
        nParam = 4;
        if nargin ~= nParam
            error(['应有',num2str(nParam),'个参数']);
        end
        data = varargin{1};
        fpass = varargin{2};
        fs = varargin{3};
        dataFiltered = lowpass(data,fpass,fs);
    case 'median'
%         nParam = 2;
%         if nargin ~= nParam
%             error(['应有',num2str(nParam),'个参数']);
%         end        
        data = varargin{1};
        dataFiltered = median(data);
    case 'mean'
%         nParam = 2;
%         if nargin ~= nParam
%             error(['应有',num2str(nParam),'个参数']);
%         end        
        data = varargin{1};
        dataFiltered = median(data);
    otherwise
        error('滤波器名称错误!')
end