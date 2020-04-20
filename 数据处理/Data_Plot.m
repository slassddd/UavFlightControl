function varargout = Data_Plot(varargin)

% DATA_PLOT M-file for Data_Plot.fig
%      DATA_PLOT, by itself, creates a new DATA_PLOT or raises the existing
%      singleton*.
%
%      H = DATA_PLOT returns the handle to a new DATA_PLOT or the handle to
%      the existing singleton*.
%
%      DATA_PLOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DATA_PLOT.M with the given input arguments.
%
%      DATA_PLOT('Property','Value',...) creates a new DATA_PLOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Data_Plot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Data_Plot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Data_Plot

% Last Modified by GUIDE v2.5 22-Nov-2018 16:48:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Data_Plot_OpeningFcn, ...
                   'gui_OutputFcn',  @Data_Plot_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Data_Plot is made visible.
function Data_Plot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Data_Plot (see VARARGIN)

% Choose default command line output for Data_Plot
handles.output = hObject;

index_DataList = zeros(1,9);
File_str = cell(1,9);
handles.index_DataList = index_DataList;
handles.File_str = File_str;
global StrSplit;
StrSplit = cell(1,500);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Data_Plot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Data_Plot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in OpenFile.
function OpenFile_Callback(hObject, eventdata, handles)
% hObject    handle to OpenFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PathName1 = 0;
load file_lj; 
 ModeSelect=4;
% ModeSelect = get(handles.ModeSelect,'value');
DataList_str = ''; %#ok<NASGU>
File_v   = get(handles.FileList,'value');
len = length(File_v);
index_DataList = GetLastNoBlank(handles);

