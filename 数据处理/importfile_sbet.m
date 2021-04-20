function sbet0 = importfile_sbet(filename, dataLines)
%IMPORTFILE 从文本文件中导入数据
%  SBET0 = IMPORTFILE(FILENAME)读取文本文件 FILENAME 中默认选定范围的数据。  返回数值数据。
%
%  SBET0 = IMPORTFILE(FILE, DATALINES)按指定行间隔读取文本文件 FILENAME
%  中的数据。对于不连续的行间隔，请将 DATALINES 指定为正整数标量或 N×2 正整数标量数组。
%
%  示例:
%  sbet0 = importfile("D:\work\V1000_firmware\SubFolder_飞行数据\V10 数据\20210411 航迹对比\sbet0.txt", [3, Inf]);
%
%  另请参阅 READTABLE。
%
% 由 MATLAB 于 2021-04-14 18:20:48 自动生成

%% 输入处理

% 如果不指定 dataLines，请定义默认范围
if nargin < 2
    dataLines = [3, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 46);

% 指定范围和分隔符
opts.DataLines = dataLines;
opts.Delimiter = " ";

% 指定列名称和类型
opts.VariableNames = ["gps_time", "VarName2", "VarName3", "latitude", "VarName5", "VarName6", "longtitude", "VarName8", "VarName9", "VarName10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var23", "Var24", "Var25", "Var26", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34", "Var35", "Var36", "Var37", "Var38", "Var39", "Var40", "Var41", "Var42", "Var43", "Var44", "Var45", "Var46"];
opts.SelectedVariableNames = ["gps_time", "VarName2", "VarName3", "latitude", "VarName5", "VarName6", "longtitude", "VarName8", "VarName9", "VarName10"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.LeadingDelimitersRule = "ignore";

% 指定变量属性
opts = setvaropts(opts, ["Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var23", "Var24", "Var25", "Var26", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34", "Var35", "Var36", "Var37", "Var38", "Var39", "Var40", "Var41", "Var42", "Var43", "Var44", "Var45", "Var46"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var23", "Var24", "Var25", "Var26", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34", "Var35", "Var36", "Var37", "Var38", "Var39", "Var40", "Var41", "Var42", "Var43", "Var44", "Var45", "Var46"], "EmptyFieldRule", "auto");

% 导入数据
sbet0 = readtable(filename, opts);

%% 转换为输出类型
sbet0 = table2array(sbet0);
end