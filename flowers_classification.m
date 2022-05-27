function varargout = flowers_classification(varargin)
% FLOWERS_CLASSIFICATION MATLAB code for flowers_classification.fig
%      FLOWERS_CLASSIFICATION, by itself, creates a new FLOWERS_CLASSIFICATION or raises the existing
%      singleton*.
%
%      H = FLOWERS_CLASSIFICATION returns the handle to a new FLOWERS_CLASSIFICATION or the handle to
%      the existing singleton*.
%
%      FLOWERS_CLASSIFICATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FLOWERS_CLASSIFICATION.M with the given input arguments.
%
%      FLOWERS_CLASSIFICATION('Property','Value',...) creates a new FLOWERS_CLASSIFICATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before flowers_classification_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to flowers_classification_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help flowers_classification

% Last Modified by GUIDE v2.5 28-May-2022 04:29:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @flowers_classification_OpeningFcn, ...
                   'gui_OutputFcn',  @flowers_classification_OutputFcn, ...
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


% --- Executes just before flowers_classification is made visible.
function flowers_classification_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to flowers_classification (see VARARGIN)

% Choose default command line output for flowers_classification
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes flowers_classification wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = flowers_classification_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_input.
function btn_input_Callback(hObject, eventdata, handles)
[nama_file,nama_folder]=uigetfile('*.jpg');

%jika ada nama file yang terpilih maka akan mengeksekusi percabanan ini
if ~isequal(nama_file,0)
    %membaca ctra rgb
    citra=imread(fullfile(nama_folder,nama_file));
    %menampikan citra di axes
    axes(handles.axes4)
    imshow(citra)
    title('Citra yang dipilih')
    %simpan variabel i d dalam handles agar bisa di simpan
    handles.citra=citra;
    guidata(hObject,handles)
else
    %jika tidak ada file maka akan kembali
    return    
end

% --- Executes on button press in btn_ekstraksi.
function btn_ekstraksi_Callback(hObject, eventdata, handles)
ekstrak1=handles.citra;
ekstrak=rgb2gray(ekstrak1);
hold=graythresh(ekstrak);
biner=im2bw(ekstrak,hold);
biner=bwareaopen(biner,30);
se=strel('disk',2);
biner=imclose(biner,se);
biner=imfill(biner,'holes');
[b,l]=bwboundaries(biner,'noholes');
stats=regionprops(l,'ALL')
perimeter=cat(1,stats.Perimeter);
area=cat(1,stats.Area);
eccentricity=cat(1,stats.Eccentricity);
metric=4*pi*area/perimeter*perimeter;

set(handles.txt_area,'string',num2str(area,'%0.2f'));
set(handles.txt_perimeter,'string',perimeter);
set(handles.txt_metric,'string',metric);
set(handles.txt_eccentricity,'string',eccentricity);


% --- Executes during object creation, after setting all properties.
function txt_area_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function txt_perimeter_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function txt_metric_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function txt_eccentricity_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end