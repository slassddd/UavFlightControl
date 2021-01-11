function [out,isSuccess,sameChild] = combineStruct(baseStruct,addStruct)
% 合并结构体成员
baseChildren = fieldnames(baseStruct);
addChildren = fieldnames(addStruct);
isSuccess = true;
out = baseStruct;
idxSame = 1;
sameChild = {};
% 检查重复性
for i_base = 1:length(baseChildren)
    baseChild = baseChildren{i_base};
    for i_add = 1:length(addChildren)
        addChild = addChildren{i_add};
        out.(addChild) = addStruct.(addChild);
        if strcmp(baseChild,addChild)
            isSuccess = false;
            sameChild{idxSame} = addChild;
            idxSame = idxSame + 1;
        end
    end
end
%
if ~isSuccess
    for i = 1:length(sameChild)
        warning('合并结构体警告，存在相同的成员变量 %s\n',sameChild{i});
    end
%     error('合并结构体错误: 存在重复的成员变量 %s',baseChild); 
end