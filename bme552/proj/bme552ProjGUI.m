function varargout = bme552ProjGUI(varargin)
% BME552PROJGUI M-file for bme552ProjGUI.fig
%      BME552PROJGUI, by itself, creates a new BME552PROJGUI or raises the existing
%      singleton*.
%
%      H = BME552PROJGUI returns the handle to a new BME552PROJGUI or the handle to
%      the existing singleton*.
%
%      BME552PROJGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BME552PROJGUI.M with the given input arguments.
%
%      BME552PROJGUI('Property','Value',...) creates a new BME552PROJGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bme552ProjGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bme552ProjGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bme552ProjGUI

% Last Modified by GUIDE v2.5 21-Apr-2013 15:16:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bme552ProjGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @bme552ProjGUI_OutputFcn, ...
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

% --- Executes just before bme552ProjGUI is made visible.
function bme552ProjGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bme552ProjGUI (see VARARGIN)

% Choose default command line output for bme552ProjGUI
handles.output = hObject;
handles.whichElectrode = 1;

global electrode
electrode=[];
electrode(1).radius =0.005;
electrode(1).tissueR=200;
electrode(1).parallelR = 1;
electrode(1).rough = 1;
electrode(1).cap = 40;
electrode(1).material =1;
electrode(1).voltage = 0;
electrode(1).location = [0 0]; %xy coord.

%diagnostics

disp(electrode(1));




% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using bme552ProjGUI.
if strcmp(get(hObject,'Visible'),'off')
    updatePositionFigure(1);
end

% UIWAIT makes bme552ProjGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = bme552ProjGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% ------------------------------------------------
% --------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end
global electrode
delete(electrode); delete(handles.axes1);
delete(handles.figure1)



% --- Executes on selection change in electrodeSelector.
function electrodeSelector_Callback(hObject, eventdata, handles)
% hObject    handle to electrodeSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns electrodeSelector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from electrodeSelector

global electrode
contents   = get(hObject,'String')

if iscell(contents)
    curntString= contents{get(hObject,'Value')}
    ndx=double(curntString(end))-64;
else
    ndx=double(contents(end))-64;
end

handles.whichElectrode = ndx;

%restore GUI fields to electrode characteristics
params=electrode(ndx);
set(handles.electrodeRadius,'String',num2str(params.radius));
set(handles.tissueResistivity,'String',num2str(params.tissueR));
set(handles.rParallel,'String',num2str(params.parallelR));
set(handles.roughFactor,'String',num2str(params.rough));
set(handles.unitaryCapacitance,'String',num2str(params.cap));
set(handles.materialType,'Value',params.material);
% set(handles.voltage,'String',num2str(params.tissueR));
set(handles.xPos,'String',num2str(params.location(1)));
set(handles.yPos,'String',num2str(params.location(2)));

updatePositionFigure(ndx);

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function electrodeSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to electrodeSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function electrodeVoltage_Callback(hObject, eventdata, handles)
% hObject    handle to electrodeVoltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of electrodeVoltage as text
%        str2double(get(hObject,'String')) returns contents of electrodeVoltage as a double

global electrode
ndx=handles.whichElectrode;
electrode(ndx).voltage = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function electrodeVoltage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to electrodeVoltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function heightMax_Callback(hObject, eventdata, handles)
% hObject    handle to heightMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of heightMax as text
%        str2double(get(hObject,'String')) returns contents of heightMax as a double


% --- Executes during object creation, after setting all properties.
function heightMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to heightMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pulseStart_Callback(hObject, eventdata, handles)
% hObject    handle to pulseStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pulseStart as text
%        str2double(get(hObject,'String')) returns contents of pulseStart as a double


% --- Executes during object creation, after setting all properties.
function pulseStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pulseStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pulseWidth_Callback(hObject, eventdata, handles)
% hObject    handle to pulseWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pulseWidth as text
%        str2double(get(hObject,'String')) returns contents of pulseWidth as a double


% --- Executes during object creation, after setting all properties.
function pulseWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pulseWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pulseAmp_Callback(hObject, eventdata, handles)
% hObject    handle to pulseAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of pulseAmp as text
%        str2double(get(hObject,'String')) returns contents of pulseAmp as a double


% --- Executes during object creation, after setting all properties.
function pulseAmp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pulseAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function simDur_Callback(hObject, eventdata, handles)
% hObject    handle to simDur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of simDur as text
%        str2double(get(hObject,'String')) returns contents of simDur as a double


