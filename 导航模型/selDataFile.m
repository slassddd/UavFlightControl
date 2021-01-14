try
    SimParam.TestCase.filename = saveFileName;
    saveMatFileName(SimParam.TestCase.filename);
catch
    tempFileName = load('lastFlightDataFileLoadedForNavi','dataFileNames');
    SimParam.TestCase.filename = tempFileName.dataFileNames;
    clear tempFileName
    fprintf('%s[WARNING] 当前工作空间没有 SimParam.TestCase.filename, 读取最后一次载入的数据文件:\n',GLOBAL_PARAM.Print.lineHead);
    for i = 1:length(SimParam.TestCase.filename)
        fprintf('%s%s %d. %s\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead,i,SimParam.TestCase.filename{i});
    end
end