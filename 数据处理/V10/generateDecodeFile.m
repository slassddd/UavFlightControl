function generateDecodeFile(varargin)
% example: generateDecodeFile('filename','V10_decode_auto','comment','on');
% 参数
Param.outputName = 'V10Log';
Param.autoDecodeFileName = 'V10_decode_auto';
Param.autoDecodeFileType = 'function';
Param.comment = true;
for i = 1:length(varargin)/2
    switch varargin{2*i-1}
        case 'comment' % 是否附加协议中的内容作为注释
            if strcmp(varargin{2*i},'on')
                Param.comment = true;
            else
                Param.comment = false;
            end        
        case 'filename' % 指定解码函数名
            Param.autoDecodeFileName = varargin{2*i};
        case 'filetype' % 指定解码文件类型，函数or脚本
            Param.autoDecodeFileType = varargin{2*i};            
    end
end
% 转到该m函数所在路径
[filepath,name,ext] = fileparts(which(mfilename));
cd(filepath)
% 选择解析文件
DataParser.fileName = uigetfile('*.txt','选择协议文件'); %
% DataParser.fileName = 'V10日志存储参数说明书_v20201231.txt';
fprintf('协议文件: %s\n',DataParser.fileName);
decodeString = importdata(DataParser.fileName);
DataParser.oldLabel = '_label';
DataParser.sepflag = '|';
DataParser.flagStruct = '@@';
%% 载入数据
DataParser.logName = uigetfile('*.mat','选择.mat数据');
fprintf('数据文件: %s\n',DataParser.logName);
load(DataParser.logName);
% load('log_105.bin-459717.mat');
%% 获取数据变量和label变量名称
fprintf('数据完整性检查\n');
% fprintf('\t1.获取数据名称\n');
allVarLabel = whos();
nVar = length(allVarLabel);
idxVar = 1;
idxNotExist = 1;
idxToWrite = 1;
for i = 1:nVar
    thisVar = allVarLabel(i);
    if strcmp(thisVar.class,'cell') && ...
            contains(thisVar.name,DataParser.oldLabel)
        %         newAllVarLabel(idxVar) = thisVar;
        nameLabel{idxVar} = thisVar.name;
        nameData{idxVar} = strrep(thisVar.name,DataParser.oldLabel,'');
        if ~exist(nameLabel{idxVar})
            varNotExist{idxNotExist} = nameLabel{idxVar};
            idxNotExist = idxNotExist + 1;
        elseif ~exist(nameData{idxVar})
            varNotExist{idxNotExist} = nameData{idxVar};
            idxNotExist = idxNotExist + 1;
        else
            idxVar = idxVar + 1;
        end
    end
end
for i = 1:length(varNotExist)
    if i == 1
        fprintf('\t1.XYZ 和 XYZ_label 匹配性检测: 缺失 ');
    end
    fprintf('\t\t%s  ',varNotExist{i});
    if i == length(varNotExist)
        fprintf('\n');
    end
end
%% 对原始数据生成结构体
% fprintf('\t2.生成原始数据的结构体\n\t\t生成');
nVarLabel = length(nameLabel);
for i = 1:nVarLabel % 对原始数据生成结构体
    thisVarName = nameData{i};
    thisLabelName = nameLabel{i};
    %     fprintf('  %s',thisVarName);
    [flag,dataStruct] = genStructFromLabel(eval(thisVarName),eval(thisLabelName));
    eval([thisVarName,'_struct = dataStruct;']);