% --- Executes during object creation, after setting all properties.
function simDur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to simDur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stFreq_Callback(hObject, eventdata, handles)
% hObject    handle to stFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stFreq as text
%        str2double(get(hObject,'String')) returns contents of stFreq as a double


% --- Executes during object creation, after setting all properties.
function stFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function endFreq_Callback(hObject, eventdata, handles)
% hObject    handle to endFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endFreq as text
%        str2double(get(hObject,'String')) returns contents of endFreq as a double


% --- Executes during object creation, after setting all properties.
function endFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function electrodeRadius_Callback(hObject, eventdata, handles)
% hObject    handle to electrodeRadius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of electrodeRadius as text
%        str2double(get(hObject,'String')) returns contents of electrodeRadius as a double

global electrode

ndx=handles.whichElectrode;
rad=str2double(get(hObject,'String'));
electrode(ndx).radius = rad;

updatePositionFigure(ndx);


% --- Executes during object creation, after setting all properties.
function electrodeRadius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to electrodeRadius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tissueResistivity_Callback(hObject, eventdata, handles)
% hObject    handle to tissueResistivity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tissueResistivity as text
%        str2double(get(hObject,'String')) returns contents of tissueResistivity as a double

global electrode

ndx=handles.whichElectrode;
res=str2double(get(hObject,'String'));
electrode(ndx).tissueR = res;

% --- Executes during object creation, after setting all properties.
function tissueResistivity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tissueResistivity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in materialType.
function materialType_Callback(hObject, eventdata, handles)
% hObject    handle to materialType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns materialType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from materialType

global electrode

ndx=handles.whichElectrode;
matIndex=get(hObject,'Value');
electrode(ndx).material = matIndex;


% --- Executes during object creation, after setting all properties.
function materialType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to materialType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rParallel_Callback(hObject, eventdata, handles)
% hObject    handle to rParallel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rParallel as text
%        str2double(get(hObject,'String')) returns contents of rParallel as a double

global electrode
ndx=handles.whichElectrode;
electrode(ndx).parallelR = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function rParallel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rParallel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function safetyShannon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to safetyShannon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function safetyCharge_CreateFcn(hObject, eventdata, handles)
% hObject    handle to safetyCharge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function safetyComplianceV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to safetyComplianceV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in computeSafety.
function computeSafety_Callback(hObject, eventdata, handles)

%Get Parmeters
radiusInCM = str2double(get(handles.electrodeRadius,'String')); % in cm
areaInCM2 = pi * radiusInCM * radiusInCM; %in cm^2
disp('Elec Area (cm^2): '); disp(areaInCM2);

duration = str2double(get(handles.pulseWidth,'String'))*1e-3; %to seconds
disp('Pulse Duration (s): '); disp(duration);

currentInMicro = str2double(get(handles.pulseAmp,'String')); %microCoulombs
currentInMilli = str2double(get(handles.pulseAmp,'String'))*1e-3; %to milliCoulombs
disp('Current in uC: '); disp(currentInMicro);
disp('Current in mC: '); disp(currentInMilli);

%%%%%%%%%%%%%%%%% SHANNON SAFETY COMPUTATION %%%%%%%%%%%%%%%%%%%%%%
k = 1.6; %constant for Shannon Neural Damage Model (safe range)
Quc = currentInMicro * duration; %charge in microCoulombs
shannonLimit = log(Quc/areaInCM2); % microCoulomb/cm^2
disp('left shannon: '); disp(shannonLimit);
shannonThresh = k - log(Quc);
disp('right shannon: '); disp(shannonThresh);
if (shannonLimit <= shannonThresh) 
    set(handles.safetyShannon, 'Value', 1, 'Enable', 'inactive',...
        'ForegroundColor',[.1 .7 .3],'FontWeight','bold');
else 
    set(handles.safetyShannon, 'Value', 0, 'Enable', 'off','FontWeight','normal');
    
end

