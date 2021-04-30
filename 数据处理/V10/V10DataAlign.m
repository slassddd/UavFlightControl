function out = V10DataAlign(in)
children = fieldnames(in);
nChild = length(children);
for i = 1:nChild
    thisChild = in.(children{i});
    len(i) = length(thisChild);
end
maxLen = max(len);
for i = 1:nChild % 遍历儿子
    thisChild = in.(children{i});
    fprintf('\t对 %s 对齐:\t',children{i})
    if isa(thisChild,'struct')
        children2 = fieldnames(thisChild);
        hasStructChild = false;
        for i_c2 = 1:length(children2) % 遍历孙子
            thisChild2 = children2{i_c2};
            if isa(thisChild2,'struct')
                hasStructChild = true;
                break;
            end
        end
        if ~hasStructChild % 孙子中没有结构体，则进行对其
            fprintf(' Yes\n');
            in.(children{i}) = alignDimension(in.(children{i}));
        else
            fprintf(' No\n');
        end
    end
end