end
% fprintf('\n');
%% 从协议中获取变量全称
validVarNum = 0;
idxStruct = 1;
idxStructFull = 1;
for i = 1:size(decodeString)
    %     fprintf('%s\n',decodeString{i});
    thisLine = decodeString{i};
    sepPlace = strfind(thisLine,DataParser.sepflag);
    if ~contains(thisLine,'/* |') || ~contains(thisLine,'| */') || ...
            max(int8(thisLine)) == 127 % 包含非法字符
        continue;
    end
    validVarNum = validVarNum + 1;
    % 结构体名称
    strFlagStruct = strfind(thisLine,DataParser.flagStruct);
    if length(strFlagStruct) >= 2
        % 结构体名称简写
        startNum = strFlagStruct(1);
        endNum = strFlagStruct(2);
        structName = thisLine(startNum:endNum);
        structName = strrep(structName,'@','');
        structName = strtrim(structName);
        newAllFullName{idxStruct} = [structName,'_fullname'];
        newAllShortName{idxStruct} = [structName,'_shortname'];
        newComment{idxStruct} = [structName,'_comment'];
        % 结构体全称
        if length(strFlagStruct) == 3
            startNum = strFlagStruct(2);
            endNum = strFlagStruct(3);
            structFullName = thisLine(startNum:endNum);
            structFullName = strrep(structFullName,'@','');
            structFullName = strtrim(structFullName);
            newAllStructFullName{idxStructFull} = structFullName;
        else
            newAllStructFullName{idxStructFull} = structName;
        end
        % 结构体简称计数
        idxStruct = idxStruct + 1;
        % 结构体全称计数
        idxStructFull = idxStructFull + 1;        
        % 结构体成员计数
        validVarNum = 0;
    end
    % 变量名称
    if length(sepPlace) ~= 6
        tempstr = sprintf(['%% ',thisLine,'\n']);
    else % valid line
        % 变量名解析
        simpleName = getSimpleName(thisLine,sepPlace);
        fullName = getFullName(thisLine,sepPlace);
        % 全称
        template = '%s_fullname{%d} = ''%s'';';
        str_full = sprintf(template,structName,validVarNum,fullName);
        idx0 = strfind(str_full,'[');
        idx1 = strfind(str_full,']');
        indexVar = str_full([idx0+1:idx1-1]);
        if ~isempty(indexVar)
            indexVar = str2num(indexVar)+1;
            str_full = [str_full(1:idx0),num2str(indexVar),str_full(idx1:end)];
        end
        str_full = strrep(str_full,'[','(:,');
        str_full = strrep(str_full,']',')');
        eval(str_full);
        % 简写
        template = '%s_shortname{%d} = ''%s'';';
        str_short = sprintf(template,structName,validVarNum,simpleName);
        eval(str_short);
        % comment
        template = '%s_comment{%d} = ''%s'';';
        str_comment = sprintf(template,structName,validVarNum,thisLine);
        eval(str_comment);        
    end
end
fprintf('\t2.label标签名与协议变量简化名匹配性检测\n');
idxToWrite = 1;
nStructInProtocol = length(newAllFullName);
for i = 1:nStructInProtocol % 遍历协议中的结构体
    thisFullName = newAllFullName{i};
    thisShortName = newAllShortName{i};
    thisStructFullName = newAllStructFullName{i};
    thisComment = newComment{i};
    thisStructShortName = getToken(thisFullName,'fullname');
    fprintf('\t\t%s\n',thisStructShortName);
    for i_label = 1:length(nameLabel) % 遍历label变量找到与协议中对应的项
        thisVarLabel = nameLabel{i_label};
        tokenLabel = getToken(thisVarLabel,'label');
        if strcmp(thisStructShortName,tokenLabel)
            idxMatch = 1;
            for i_subvar = 1:length(eval(thisShortName)) %
                subName_FromShort = eval([thisShortName,'{i_subvar}']);
                isFind = false;
                for j_subvar = 1:length(eval(thisVarLabel)  )
                    subName_FromLabel = eval([thisVarLabel,'{j_subvar}']);
                    if strcmp(subName_FromShort,subName_FromLabel)
                        eval([thisStructShortName,'_idx(',num2str(idxMatch),') = ',num2str(j_subvar),';']);
                        idxMatch = idxMatch + 1;
                        isFind = true;
                        break;
                    end
                end
                if ~isFind
                    fprintf('\t\t\t%s 没有匹配\n',subName_FromShort);
                end
            end
        end
    end
    strToWrite{idxToWrite} = sprintf('%%%% %s\n',thisStructShortName);idxToWrite = idxToWrite + 1;
    for k = 1:length(eval([thisStructShortName,'_idx']))                
        mode = '结构体全称'; % 结构体简称 结构体全称
        switch mode
            case '结构体简称'
                structNameToWrite = thisStructShortName;
            otherwise
                structNameToWrite = thisStructFullName;
        end
        subName_FromFull = eval([thisFullName,'{',num2str(k),'};']);
        comment_FromComment = eval([thisComment,'{',num2str(k),'};']);
        comment_FromComment = strrep(comment_FromComment,'	','');
        comment_FromComment = strrep(comment_FromComment,' ','');
        comment_FromComment = strrep(comment_FromComment,'/*','');
        comment_FromComment = strrep(comment_FromComment,'*/','');
        if Param.comment
            strToWrite{idxToWrite} = sprintf('%s.%s.%s = %s(:,%d); %%%s\n',...
                Param.outputName,structNameToWrite,subName_FromFull,thisStructShortName,eval([thisStructShortName,'_idx(',num2str(k),')']),comment_FromComment);            
        else
            strToWrite{idxToWrite} = sprintf('%s.%s.%s = %s(:,%d);\n',...
                Param.outputName,structNameToWrite,subName_FromFull,thisStructShortName,eval([thisStructShortName,'_idx(',num2str(k),')']));
        end
        idxToWrite = idxToWrite + 1;     
