function varargout = monkey(varargin)
% MONKEY MATLAB code for monkey.fig
%      MONKEY, by itself, creates a new MONKEY or raises the existing
%      singleton*.
%
%      H = MONKEY returns the handle to a new MONKEY or the handle to
%      the existing singleton*.
%
%      MONKEY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MONKEY.M with the given input arguments.
%
%      MONKEY('Property','Value',...) creates a new MONKEY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before monkey_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to monkey_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help monkey

% Last Modified by GUIDE v2.5 12-Aug-2019 18:46:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @monkey_OpeningFcn, ...
                   'gui_OutputFcn',  @monkey_OutputFcn, ...
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
end

% --- Executes just before monkey is made visible.
function monkey_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to monkey (see VARARGIN)

% Choose default command line output for monkey
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes monkey wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = monkey_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
end

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    path = uigetdir;
    setappdata(hObject.Parent,'path',path);
    if (ischar(path))
        h = findobj('Tag','edit1');
        h.String = path;
        files = dir(fullfile(path, '*.*'));
        picture = cell(1,length(files));
        for i = 1:length(files)-2
            filename = fullfile(path, files(i+2).name);
            pic = imread(filename);
            picture{i} = pic;
        end
       %hObject.UserData = picture;
       setappdata(hObject.Parent.Parent,'pictures',picture);
       setappdata(hObject.Parent.Parent,'files',files);
       %h.UserData = files;
    end
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

    value = str2num(hObject.String);
    hObject.Value = value;
end

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
    value = hObject.String;
    h = findobj('Tag','radiobutton4');
    if (get(h,'Value') == get(h,'Max'))
        num = []
        for i = 1 : length(value)
            if(strcmp(value(i),',') == 0)
                num = [num, str2num(value(i))];
            end
        end
        hObject.UserData = num;
    else
        hObject.Value = str2num(value);
    end
end

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
        files =  getappdata(hObject.Parent.Parent,'files');
        number = length(files) - 2;
        
        index = randperm(number,number);

        showTimeObj = findobj('Tag','edit2');
        showTime = showTimeObj.Value;

        radioButton4Obj = findobj('Tag', 'radiobutton4');
        radioButton2Obj = findobj('Tag', 'radiobutton2');
        
        if(get(radioButton2Obj,'Value') == get(radioButton2Obj,'Max'))
            intervalNum = zeros(1,number,'int32');
        else
            h1 = findobj('Tag','edit3');
            if(get(radioButton4Obj,'Value') == get(radioButton4Obj,'Max'))       
                intervalSize = length(h1.UserData);
                index2 = randi([1 intervalSize],1,number);
                intervalNum = zeros(1,number,'int32');
               
                for i = 1 : number
                    intervalNum(i) = h1.UserData(index2(i));
                end
                %disp(intervalNum);
            else
                intervalNum = zeros(1,number,'int32');
                for i = 1 : number
                    intervalNum(i) = h1.Value;              
                end
                %disp(intervalNum);
            end
        end
        
        totalTime = int32(number * showTime);
            
        for i = 1 : number
            totalTime = totalTime + intervalNum(i);
        end

        intervalImage = imread('C:\Users\93933\Documents\MATLAB\Examples\R2019a\matlab\MortgageCalculatorExample\intervalmage\interval.png');

        timeseries = zeros(1,totalTime * 4,'int32');
        output = zeros(1,totalTime,'int32');
        currTime = 1;
        currTime2 = 1;
        
        for i = 1 : number
            for j = 1 : showTime
                timeseries(currTime2) = index(i);
                timeseries(currTime2 + 1) = -1;
                timeseries(currTime2 + 2) = index(i);
                timeseries(currTime2 + 3) = -1;

                currTime2 = currTime2 + 4;
            end

            timeseries(currTime2) = -1;
            timeseries(currTime2 + 1  : currTime2 + 4 * intervalNum(i) - 1) = 0;

            output(currTime : currTime + showTime - 1) = index(i);
            output(currTime + showTime : currTime + showTime + double(intervalNum(i)) - 1) = -1;

            currTime = currTime + showTime + double(intervalNum(i));
            currTime2 = currTime2 + 4 * intervalNum(i);
        end
        
        repeatTimeObj = findobj('Tag','edit6');
        repeat_series = zeros(1, repeatTimeObj.Value * length(timeseries),'int32' );
        for i = 1 : repeatTimeObj.Value
            repeat_series( 1 + (i - 1) * length(timeseries) : i * length(timeseries) ) = timeseries;
        end
        
        str = datestr(datetime('now'));
        filen = [str, '.txt'];
        filen = strrep(filen,'-',' ');
        filen = strrep(filen,':',' ');
        if(~exist('.\monkey_data_txt','dir'))
            mkdir('.\monkey_data_txt');
        end
        path = ['.\monkey_data_txt\', filen];
        fid = fopen(path, 'w');
        fprintf(fid, '%d ', output);
        fprintf(fid, '\r\n');
        fprintf(fid, 'showTime: %d \r\n', showTime);
        fprintf(fid, 'Interval Time: \r\n');
        for i = 1 : number
            fprintf(fid, '%d \r\n', intervalNum(i));
        end
        fprintf(fid, '\r\n');
        for i = 1 : number
            fprintf(fid, ' %d: %s \r\n', i, files(i+2).name);
        end    
        fclose(fid);

        filen2 = [str,'.mat'];
        filen2 = strrep(filen2,'-',' ');
        filen2 = strrep(filen2,':',' ');
        if(~exist('./monkey_data_mat','dir'))
            mkdir('.\monkey_data_mat');
        end
        
        path2 = ['.\monkey_data_mat\', filen2];
        strc = files;
        save(path2,'output','showTime','intervalNum','strc');
        
        picture = getappdata(hObject.Parent.Parent,'pictures');
        %handles = guidata(hObject);
        handles.passData = struct('totalTime', totalTime*4*repeatTimeObj.Value,'timeseries',repeat_series,'picture',picture,'intervalImage',intervalImage );
        
        handles.MemoryTimer = timer(...
        'ExecutionMode', 'fixedRate', ...    % Run timer repeatedly
        'Period', 0.25, ...                     % Period is 1 second
        'BusyMode', 'queue',...              % Queue timer callbacks when busy
        'Tag', 'monkeyTimer');    % Specify callback function  
        
        guidata(hObject,handles);
        monkeyShow('mainapp',handles);
        
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA);
    start(handles.MemoryTimer);
end


% --- Executes on key release with focus on figure1 or any of its controls.
function figure1_WindowKeyReleaseFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was released, in lower case
%	Character: character interpretation of the key(s) that was released
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) released
% handles    structure with handles and user data (see GUIDATA)
 if(strcmp(eventdata.Key ,'return'))    
    start(handles.MemoryTimer);
 end
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double
    value = hObject.String;
    hObject.Value = str2num(value);
end

% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end