if(len~=0)
    if File_v(1) > index_DataList
        FilePath = [PathName1,'\*.*'];
    else
        FilePath = handles.originalFileInfo.Path{1,File_v(1)};
        ModeSelect_select =  handles.originalFileInfo.ModeSelect(1,File_v(1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %多个文件，同一格式，一个list
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if(ModeSelect_select == 4)
            [FilePath name ext] = fileparts(char(handles.File_str(1,File_v(1))));
        end
        FilePath = strcat(FilePath,'\*.*');
    end
else
    FilePath=[PathName1,'\*.*'];
end

[name,path] = uigetfile(FilePath,'Pick File','MultiSelect','on');
PathName1 = path;

if isnumeric(path)
    errordlg('没有选择数据文件');
    return;
end

save file_lj PathName1; 

if(iscellstr(name))
    len = length(name);
else
    len = 1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%多个文件，同一格式，一个list
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(ModeSelect == 1)
    [data textdisp File_str] = ImportDataFile1(name,path,len);%模式3
    formatlen = 1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%使用配置文件，一个配置文件一个list（当前目录就一个配置文件）
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(ModeSelect == 2)
    [data textdisp File_str] = ImportDataFile2(path);
    formatlen = 1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%单选或者多选文件，不同格式，一个list
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(ModeSelect == 3)
    [data textdisp File_str] = ImportDataFile3(name,path,len);%模式3
    formatlen = 1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%单选或者多选文件，一个文件一个list
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(ModeSelect == 4)
    [data textdisp File_str] = ImportDataFile4(name,path,len);
    formatlen = len;
end
for kk=1:formatlen
    index_DataList = GetFirstNoBlank(handles);
    if(index_DataList == 1e10)
        return;
    end
    handles.originalFileInfo.Name{1,index_DataList} = name;
    handles.originalFileInfo.Path{1,index_DataList} = path;
    handles.originalFileInfo.Len(1,index_DataList) = len;
    handles.originalFileInfo.ModeSelect(1,index_DataList) = ModeSelect;
    if (ModeSelect == 1)
        handles.SelectFileCount(1,index_DataList) = len;
    else
        handles.SelectFileCount(1,index_DataList) = 1;
    end
    DataList_str = ['DataList' num2str(index_DataList)];
    data_str = ['data' num2str(index_DataList)];
    set(handles.(DataList_str),'visible','on');
    handles.File_str{1,index_DataList} = File_str.(['FileStr' num2str(kk)]);
    set(handles.FileList,'String',handles.File_str);
    set(handles.(DataList_str),'String',textdisp.(['text' num2str(kk)]));
    set(handles.(DataList_str),'visible','on');
    
    handles.(data_str)= data.(['data' num2str(kk)]);
    handles.index_DataList(index_DataList) = 1;%成功添加一个新数据，则置该索引位置为1
    guidata(hObject, handles);
    if(ModeSelect == 4)
        set(handles.(['xlabel',num2str(index_DataList)]),'visible','on');
        if(iscellstr(name))
            set(handles.(['xlabel',num2str(index_DataList)]),'String',name(kk));
        else
            set(handles.(['xlabel',num2str(index_DataList)]),'String',name);
        end
    end
end


% --- Executes on button press in DataPlotOne.
function DataPlotOne_Callback(hObject, eventdata, handles)
% hObject    handle to DataPlotOne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% time_lingwei  = str2num(get(handles.Lingwei, 'string')); %
time_lingwei=0;
handles.axes1;       %将原来的多幅图显示改为单图显示
graph = subplot(1,1,1);
cla reset;        %清图并坐标重置
k=1;
lgd=[];
listtext='';
linecolor=['b','r','k','g','c','m'];
line_style={'-','--','-.','*','x'};
all_list = findobj('style','listbox','visible','on');
blank_list = findobj('style','listbox','string',[],'visible','on');
hasvalue_list = setdiff(all_list,[blank_list handles.FileList]);
for i=1:length(hasvalue_list)
    DataList_str_temp{i} = get(hasvalue_list(i),'tag');
end
if(length(hasvalue_list) >= 1)
    [temp,Datashuxu] = sort(DataList_str_temp);%根据list排序
end

for d=1:length(hasvalue_list);
    i = Datashuxu(d);  %按顺序整理
    list_v = get(hasvalue_list(i),'value');
    DataList_str = get(hasvalue_list(i),'tag');
    for j=1:length(list_v)
        for p=1:handles.SelectFileCount(1,str2double(DataList_str(9)))
            y{k} = handles.(['data' DataList_str(9)]){p,list_v(j)};
            
            listtexttemp1 = [y{k}.name '-list' num2str(DataList_str(9))];  %查找下划线替换
            listtexttemp2 = listtexttemp1(1);
            for kf = 2:length(listtexttemp1)
                if(listtexttemp1(kf) == '_')
                    listtexttemp2 = [listtexttemp2,'\_'];
                else
                    listtexttemp2 = [listtexttemp2,listtexttemp1(kf)];
                end
            end
            listtext{k} = listtexttemp2;            
            k=k+1;
        end
    end
end
len = length(listtext);
if (len~=0)
    for i=1:len
        
        
        %二维绘图
        %单置x的绘图
        if(  isfield(y{i},'time2') && ~isempty(y{i}.time2) && (~isfield(y{i},'z2') || isempty(y{i}.z2)))
            line(y{i}.time2 + time_lingwei,y{i}.data,'color',linecolor(i-6*floor((i-1)/6)),'linestyle',line_style{ceil(i/6)},'linewidth',2);
            xlabel(y{i}.namex);
        end
        %默认绘图
        if(  (~isfield(y{i},'time2') || isempty(y{i}.time2))  &&   (~isfield(y{i},'z2') || isempty(y{i}.z2))  )
            line(y{i}.time + time_lingwei,y{i}.data,'color',linecolor(i-6*floor((i-1)/6)),'linestyle',line_style{ceil(i/6)},'linewidth',2);
             xlabel('t(s)');
        end
        
        
        
         %置x的绘图  并且置z的绘图  三维绘图
        if(  (isfield(y{i},'time2') && ~isempty(y{i}.time2)) && (isfield(y{i},'z2') && ~isempty(y{i}.z2)) )
            plot3(y{i}.time2 + time_lingwei,y{i}.z2,y{i}.data,'color',linecolor(i-6*floor((i-1)/6)),'linestyle',line_style{ceil(i/6)},'linewidth',2);
            xlabel(y{i}.namex);
            ylabel(y{i}.namez);
        end
        %单置z的绘图  三维绘图
        if(  (~isfield(y{i},'time2') || isempty(y{i}.time2)) && (isfield(y{i},'z2') && ~isempty(y{i}.z2)) )
            plot3(y{i}.time + time_lingwei,y{i}.z2,y{i}.data,'color',linecolor(i-6*floor((i-1)/6)),'linestyle',line_style{ceil(i/6)},'linewidth',2);
            xlabel('t(s)');
            ylabel(y{i}.namez);
        end

    end
    grid on;
   
    lgd = legend(listtext);
end
handles.graph = graph;
handles.legend = lgd;
guidata(hObject, handles);


% --- Executes on button press in PlotData_multi.
function PlotData_multi_Callback(hObject, eventdata, handles)
% hObject    handle to PlotData_multi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% time_lingwei  = str2num(get(handles.Lingwei, 'string')); %
time_lingwei  = 0; %
graph = subplot(1,1,1);
listtext = '';
lgd=[];
k=1;
all_list = findobj('style','listbox','visible','on');
blank_list = findobj('style','listbox','string',[],'visible','on');
hasvalue_list = setdiff(all_list,[blank_list handles.FileList]);

for i=1:length(hasvalue_list)
    DataList_str_temp{i} = get(hasvalue_list(i),'tag');
end
if(length(hasvalue_list) >= 1)
    [temp,Datashuxu] = sort(DataList_str_temp);%根据list排序
end

for d=1:length(hasvalue_list);
    
    i = Datashuxu(d);  %按顺序整理
    
    list_v = get(hasvalue_list(i),'value');
    DataList_str = get(hasvalue_list(i),'tag');
    for j=1:length(list_v)
        for p=1:handles.SelectFileCount(1,str2double(DataList_str(9)))
            y{k} = handles.(['data' DataList_str(9)]){p,list_v(j)};
            
            listtexttemp1 = [y{k}.name '-list' num2str(DataList_str(9))];  %查找下划线替换
            listtexttemp2 = listtexttemp1(1);
            for kf = 2:length(listtexttemp1)
                if(listtexttemp1(kf) == '_')
                    listtexttemp2 = [listtexttemp2,'\_'];
                else
                    listtexttemp2 = [listtexttemp2,listtexttemp1(kf)];
                end
            end
            listtext{k} = listtexttemp2;          
            
            k=k+1;
        end
    end
end
len = length(listtext);
if (len ~=0)
    for i=1:len
        graph(i)=subplot(len,1,i);
        if(  isfield(y{i},'time2') && ~isempty(y{i}.time2))
            line(y{i}.time2 + time_lingwei,y{i}.data,'linewidth',2);
            xlabel(y{i}.namex);
        else
            line(y{i}.time + time_lingwei,y{i}.data,'linewidth',2);
            xlabel('t(s)');
        end    
        grid on; 
        lgd(i)=legend(listtext{i});
    end
end
handles.graph = graph;
handles.legend = lgd;
guidata(hObject, handles);

% --- Executes on button press in PlotData_star.
function PlotData_star_Callback(hObject, eventdata, handles)
% hObject    handle to PlotData_star (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(findobj('type','line'),'marker','o');
grid on;


% --- Executes on selection change in DataList1.
function DataList1_Callback(hObject, eventdata, handles)
% hObject    handle to DataList1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns DataList1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DataList1


% --- Executes during object creation, after setting all properties.
function DataList1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DataList1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in DataList1.
function DataList2_Callback(hObject, eventdata, handles)
% hObject    handle to DataList1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns DataList1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DataList1


% --- Executes during object creation, after setting all properties.
function DataList2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DataList1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in FileList.
function DataList3_Callback(hObject, eventdata, handles)
% hObject    handle to FileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns FileList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FileList


% --- Executes during object creation, after setting all properties.
function DataList3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in FileList.
function DataList4_Callback(hObject, eventdata, handles)
% hObject    handle to FileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns FileList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FileList


% --- Executes during object creation, after setting all properties.
function DataList4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in DataList1.
function DataList5_Callback(hObject, eventdata, handles)
% hObject    handle to DataList1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns DataList1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DataList1


% --- Executes during object creation, after setting all properties.
function DataList5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DataList1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in FileList.
function DataList6_Callback(hObject, eventdata, handles)
% hObject    handle to FileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns FileList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FileList


% --- Executes during object creation, after setting all properties.
function DataList6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in FileList.
function DataList7_Callback(hObject, eventdata, handles)
% hObject    handle to FileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns FileList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FileList


% --- Executes during object creation, after setting all properties.
function DataList7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in DataList1.
function DataList8_Callback(hObject, eventdata, handles)
% hObject    handle to DataList1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns DataList1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DataList1


% --- Executes during object creation, after setting all properties.
function DataList8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DataList1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in FileList.
function FileList_Callback(hObject, eventdata, handles)
% hObject    handle to FileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns FileList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FileList


% --- Executes during object creation, after setting all properties.
function FileList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CopyFigure.
function CopyFigure_Callback(hObject, eventdata, handles)
% hObject    handle to CopyFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    graph = handles.graph;   %调入子图的句柄，为复制图形使用
    legendText=handles.legend;         %调入子图的legend句柄，为复制图形使用
    fig = figure('visible','on');
    copy_figure=copyobj(graph,fig);
    
    for i=1:length(copy_figure)       
       legend(copy_figure(i),'show');
    end
    % print('-dbitmap',fig);
    % close(fig);
catch ex
    errordlg(ex.message);
end

% --- Executes on button press in RefreshData.
function RefreshData_Callback(hObject, eventdata, handles)
% hObject    handle to RefreshData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DataList_str = ''; %#ok<NASGU>
File_v   = get(handles.FileList,'value');
len = length(File_v);
index_DataList = GetLastNoBlank(handles);
if(len~=0)
    for i=1:len
        if File_v(i) > index_DataList
            continue;
        end
        name = handles.originalFileInfo.Name{1,File_v(i)};
        path = handles.originalFileInfo.Path{1,File_v(i)};
        Filelen =  handles.originalFileInfo.Len(1,File_v(i));
        ModeSelect=4;
%         ModeSelect =  handles.originalFileInfo.ModeSelect(1,File_v(i));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %多个文件，同一格式，一个list
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if(ModeSelect == 1)
            [data textdisp File_str] = ImportDataFile1(name,path,Filelen);%模式3
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %使用配置文件，一个配置文件一个list（当前目录就一个配置文件）
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if(ModeSelect == 2)
            [data textdisp File_str] = ImportDataFile2(path);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %单选或者多选文件，不同格式，一个list
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if(ModeSelect == 3)
            [data textdisp File_str] = ImportDataFile3(name,path,Filelen);%模式3
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %单选或者多选文件，一个文件一个list
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if(ModeSelect == 4)
            [ppath name ext] = fileparts(handles.File_str{1,File_v(i)});
            [data textdisp File_str] = ImportDataFile4(strcat(name,ext),path,1);
        end
        DataList_str = ['DataList' num2str(File_v(i))];
        data_str = ['data' num2str(File_v(i))];
        set(handles.(DataList_str),'visible','on');
        set(handles.(DataList_str),'String',textdisp.('text1'));
        handles.(data_str)= data.('data1');
        handles.index_DataList(index_DataList) = 1;%成功添加一个新数据，则置该索引位置为1
        guidata(hObject, handles);
    end
    msgbox('刷新数据完成！');
end
% --- Executes on button press in ClearFile.
function ClearFile_Callback(hObject, eventdata, handles)
% hObject    handle to ClearFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DataList_str = ''; %#ok<NASGU>
File_v   = get(handles.FileList,'value');
len = length(File_v);
index_DataList = GetLastNoBlank(handles);
if(len~=0)
    for i=1:len
        if File_v(i) > index_DataList
            continue;
        end
        DataList_str = ['DataList' num2str(File_v(i))];
        data_str = ['data' num2str(File_v(i))];
        set(handles.(DataList_str),'String',[]);
        handles.File_str{1,File_v(i)}='';
        handles = rmfield(handles,data_str);
        handles.index_DataList(File_v(i)) = 0;%将该数据索引置为无效
        set(handles.(DataList_str),'visible','off');
        set(handles.(['xlabel',num2str(File_v(i))]),'visible','off');
    end
    if isempty(handles.File_str)
        handles.File_str='文件路径';
    end
    set(handles.FileList,'string', handles.File_str);
    guidata(hObject, handles);
    msgbox('清除数据完成！');
end

% --- Executes on button press in SetX.
function SetX_Callback(hObject, eventdata, handles)
% hObject    handle to SetX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
all_list = findobj('style','listbox','visible','on');
blank_list = findobj('style','listbox','string',[],'visible','on');
hasvalue_list = setdiff(all_list,[blank_list handles.FileList]);
list_vv = get(hasvalue_list,'value');
if(iscell(list_vv))
    list_v = list_vv;
else
    list_v{1} = list_vv;
end
list_n = 0;
for i=1:length(list_v)
    try
        if ~isempty(list_v{i})
            list_n = list_v{i};
            hasvalue_list_n = hasvalue_list(i);  
            
            DataList_str = get(hasvalue_list_n,'tag');
            NH =  length(handles.(['data' DataList_str(9)]));
            for k = 1:NH
               if( length(handles.(['data' DataList_str(9)]){k}.name) == 5  && sum( handles.(['data' DataList_str(9)]){k}.name == '标准分隔符') == 5)
                    msgbox('同一个List内数据格式需一致！！！');
                   return;
               end
            end
            for k=1:NH
                handles.(['data' DataList_str(9)]){k}.time2 = handles.(['data' DataList_str(9)]){list_n(1)}.data;   
                handles.(['data' DataList_str(9)]){k}.namex = handles.(['data' DataList_str(9)]){list_n(1)}.name0;%x轴名称
            end
            
            
        end
    end

    
end
if (list_n == 0)
    msgbox('请指定X数据！！！');
    return;
end

guidata(hObject,handles);

% --- Executes on button press in SetY.
function SetY_Callback(hObject, eventdata, handles)
% hObject    handle to SetY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for k =1:9
    if( isfield( handles,(['data',num2str(k)]))   && isfield( handles.(['data',num2str(k)]){1},'time2'))
        for j = 1:length(  handles.(['data',num2str(k)]))
           handles.(['data',num2str(k)]){j}.time2= '';
           handles.(['data',num2str(k)]){j}.z2= '';
        end
    end
end
guidata(hObject, handles);
PlotRest_Callback(hObject, eventdata, handles);

% --- Executes on button press in figureDIY.
function figureDIY_Callback(hObject, eventdata, handles)
% hObject    handle to figureDIY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = questdlg('请选择功能','图像DIY功能','图像DIY','同步放大','图像DIY');
if(strcmp(h,'同步放大'))
    try
        graph = handles.graph;   %调入子图的句柄，为复制图形使用
        linkaxes(graph,'x');
    catch ex
        errordlg(ex.message);
    end
    return;
end
lines = sort( get(gca,'children') );
displaynames = get(lines,'displayname');
if isempty(displaynames)
    msgbox('没有选定DIY的对象！');
    return;
end
[ss,vs]=listdlg('PromptString','选择数据','ListString',displaynames);
if isempty(ss)
    msgbox('没有选定DIY的对象！');
    return;
end
prompt = {'Enter x_fun:','Enter y_fun:'};
dlg_title = 'Input for  function';
num_lines = 3;
def = {'x=(x);','y=(y);'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
if isempty(answer)
    msgbox('未输入有效的DIY函数！！');
    return;
end
for i =1:length(ss)
    x=get(lines(ss(i)),'xdata');
    y=get(lines(ss(i)),'ydata');
    try
        eval(answer{1});
        eval(answer{2});
    catch ex
        errordlg(ex.message);
        return;
    end
    set(lines(ss(i)),'xdata',x,'ydata',y);
end


% --- Executes on selection change in DataList3.
function listbox10_Callback(hObject, eventdata, handles)
% hObject    handle to DataList3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns DataList3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DataList3


% --- Executes during object creation, after setting all properties.
function listbox10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DataList3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DataDIY.
function DataDIY_Callback(hObject, eventdata, handles)
% hObject    handle to DataDIY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('数据修正之后，只能通过刷新数据重新读取文件数据，请慎重！','注意','warn');
uiwait(h);
all_list = findobj('style','listbox','visible','on');
blank_list = findobj('style','listbox','string',[],'visible','on');
hasvalue_list = setdiff(all_list,[blank_list handles.FileList]);
list_v = get(hasvalue_list,'value');
for i=1:length(list_v)
    try
        if ~isempty(list_v{i})
            list_v = list_v{i};
            hasvalue_list = hasvalue_list(i);
            break;
        end
    catch ex
        if ~isempty(list_v(i))
            list_v = list_v(i);
            hasvalue_list = hasvalue_list(i);
            break;
        end
    end
end
if (length(hasvalue_list) ~= 1 || length(list_v) ~= 1)
    msgbox('一次只能更改一个数据');
    return;
end
DataList_str = get(hasvalue_list,'tag');
for p=1:handles.SelectFileCount(1,str2double(DataList_str(9)))
    valuename(1,p) = cellstr([char(handles.(['data' DataList_str(9)]){p,list_v}.name) '-list' DataList_str(9)]);
end
[ss,vs]=listdlg('PromptString','选择数据','ListString',valuename);
if isempty(ss)
    msgbox('没有选定DIY的对象！');
    return;
end
prompt = '数据DIY';
dlg_title = 'Input for  function';
num_lines = 3;
def = {'val=(val);'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
if isempty(answer)
    msgbox('未输入有效的DIY函数！！');
    return;
end
for i =1:length(ss)
    try
        for p=1:handles.SelectFileCount(1,str2double(DataList_str(9)))
            val = handles.(['data' DataList_str(9)]){p,list_v}.data;
            eval(answer{i});
            handles.(['data' DataList_str(9)]){p,list_v}.data = val;
        end
    catch ex
        errordlg(ex.message);
        return;
    end
end
guidata(hObject, handles);

% --- Executes on selection change in ModeSelect.
% function ModeSelect_Callback(hObject, eventdata, handles)
% hObject    handle to ModeSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ModeSelect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ModeSelect


% --- Executes during object creation, after setting all properties.
% function ModeSelect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ModeSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in FilePathOpen.
function FilePathOpen_Callback(hObject, eventdata, handles)
% hObject    handle to FilePathOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
shujulingweitiaozheng(hObject, eventdata, handles);

% --- Executes on button press in DecodeAnalog.
function DecodeAnalog_Callback(hObject, eventdata, handles)
% hObject    handle to DecodeAnalog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


run shujuchuli;

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
time_lingwei  = 0; %
save time_lingwei time_lingwei
run pinjiecjcgq;

% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run DAT_jiema;

% --- Executes on button press in decodematter.
function decodematter_Callback(hObject, eventdata, handles)
% hObject    handle to decodematter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PathName_gx = 0;
load file_gx; 
if( length(PathName_gx) == 1)             
    [FileName_gx,PathName_gx] = uigetfile('E:\*.xls');
else                                  
    [FileName_gx,PathName_gx] = uigetfile([PathName_gx,'\*.xls'],'Pick File');
end

if(PathName_gx == 0)
    msgbox('未选择文件！！！');
    return;    
end

save file_gx PathName_gx FileName_gx; 

msgbox('转化关系已选定!');

% --- Executes on button press in Spectrum.
function Spectrum_Callback(hObject, eventdata, handles)
% hObject    handle to Spectrum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
lines =sort(  get(gca,'children'));
displaynames = get(lines,'displayname');
if isempty(displaynames)
    msgbox('没有选定DIY的对象！');
    return;
end
[ss,vs]=listdlg('PromptString','选择数据','ListString',displaynames);
if isempty(ss)
    msgbox('没有选定DIY的对象！');
    return;
end

listtext='';
linecolor=['b','r','g','k','c'];
line_style=['-','+','o','*','x'];
x_lim = get(gca,'xlim');
min_x = x_lim(1);
max_x = x_lim(end);
for i =1:length(ss)
    x=get(lines(ss(i)),'xdata');
    y=get(lines(ss(i)),'ydata');
    index = x >= min_x & x <= max_x;
    x = x(index);
    y = y(index);
    Fs = floor(1/mean(diff(x)));                    % Sampling frequency
    L = length(y);                     % Length of signal
    NFFT = 2^nextpow2(L); % Next power of 2 from length of y
    Y = fft(y,NFFT)/L;
    f{i} = Fs/2*linspace(0,1,NFFT/2+1);
    Spectrum{i} = 100*2*abs(Y(1:NFFT/2+1));
    listtext{i}=get(lines(ss(i)),'Displayname');
    % Plot 1single-sided amplitude spectrum.
end
figure('name','Spectrum Anaylaze');
xlabel('Frequency (Hz)');
ylabel('|Y(f)|');
grid on;
len = length(ss);
if (len~=0)
    for i=1:len
        line(f{i},Spectrum{i},'color',linecolor(i-5*floor((i-1)/5)),'linestyle',line_style(ceil(i/5)),'linewidth',2);
    end
    grid on;
    lgd = legend(listtext);
end

% --- Executes on selection change in DataList9.
function DataList9_Callback(hObject, eventdata, handles)
% hObject    handle to DataList9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns DataList9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DataList9


% --- Executes during object creation, after setting all properties.
function DataList9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DataList9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function index = GetFirstNoBlank(handles)
flag = find(handles.index_DataList == 0);
if isempty(flag)
    h = msgbox('列表框已满，请删除一个列表后重新添加！！');
    uiwait(h);
    index = 1e10;
    return;
else
    index = flag(1);%返回第一个为false的索引
end
function index = GetLastNoBlank(handles)
flag = find(handles.index_DataList == 1);
if isempty(flag)
%     h = msgbox('列表框已空！！');
%     uiwait(h);
    index = -1e10;
    return;
else
    index = max(flag);%返回第一个为false的索引
end

function textdisp = TextDispProcess(a)
global StrSplit
%数据头部文字行与数据列数的对齐操作
size_data = size(a.data);
size_datacol = size_data(1,2);
size_textdata = size(a.textdata);
size_textrow = size_textdata(1,1);
if(size_textrow >= 1)
    %如果数据文件中的文字表头多于两行，那么取第一行
    if(size_textrow ~= 1)
        a.textdata = a.textdata{1};
    end
    [textdisp size_textlen] = StringParts(a.textdata,0);
    textdisp=textdisp(1:size_textlen);
    if (size_datacol > size_textlen)
        for j = (size_textlen + 1):1:size_datacol
            textdisp{j} = ['col' num2str(j)];
        end
    else
        textdisp = textdisp(1:size_datacol);
    end
    textdisp(strcmp(textdisp(1:end),'')==1)=[];
else
    for j = 1:1:size_datacol
        textdisp{j} = ['col' num2str(j)];
    end
end
StrSplit = cell(1,200);
function [textdisp size_len] = StringParts(str,k)
%分割数据文件头部的文字行，返回除去空格的文字行。
global StrSplit
try
    regresult = regexp(char(str),'\s+','split');
    regresult(strcmp(regresult(1:end),'')==1)=[];
    size_textlen = length(regresult);
    if(size_textlen > 1)
        for i =1:size_textlen
            [StrSplit k]=StringParts(regresult{i},k);
        end
    end
    if(size_textlen == 1)
        k=k+1;
        StrSplit(k) = regresult;
    end
    textdisp = StrSplit;
    size_len = k;
catch ex
    regresult = regexp(str,'\s+','split');
    regresult(strcmp(regresult(1:end),'')==1)=[];
    size_len = length(regresult);
    if(size_len > 1)
        for i =1:size_len
            [StrSplit k]=StringParts(regresult{i},k);
        end
    end
    if(size_len == 1)
        k=k+1;
        StrSplit(k) = regresult;
    end
    textdisp = StrSplit;
    size_len = k;
end


function [ts textdisp]= GenerateTimeSeries(a)
data = a.data;
textdisp =  TextDispProcess(a);
data_size = size(data);
data_row = data_size(1);
data_col = data_size(2);
% if data_col < 2
%     ts{1,1} = timeseries(data(:,1),1:data_row,'Name',[char(textdisp(1)) '-' a.name]);
%     textdisp =['stdIndex' textdisp];
% else
%     %change point
%     for i = 1:(data_col-1)%从2开始，不需要时间列
%         ts{1,i} = timeseries(data(:,i+1),data(:,1),'Name',[char(textdisp(i+1)) '-' a.name]);
%     end
% end
if data_col < 2
    ts{1,1}.time = 1:data_row;
    ts{1,1}.data = data(:,1);
    ts{1,1}.name = [char(textdisp(1)) '-' a.name];
    ts{1,1}.name0 = [char(textdisp(1))];
    textdisp=['stdIndex' textdisp];
else
    for i = 1:(data_col-1)
        ts{1,i}.time = data(:,1);                                           % Change The First Col
        ts{1,i}.data = data(:,i+1);
        ts{1,i}.name = [char(textdisp(i+1)) '-' a.name];
        ts{1,i}.name0 = [char(textdisp(i+1))];
    end
end



function [data textfh FileStr] = ImportDataFile2(FilePath) %#ok<DEFNU>
%如果ModeSelect为2，第一个参数为文件夹路径
iniFileName = strcat(FilePath,'\IM.ini');
fid = fopen(iniFileName);
text= cell(1,500);
tsc = cell(1,500);
index = 1;
if fid < 0
    msgbox('没有配置文件！');
end
while 1
    tline = fgetl(fid);
    if (~ischar(tline) || isempty(tline))
        break;
    end
    [ts textdisp]= ImportSigleDataFile(strcat(FilePath,'\',tline));
    text(index:index + length(textdisp)-1) = textdisp; %去掉时间列
    text(index + length(textdisp))='';%两个文件之间用一个空格隔开
    tsc(index:index + length(textdisp)-1) = ts;
    tsc{1,index + length(textdisp)} = timeseries(0,0,'Name','标准分隔符');
    index = index + length(textdisp) + 1;
end
fclose(fid);
data.data1 = tsc(1:index-2);%去掉了最后一行添加的分隔符
textfh.text1 = text(1:index-2);
FileStr.FileStr1 = FilePath;
function [data textfh FileStr] = ImportDataFile3(name,path,len) %#ok<DEFNU>
%如果ModeSelect为3
text= cell(1,500);
tsc = cell(1,500);
index = 1;
for kk=1:len
    if(iscellstr(name))
        tempfile = strcat(path,name(kk));
    else
        tempfile = strcat(path,name);
    end
    tempfile = char(tempfile);
    [ts textdisp]= ImportSigleDataFile(tempfile);
    text(index:index + length(textdisp)-1) = textdisp; %去掉时间列
    text(index + length(textdisp))='';%两个文件之间用一个空格隔开
    tsc(index:index + length(textdisp)-1) = ts;
    tsc{1,index + length(textdisp)} = timeseries(0,0,'name','标准分隔符');
    index = index + length(textdisp) + 1;
end
data.data1 = tsc(1:index-2);%去掉了最后一行添加的分隔符
textfh.text1 = text(1:index-2);
FileStr.FileStr1 = path;

function [data textfh FileStr] = ImportDataFile1(name,path,len) %#ok<DEFNU>
%如果ModeSelect为1
text= cell(1,500);
tsc = cell(len,500);
for kk=1:len
    if(iscellstr(name))
        tempfile = strcat(path,name(kk));
    else
        tempfile = strcat(path,name);
    end
    tempfile = char(tempfile);
    [ts textdisp]= ImportSigleDataFile(tempfile);
    text(1:length(textdisp)) = textdisp;
    tsc(kk,1:length(textdisp)) = ts;
end
data.data1 = tsc(:,1:length(textdisp));%
textfh.text1 = text(1:length(textdisp)); %去掉时间列
FileStr.FileStr1 = path;


function [data text FileStr] = ImportDataFile4(name,path,len) %#ok<DEFNU>
%如果ModeSelect为4
for kk=1:len
    if(iscellstr(name))
        tempfile = strcat(path,name(kk));
    else
        tempfile = strcat(path,name);
    end
    tempfile = char(tempfile);
    [ts textdisp]= ImportSigleDataFile(tempfile);
    text.(['text' num2str(kk)]) = textdisp;
    data.(['data' num2str(kk)]) = ts;
    FileStr.(['FileStr' num2str(kk)]) = tempfile;
end

function [ts textdisp] = ImportSigleDataFile(FilePath) %#ok<DEFNU>
%返回一个结构体，至少包含两个成员，一个是数据data,一个是字符textdata。
% data = importdata(FilePath,'\t',6);
data = importdata(FilePath);
% fid = fopen(FilePath);
% for i = 1:39
%     fgetl(fid);
% end;
% data = fscanf(fid,'%f',[1 inf]);
% data=data';
% fclose(fid);

type = whos('data');
if ~strcmp(type.class, 'struct')
    if(isnumeric(data))
        a.data = single(data);
        a.textdata = '';
    else
        [textdisp size_len] = StringParts(data,0);
        a.textdata = textdisp(1:size_len);
        a.data = zeros(1,size_len);
    end
else
    %     a = data;
    a.data = single(data.data);
    a.textdata = data.textdata;
end
[pathstr, name, ext] = fileparts(FilePath);
a.name = name;%获取文件名
[ts textdisp]= GenerateTimeSeries(a);
textdisp = textdisp(2:end);


% --- Executes on button press in PlotRest.
function PlotRest_Callback(hObject, eventdata, handles)
% hObject    handle to PlotRest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.axes1;       %将原来的多幅图显示改为单图显示
subplot(1,1,1);
cla reset;        %清图并坐标重置
grid on;
all_list = findobj('style','listbox','visible','on');
blank_list = findobj('style','listbox','string',[],'visible','on');
hasvalue_list = setdiff(all_list,blank_list);
set(hasvalue_list,'value',[]);
set(handles.SetX,'BackgroundColor',[0.925 0.914 0.847]);
set(handles.SetY,'BackgroundColor',[0.925 0.914 0.847]);



function Lingwei_Callback(hObject, eventdata, handles)
% hObject    handle to Lingwei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Lingwei as text
%        str2double(get(hObject,'String')) returns contents of Lingwei as a double


% --- Executes during object creation, after setting all properties.
function Lingwei_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Lingwei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Tuoluojifen.
function Tuoluojifen_Callback(hObject, eventdata, handles)
% hObject    handle to Tuoluojifen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guangxiantuoluojifen(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function xlabel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xlabel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Setx2.
function Setx2_Callback(hObject, eventdata, handles)
% hObject    handle to Setx2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% mxfs_KZ03_AKF9diyicibihuan_fzls;
mxfs_KZ03_AKF9disicibihuan_fzls;


% --- Executes on button press in dataplus.
function dataplus_Callback(hObject, eventdata, handles)
% hObject    handle to dataplus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
y1y2_minus;


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
all_list = findobj('style','listbox','visible','on');
blank_list = findobj('style','listbox','string',[],'visible','on');
hasvalue_list = setdiff(all_list,[blank_list handles.FileList]);
list_vv = get(hasvalue_list,'value');
if(iscell(list_vv))
    list_v = list_vv;
else
    list_v{1} = list_vv;
end
list_n = 0;
for i=1:length(list_v)
    try
        if ~isempty(list_v{i})
            list_n = list_v{i};
            hasvalue_list_n = hasvalue_list(i);  
            
            DataList_str = get(hasvalue_list_n,'tag');
            NH =  length(handles.(['data' DataList_str(9)]));
            for k = 1:NH
               if( length(handles.(['data' DataList_str(9)]){k}.name) == 5  && sum( handles.(['data' DataList_str(9)]){k}.name == '标准分隔符') == 5)
                    msgbox('同一个List内数据格式需一致！！！');
                   return;
               end
            end
            for k=1:NH
                handles.(['data' DataList_str(9)]){k}.z2 = handles.(['data' DataList_str(9)]){list_n(1)}.data;   
                handles.(['data' DataList_str(9)]){k}.namez = handles.(['data' DataList_str(9)]){list_n(1)}.name0;%x轴名称
            end
            
            
        end
    end

    
end
if (list_n == 0)
    msgbox('请指定Z数据！！！');
    return;
end
guidata(hObject,handles);


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 曲线滤波
run LBQ_Butterworth;


% --- Executes during object deletion, before destroying properties.
 function ModeSelect_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to ModeSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over ModeSelect.
% function ModeSelect_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to ModeSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on ModeSelect and none of its controls.
% function ModeSelect_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ModeSelect (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
