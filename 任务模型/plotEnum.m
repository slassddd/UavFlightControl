function plotEnum(data)
enumName = class(data);
% fig = figure;
% fig.Name = enumName;
plot(data,'o');
grid on
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