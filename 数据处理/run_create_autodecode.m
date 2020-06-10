% 读取协议文件，自动生成解析m函数
clear,clc
filename = uigetfile('*.txt','选择协议文件'); % 
decodeString = importdata(filename);
sepflag = '|';
flag_varname = {' ',sepflag,']','[','-','>','.'};
flag_type = {' ',sepflag,']','['};
flag_struct = '@@';
validVarNum = 0;
template1 = 'temp = reshape([data(%d:%d:end,%d:%d)''],1,[]);\n';
template2 = '%s=double(typecast(uint8(temp),''%s'')'')/%d*%.10f;\n';
template3 = 'temp = reshape([data(%s,%d:%d)''],1,[]);\n';
structName = 'TempName';
for i = 1:size(decodeString)
    %     fprintf('%s\n',decodeString{i});
    thisLine = decodeString{i};
    sepPlace = strfind(thisLine,sepflag);
    if ~contains(thisLine,'/*')
        continue;
    end
    validVarNum = validVarNum + 1;
    strFlagStruct = strfind(thisLine,flag_struct);
    if length(strFlagStruct) >= 2
        startNum = strFlagStruct(1);
        endNum = strFlagStruct(2);
        structName = thisLine(startNum:endNum);
        structName = strrep(structName,'@','');
        structName = strrep(structName,' ','');
    end
    if length(sepPlace) ~= 6
        tempstr = sprintf(['%% ',thisLine,'\n']);
        out_decodeString{3*validVarNum-2,1} = tempstr;
    else % valid line        
        % 变量名解析
        idxFlag = 2;
        startNum = sepPlace(idxFlag);
        endNum = sepPlace(idxFlag+1);
        varname = thisLine(startNum:endNum);
        for i_nameflag = 1:length(flag_varname)
            varname = strrep(varname,flag_varname{i_nameflag},'');
        end
        if int16(varname(1)) > 200
            continue 
        end
        fprintf('%dth var: %s\t',validVarNum,varname);
        % 类型解析
        idxFlag = idxFlag + 1;
        startNum = sepPlace(idxFlag);
        endNum = sepPlace(idxFlag+1);
        content = thisLine(startNum:endNum);
        for i_nameflag = 1:length(flag_type)
            content = strrep(content,flag_type{i_nameflag},'');
        end
        sep1Place = strfind(content,':');
        type0 = content(1:sep1Place(1)-1);
        if length(sep1Place) == 2
            typef = content(sep1Place(1)+1:sep1Place(2)-1);
            ttemp = content(sep1Place(2)+1:end);
            ttemp = strrep(ttemp,'f','');
            scaleData = eval(ttemp);
        else
            typef = content(sep1Place(1)+1:end);
            scaleData = 1;
        end
        if isempty(scaleData)
            error('')
        end
        fprintf('[%s:%s:%d]\t',type0,typef,scaleData);
        switch typef
            case 'U8'
                typeSymble = 'uint8';
                biasNum = 0;
            case 'U16'
                typeSymble = 'uint16';
                biasNum = 1;
            case 'U32'
                typeSymble = 'uint32';
                biasNum = 3;
            case 'S8'
                typeSymble = 'int8';
                biasNum = 0;
            case 'S16'
                typeSymble = 'int16';
                biasNum = 1;
            case 'S32'
                typeSymble = 'int32';
                biasNum = 3;
            case 'F'
                typeSymble = 'single';
                biasNum = 3;
            case 'D'
                error('请手动解析D类型')
            case 'L'
                error('请手动解析L类型')
            case 'B'
                continue
                warning('请手动解析B类型')
            otherwise
        end
        number1 = 1;
        switch type0
            case 'F'
                if strcmp(typef,'S16') || strcmp(typef,'U16')
                    number1 = 32768;
                elseif strcmp(typef,'S32') || strcmp(typef,'U32')
                    number1 = 1e7;
%                 elseif strcmp(typef,'S16') || strcmp(typef,'U16')    
                end
            otherwise
        end
        % 频率
        idxFlag = idxFlag + 1;
        startNum = sepPlace(idxFlag);
        endNum = sepPlace(idxFlag+1);
        content = thisLine(startNum:endNum);
        for i_nameflag = 1:length(flag_type)
            content = strrep(content,flag_type{i_nameflag},'');
        end
        sep1Place = strfind(content,':');
        sample_freq = str2num(content(1:sep1Place(1)-1));
        log_freq = str2num(content(sep1Place(1)+1:end));
        fprintf('[%d:%d]\t',sample_freq,sample_freq);
        % 存储位置
        idxFlag = idxFlag + 1;
        startNum = sepPlace(idxFlag);
        endNum = sepPlace(idxFlag+1);
        content = thisLine(startNum:endNum);
        for i_nameflag = 1:length(flag_type)
            content = strrep(content,flag_type{i_nameflag},'');
        end
        sep1Place = strfind(content,':');
        block_cnt = str2num(content(1:sep1Place(1)-1));
        block_idx = str2num(content(sep1Place(1)+1:sep1Place(2)-1));
%         if block_idx == 0
%             block_idx = block_cnt+1;
%         end
        bloack_offset = str2num(content(sep1Place(2)+1:end));
        fprintf('[%d:%d:%d]\n',block_cnt,block_idx,bloack_offset);
        %% 生成decode代码 ------------------------
        indexStr = sprintf('find(mod(Count,%d)==%d)',block_cnt+1,block_idx);
        out_decodeString{3*validVarNum-2,1} = sprintf( template3,indexStr,bloack_offset+1,bloack_offset+1+biasNum);
%         fprintf('%s\n',varname);
        fprintf('\t%s\n',out_decodeString{3*validVarNum-2,1});
%         out_decodeString{3*validVarNum-2,1} = sprintf(template1,block_idx,block_cnt+1,bloack_offset+1,bloack_offset+1+biasNum);
%         fprintf('2: %s\n',out_decodeString{3*validVarNum-2,1});
        out_decodeString{3*validVarNum-1,1} = sprintf(template2,varname,typeSymble,number1,scaleData);
        out_decodeString{3*validVarNum,1} = sprintf('%s.%s = %s; %% create struct\n',structName,varname,varname);
    end
end   
autoDecodeFileName = 'V1000_decode_auto.m';
fileID = fopen(autoDecodeFileName,'w');
baseTimeStr = sprintf('baseIMUtime = IN_SENSOR.IMU1.time;\n');
fwrite(fileID,baseTimeStr);    
baseTimeStr = sprintf('baseIMUtime = IN_SENSOR.IMU1.time;\n');
fwrite(fileID,baseTimeStr);    
for i = 1:length(out_decodeString)
    fwrite(fileID,out_decodeString{i});    
end
fclose(fileID);
edit(autoDecodeFileName)
fprintf('-------------------\n')
fprintf('生成decode文件,%s\n',autoDecodeFileName)
fprintf('注意：本程序不解析B类型数据，且txt文件中不要出现'':''\n')