%%%%%%%%%%%%%%%%%%% CHARGE INJECTION %%%%%%%%%%%%%%%
%below is if we need to do something dependent on material....
%chargeInj = (current * 10^(-3) * duration) / handles.area;
%materialTypeContents = get(handles.materialType,'String');
%material = materialTypeContents{get(handles.materialType,'Value')};
%disp(chargeInj);
% if (strcmp(material, 'Platinum') == 1 && chargeInj >= 0.1 && chargeInj <= 0.35) 
%     set(handles.safetyCharge, 'String', 'Pt, Yes');
% end
% 
% if (strcmp(material, 'Platinum-Iridium') == 1 && chargeInj >= 0.22 && chargeInj <= 0.3) 
%     set(handles.safetyCharge, 'String', 'PtIr, Yes');
% end
% 
% if (strcmp(material, 'AIROF') == 1 && chargeInj >= 2 && chargeInj <= 3) 
%     set(handles.safetyCharge, 'String', 'AIROF, Yes');
% end
% 
% if (strcmp(material, 'SIROF') == 1 && chargeInj >= 3.4 && chargeInj <= 7.5) 
%     set(handles.safetyCharge, 'String', 'SIROF, Yes');
% end

%Get parameters
Rp = str2double(get(handles.rParallel,'String'))*1e6;   % To Ohms
Cm = str2double(get(handles.unitaryCapacitance,'String'))/100;  % to F/m^2
rho = str2double(get(handles.tissueResistivity,'String'))/100;  % to Ohms*m
radius = str2double(get(handles.electrodeRadius,'String'))/100; % to m
A = pi * radius^2; % m^2
rough = str2double(get(handles.roughFactor,'String'));
C = Cm*A*rough; % Cdl (in Farads)
Rtiss = rho/(4*radius); % in Ohms
pulseAmp = str2double(get(handles.pulseAmp,'String'))/1e6; % to A

%Compute max voltage at end of pulse
maxVoltage = pulseAmp*Rtiss + pulseAmp*Rp*(1 - exp(-duration/(Rp*C)));

%check if within electrochemical limits (water window)
waterWindow = str2double(get(handles.waterWindowMax,'String')) - str2double(get(handles.waterWindowMin, 'String'));
disp('waterWindow (V): '); disp(waterWindow);
if (maxVoltage <= waterWindow) 
    set(handles.safetyCharge, 'Value', 1, 'Enable', 'inactive',...
        'ForegroundColor',[.1 .7 .3],'FontWeight','bold');
else 
    set(handles.safetyCharge, 'Value', 0, 'Enable', 'off','FontWeight','normal');
end

%check if within compliance voltage limit
disp('maxVoltage (V): '); disp(maxVoltage);
disp('compVoltage (V): '); disp(get(handles.compVoltage, 'String'));
if (abs(maxVoltage) <= str2double(get(handles.compVoltage, 'String'))) % account for +/-(maxVoltage)
    set(handles.safetyComplianceV, 'Value', 1, 'Enable', 'inactive',...
        'ForegroundColor',[.1 .7 .3],'FontWeight','bold');
else 
    set(handles.safetyComplianceV, 'Value', 0, 'Enable', 'off','FontWeight','normal');
end

