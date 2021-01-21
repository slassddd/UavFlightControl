% 数据处理: 提取日志文件中的有用数据
V1000_to_mat_archi
if ~iscell(DecodeParam.dirDecodeFile) % 当没有选择文件时，推出
    if FileName==0
        fprintf('没有选择文件\n');
        return;
    end
end
% 进行组合导航验算
run_navi