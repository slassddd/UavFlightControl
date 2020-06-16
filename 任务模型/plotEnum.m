function plotEnum(varargin)
if nargin == 1
    % fig = figure;
    % fig.Name = enumName;
    data = varargin{1};
    plot(data,'o');
elseif nargin == 2
    time = varargin{1};
    data = varargin{2};
    plot(time,data,'o');
end
grid on
enumName = class(data);
if contains(lower(enumName),'enum')
    yticks(unique( int16(data)))
    nTickLabel = length(yticks);
    yticksCell = num2cell(yticks);
    yticklabels_str = ['yticklabels({'];
    for i = 1:nTickLabel
        tempLabels{i} = char(eval([enumName,'(',num2str(yticksCell{i}),')']));
        yticklabels_str = [yticklabels_str,'''',tempLabels{i},''','];
    end
    yticklabels_str(end) = [];
    yticklabels_str = strrep(yticklabels_str,'_','\_');
    yticklabels_str = [yticklabels_str,'})'];
    eval(yticklabels_str)
else
    sl = 1;
end