guidata(hObject, handles);
% hObject    handle to computeSafety (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxRadius_Callback(hObject, eventdata, handles)
% hObject    handle to maxRadius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxRadius as text
%        str2double(get(hObject,'String')) returns contents of maxRadius as a double


% --- Executes during object creation, after setting all properties.
function maxRadius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxRadius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in simulateImpedance.
function simulateImpedance_Callback(hObject, eventdata, handles)
% hObject    handle to simulateImpedance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Rp = str2double(get(handles.rParallel,'String'))*1e6;   % To Ohms
Cm = str2double(get(handles.unitaryCapacitance,'String'))/100;  % to F/m^2
rho = str2double(get(handles.tissueResistivity,'String'))/100;  % to Ohms*m
radius = str2double(get(handles.electrodeRadius,'String'))/100; % to m
rough = str2double(get(handles.roughFactor,'String'));
fstart = str2double(get(handles.stFreq,'String'));
fend = str2double(get(handles.endFreq,'String'));
[Z f] = impedanceResponse(Rp,Cm,rho,radius,rough,fstart,fend);
% Plot in new figure.
figure('Name','Impedance Response');
subplot(2,1,1);
loglog(f,abs(Z));
title('Impedance modulus');
xlabel('log f'); ylabel('log |Z|');
 
% Plot angle against log frequency.
subplot(2,1,2);
semilogx(f, angle(Z));
title('Impedance phase');
xlabel('log f'); ylabel('phase');


function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to simDur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of simDur as text
%        str2double(get(hObject,'String')) returns contents of simDur as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to simDur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in simulatePulse.
function simulatePulse_Callback(hObject, eventdata, handles)
% hObject    handle to simulatePulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Rp = str2double(get(handles.rParallel,'String'))*1e6;   % To Ohms
Cm = str2double(get(handles.unitaryCapacitance,'String'))/100;  % to F/m^2
rho = str2double(get(handles.tissueResistivity,'String'))/100; % to Ohm*m
radius = str2double(get(handles.electrodeRadius,'String'))/100; % to m
rough = str2double(get(handles.roughFactor,'String'));
t0 = str2double(get(handles.pulseStart,'String'))/1000; % to s
T = str2double(get(handles.pulseWidth,'String'))/1000; % to s
pulseAmp = str2double(get(handles.pulseAmp,'String'))/1e6; % to A
tend = str2double(get(handles.simDur,'String'))/1000; % to s
% Plot
figure('Name','Pulse Response');
% figure(handles.axes1);
[V I t] = pulseResponse(Rp, Cm, rho, radius, rough, t0, T, pulseAmp, tend);
subplot(2,1,1);
plot(t,I);
axis([t(1) t(end) 0 2*max(I)]);
title('Current Pulse'); xlabel('Time (s)'); ylabel('Current (uA)');
subplot(2,1,2);
plot(t,V);
title('Voltage Response'); xlabel('Time (s)'); ylabel('Voltage (V)');



function roughFactor_Callback(hObject, eventdata, handles)
% hObject    handle to roughFactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roughFactor as text
%        str2double(get(hObject,'String')) returns contents of roughFactor as a double

global electrode
ndx=handles.whichElectrode;
electrode(ndx).rough = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function roughFactor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roughFactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function unitaryCapacitance_Callback(hObject, eventdata, handles)
% hObject    handle to unitaryCapacitance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of unitaryCapacitance as text
%        str2double(get(hObject,'String')) returns contents of unitaryCapacitance as a double

global electrode
ndx=handles.whichElectrode;
electrode(ndx).cap = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function unitaryCapacitance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to unitaryCapacitance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function radMaxFactor_Callback(hObject, eventdata, handles)
% hObject    handle to radMaxFactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radMaxFactor as text
%        str2double(get(hObject,'String')) returns contents of radMaxFactor as a double


% --- Executes during object creation, after setting all properties.
function radMaxFactor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radMaxFactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in simulateElectricField.
function simulateElectricField_Callback(hObject, eventdata, handles)
% hObject    handle to simulateElectricField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global electrode
ndx=handles.whichElectrode;

radiusFactor = str2double(get(handles.radMaxFactor,'String'))*1e-3; %to m
heightMax = str2double(get(handles.heightMax,'String'))*1e-3; % to m
electrodeV = str2double(get(handles.electrodeVoltage,'String'));

for ii = 1:length(electrode)
    radz(ii)=electrode(ii).radius/100;
    xes(ii)=electrode(ii).location(1)/100;
    ys(ii)=electrode(ii).location(2)/100;
end
Mspacing=min(radz)/20;
Mx=[min(xes)-radiusFactor max(xes)+radiusFactor];
My=[min(ys)-radiusFactor max(ys)+radiusFactor];

[x y z M] = electricField(radz,electrodeV,[Mx My],heightMax,Mspacing,[xes' ys']);

% Plot initially at height index 'init'.
figure('Name','Electric Field Intensity');
init = 2;
mesh(y,x,M(:,:,init));    
range = [min(x) max(x) min(y) max(y) 0 max(max(max(M)))];
axis(range);
title('Electric Field Intensity');
xlabel('x'); ylabel('y'); zlabel('E (V/m)');

% We add a slider on the side to adjust the height we're showing E for.
t=uicontrol('style','text','position',[5 360 100 35],'String',...
    sprintf('Distance from Electrode: %f mm',z(2)*1000));
h=uicontrol(gcf,'style','slider','units','pix','position',[5 75 20 275]);
data = guidata(gcf);
data.h = h;
data.x = x;
data.y = y;
data.z = z;
data.M = M;
data.range = range;
data.t = t;
guidata(gcf, data);
set(h,'value',init);
set(h,'min',2,'max',length(z));
set(h,'SliderStep',[1 1]/100);
set(h,'callback','data = guidata(gcf); i=nearest(get(data.h,''value'')); mesh(data.x,data.y,data.M(:,:,i)); disp(max(max(data.M(:,:,i)))); axis(data.range); title(''Electric Field Intensity''); xlabel(''x''); ylabel(''y''); zlabel(''E (V/m)''); set(data.t,''String'',sprintf(''Distance from Electrode: %f mm'',data.z(i)*1000));');



function waterWindowMin_Callback(hObject, eventdata, handles)
% hObject    handle to waterWindowMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of waterWindowMin as text
%        str2double(get(hObject,'String')) returns contents of waterWindowMin as a double


% --- Executes during object creation, after setting all properties.
function waterWindowMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to waterWindowMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function waterWindowMax_Callback(hObject, eventdata, handles)
% hObject    handle to waterWindowMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of waterWindowMax as text
%        str2double(get(hObject,'String')) returns contents of waterWindowMax as a double


% --- Executes during object creation, after setting all properties.
function waterWindowMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to waterWindowMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function compVoltage_Callback(hObject, eventdata, handles)
% hObject    handle to compVoltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of compVoltage as text
%        str2double(get(hObject,'String')) returns contents of compVoltage as a double


% --- Executes during object creation, after setting all properties.
function compVoltage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to compVoltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('axes working')
guidata(hObject, handles);


% --- Executes on button press in addElectrode.
function addElectrode_Callback(hObject, eventdata, handles)
% hObject    handle to addElectrode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global electrode

ndx=length(electrode);
tempParams = electrode(ndx);

ndx=ndx+1;
handles.whichElectrode = ndx;

electrode(ndx) = tempParams;
tmpLoc=tempParams.location;
x=tmpLoc(1)+.1; y=tmpLoc(2)+.1;
electrode(ndx).location = [x y];

set(handles.xPos,'String',num2str(x));
set(handles.yPos,'String',num2str(y));

selectorIndex = get(handles.electrodeSelector,'Value');


selectorString = get(handles.electrodeSelector,'String');
if ndx>2
    nuStringz={selectorString{:} ['Electrode ' char(ndx+64)]};
else
    nuStringz={selectorString ['Electrode ' char(ndx+64)]};
end
% nuStringz(1:ndx-1)=selectorString;
% nuStringz(ndx) = ['Electrode ' char(ndx+64)];
set(handles.electrodeSelector,'String',nuStringz);
set(handles.electrodeSelector,'Value',ndx);

% %update plot of electrode positions
% for ii=1:ndx
%     locz(:,ii)=electrode(ii).location;
% end
% plot(handles.axes1,locz(1,:),locz(2,:),'ok');

updatePositionFigure(ndx);

%diagnostic
disp([x y]);
disp(ndx);
disp(electrode(ndx));

guidata(hObject,handles);



function xPos_Callback(hObject, eventdata, handles)
% hObject    handle to xPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xPos as text
%        str2double(get(hObject,'String')) returns contents of xPos as a double

global electrode

ndx=handles.whichElectrode;
nuX=str2double(get(hObject,'String'));
electrode(ndx).location(1)=nuX;
% 
% %update plot of electrode positions
% for ii=1:ndx
%     locz(:,ii)=electrode(ii).location;
% end
% plot(handles.axes1,locz(1,:),locz(2,:),'ok');

updatePositionFigure(ndx);

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function xPos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yPos_Callback(hObject, eventdata, handles)
% hObject    handle to yPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yPos as text
%        str2double(get(hObject,'String')) returns contents of yPos as a double

global electrode

ndx=handles.whichElectrode;
nuY=str2double(get(hObject,'String'));
electrode(ndx).location(2)=nuY;

updatePositionFigure(ndx);

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function yPos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in safetyShannon.
function safetyShannon_Callback(hObject, eventdata, handles)
% hObject    handle to safetyShannon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of safetyShannon


% --- Executes on button press in safetyCharge.
function safetyCharge_Callback(hObject, eventdata, handles)
% hObject    handle to safetyCharge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of safetyCharge


% --- Executes on button press in safetyComplianceV.
function safetyComplianceV_Callback(hObject, eventdata, handles)
% hObject    handle to safetyComplianceV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of safetyComplianceV


function updatePositionFigure(ndx)
%update plot of electrode positions
global electrode
% [m n]=size(electrode)
for ii=1:length(electrode)
    locz=electrode(ii).location;
    [xx yy]=pol2cart(0:pi/4:2*pi,electrode(ii).radius*ones(1,9));
    x(ii,:)=xx+locz(1); y(ii,:)=yy+locz(2);
    fill(x(ii,:),y(ii,:),'k');
    if ii==ndx
        plot(x(ii,:),y(ii,:),'r');
    end
    hold on;
end
xlabel('X (cm)');ylabel('Y (cm)'); grid on;
hold off;

bound=max(max(abs([x(:) y(:)])));
if bound<.1
    axis([-.1 .1 -.1 .1]);
else
    nubound=round(2+10*bound)/10;
    axis([-nubound nubound -nubound nubound]);
end


function [x y z M] = electricField(a, V0, xybound, zmax,resolution,loc)
% Calculates and plots the electric field distribution for a specific
% electrode.
% a = electrode radius (m)
% V0 = voltage at electrode
% rmaxF = distance to simulate out to (m)
% zmax = height above electrode to simulate to.
% resolution = spacing in m between x/y/z
% coordinates
% Returns x, y coordinate vectors and E magnitude.
    x = xybound(1):resolution:xybound(2);
    y = xybound(3):resolution:xybound(4);
    z = 0:resolution:zmax;
    N=length(a);
    
    V = zeros(length(x),length(y),length(z));
    for (i = 1:length(x))
        for (j = 1:length(y))
            for nn=1:N
                r = sqrt((x(i)-loc(nn,1))^2+(y(j)-loc(nn,2))^2);
                q=V(i,j,:);
                V(i,j,:) = q(:)'+abs(2*V0/pi*asin(2*a(nn)./(sqrt((r-a(nn))^2+z.^2)+sqrt((r+a(nn))^2+z.^2))));
            end
        end
    end
    
    % Plot
%     M = zeros(size(V));
    
    % Calculate E from taking -gradient
    [FX, FY, FZ] = gradient(V);
    Ex = -FX;
    Ey = -FY;
    Ez = -FZ;
    
    % For intensity, only looking at magnitude.
    for (i = 1:size(V,1))
        for (j = 1:size(V,2))
            for (k=1:size(V,3))
                M(i,j,k) = norm([Ex(i,j,k) Ey(i,j,k) Ez(i,j,k)]);
            end
        end
    end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
global electrode
delete(handles.axes1);
clear electrode
delete(hObject);


% --- Executes on button press in removeElectrode.
function removeElectrode_Callback(hObject, eventdata, handles)
% hObject    handle to removeElectrode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global electrode
ndx = handles.whichElectrode;
last=length(electrode);

if last>1
    electrode(ndx)=[];
    
    nu=get(handles.electrodeSelector,'String');
    set(handles.electrodeSelector,'Value',ndx-1);
if last>2
    set(handles.electrodeSelector,'String',nu(1:end-1));
else
    set(handles.electrodeSelector,'String',nu(1));
end
    updatePositionFigure(ndx-1);
end


function [x y z M] = electricFieldlite(a, V0, xybound, zmax,resolution,loc)
% Calculates and plots the electric field distribution for a specific
% electrode.
% a = electrode radius (m)
% V0 = voltage at electrode
% rmaxF = distance to simulate out to (m)
% zmax = height above electrode to simulate to.
% resolution = spacing in m between x/y/z
% coordinates
% Returns x, y coordinate vectors and E magnitude.
    x = xybound(1):resolution:xybound(2);
    y = xybound(3):resolution:xybound(4);
    z = 0:resolution:zmax;
    N=length(a);
    
    V = zeros(length(x),length(y),length(z));
    for (i = 1:length(x))
        for (j = 1:length(y))
            for nn=1:N
                r = sqrt((x(i)-loc(nn,1))^2+(y(j)-loc(nn,2))^2);
                q=V(i,j,:);
                V(i,j,:) = q(:)'+abs(2*V0/pi*asin(2*a(nn)./(sqrt((r-a(nn))^2+z.^2)+sqrt((r+a(nn))^2+z.^2))));
            end
        end
    end
    
    % Plot
%     M = zeros(size(V));
    
    % Calculate E from taking -gradient
    [FX, FY, FZ] = gradient(V);
    Ex = -FX;
    Ey = -FY;
    Ez = -FZ;
    
    % For intensity, only looking at magnitude.
    for (i = 1:size(V,1))
        for (j = 1:size(V,2))
            for (k=1:size(V,3))
                M(i,j,k) = norm([Ex(i,j,k) Ey(i,j,k) Ez(i,j,k)]);
            end
        end
    end
