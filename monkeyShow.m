function varargout = monkeyShow(varargin)
% MONKEYSHOW MATLAB code for monkeyShow.fig
%      MONKEYSHOW, by itself, creates a new MONKEYSHOW or raises the existing
%      singleton*.
%
%      H = MONKEYSHOW returns the handle to a new MONKEYSHOW or the handle to
%      the existing singleton*.
%
%      MONKEYSHOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MONKEYSHOW.M with the given input arguments.
%
%      MONKEYSHOW('Property','Value',...) creates a new MONKEYSHOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before monkeyShow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to monkeyShow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help monkeyShow

% Last Modified by GUIDE v2.5 12-Aug-2019 17:58:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @monkeyShow_OpeningFcn, ...
                   'gui_OutputFcn',  @monkeyShow_OutputFcn, ...
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



function MemoryTimerFcn(~,~,handles,hobj,mainhandles)
    

    hobj.UserData = hobj.UserData + 1;
    
    if(hobj.UserData > handles.totalTime)
        stop(mainhandles.MemoryTimer);
        delete(mainhandles.MemoryTimer);
        delete(handles.figure1); 
        disp('OVER!');
    end

    index = handles.timeseries(hobj.UserData);
    
    if(index > 0)
        imshow(handles.passData(index).picture, 'Parent', handles.display);
      %imagesc(app.ImageAxes, app.passData(index).picture);
    elseif(index < 0)
        imshow(handles.intervalImage,'Parent', handles.display);
      %imagesc(app.ImageAxes, app.intervalImage);
    end
end


% --- Executes just before monkeyShow is made visible.
function monkeyShow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to monkeyShow (see VARARGIN)

% Choose default command line output for monkeyShow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes monkeyShow wait for user response (see UIRESUME)
% uiwait(handles.figure1);

mainGuiInput = find(strcmp(varargin, 'mainapp'));
if (~isempty(mainGuiInput))
    mainhandles = varargin{mainGuiInput+1};
    
    hObject.UserData = 0;
    
    passData = mainhandles.passData;
    handles.passData = passData;
    handles.timeseries =  passData(1).timeseries;
    handles.totalTime = passData(1).totalTime;
    handles.intervalImage = passData(1).intervalImage;
   
    timer = mainhandles.MemoryTimer;
    set(timer, 'TimerFcn',{@MemoryTimerFcn,handles,hObject,mainhandles } );
    guidata(hObject,handles);
    
    set(handles.display,'visible','off');
    axis(handles.display, 'image');
    %start(timer);
end

end

% --- Outputs from this function are returned to the command line.
function varargout = monkeyShow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% START USER CODE
% Necessary to provide this function to prevent timer callback
% from causing an error after GUI code stops executing.
% Before exiting, if the timer is running, stop it.
if strcmp(get(handles.MemoryTimer, 'Running'), 'on')
    stop(handles.MemoryTimer);
end
% Destroy timer
delete(handles.MemoryTimer)
% END USER CODE

% Hint: delete(hObject) closes the figure
delete(hObject);
end


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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
        set(gcf, 'Units', 'pixels');
        WindowAPI(gcf,'Position', 'full');
    elseif(strcmp(eventdata.Key ,'escape'))
        WindowAPI(gcf,'Maximize');
    end
end