%         if Param.comment
%             strToWrite{idxToWrite} = sprintf('%%%s\n',comment_FromComment);
%             idxToWrite = idxToWrite + 1;
%         end
%         strToWrite{idxToWrite} = sprintf('%s.%s.%s = %s(:,%d);\n',...
%             Param.outputName,structNameToWrite,subName_FromFull,thisStructShortName,eval([thisStructShortName,'_idx(',num2str(k),')']));
        %         eval(strToWrite{idxToWrite})
%         idxToWrite = idxToWrite + 1;
    end
end
%% 生成解析函数
fileID = fopen([Param.autoDecodeFileName,'.m'],'w');
% 函数头
switch Param.autoDecodeFileType
    case 'script'
    otherwise
        str = sprintf('function %s = %s(logFile)\n',Param.outputName,Param.autoDecodeFileName);
        fwrite(fileID,str);
end
str = sprintf('%% example: %s = %s(''%s'')\n',Param.outputName,Param.autoDecodeFileName,DataParser.logName);
fwrite(fileID,str);
str = sprintf('%% computer name: %s\n',char(getHostName(java.net.InetAddress.getLocalHost)));
fwrite(fileID,str);
str = sprintf('%% generate date: %s\n',date);
fwrite(fileID,str);
str = sprintf('%% Matlab version: %s\n',version);
fwrite(fileID,str);
str = sprintf('%% protocol file: %s\n',DataParser.fileName);
fwrite(fileID,str);
str = sprintf('%% data file: %s\n',DataParser.logName);
fwrite(fileID,str);
str = sprintf('%% logFile: .mat log file\n');
fwrite(fileID,str);
str = sprintf('load(logFile);\n');
fwrite(fileID,str);
% 函数体
for i = 1:length(strToWrite)
    fwrite(fileID,strToWrite{i});
end
fclose(fileID);
edit(Param.autoDecodeFileName)
fprintf('生成decode文件,%s\n',Param.autoDecodeFileName)
%% 子函数
function [flag,dataStruct] = genStructFromLabel(data,label)
flag = true;
nData = size(data,2);
nLabel = length(label);
if nData ~= nLabel
    fprintf('变量维数不匹配: data (%d), label (%d)\n',nData,nLabel);
    flag = false;
    return;
end
for i = 1:nLabel
    dataStruct.(label{i}) = data(:,i);
end

% 获取token
function out = getToken(in,type)
switch type
    case 'label'
        out = strrep(in,'_label','');
    case 'fullname'
        out = strrep(in,'_fullname','');
end

% 获取变量名简写
function varname = getSimpleName(content,sepPlace)
idxStart = 2;
idxEnd = idxStart+1;
startNum = sepPlace(idxStart);
endNum = sepPlace(idxEnd);
varname = strtrim(content(startNum+1:endNum-1));

% 获取变量名全称
function varname = getFullName(content,sepPlace)
idxStart = 3;
idxEnd = idxStart+1;
startNum = sepPlace(idxStart);
endNum = sepPlace(idxEnd);
varname = strtrim(content(startNum+1:endNum-1));

