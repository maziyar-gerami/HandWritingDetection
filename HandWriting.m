function varargout = HandWriting(varargin)
% HANDWRITING MATLAB code for HandWriting.fig
%      HANDWRITING, by itself, creates a new HANDWRITING or raises the existing
%      singleton*.
%
%      H = HANDWRITING returns the handle to a new HANDWRITING or the handle to
%      the existing singleton*.
%
%      HANDWRITING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HANDWRITING.M with the given input arguments.
%
%      HANDWRITING('Property','Value',...) creates a new HANDWRITING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HandWriting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HandWriting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HandWriting

% Last Modified by GUIDE v2.5 29-Jun-2015 21:17:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HandWriting_OpeningFcn, ...
                   'gui_OutputFcn',  @HandWriting_OutputFcn, ...
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

% --- Executes just before HandWriting is made visible.
function HandWriting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HandWriting (see VARARGIN)

% Choose default command line output for HandWriting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HandWriting wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end





% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
[file, path] = uigetfile('*.jpg');
handles.input = imread (strcat(path,file));
guidata(hObject,handles);
set(findobj('Tag','axes2'),'visible','on');
imshow(handles.input);
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
Network = load ('matlab1.mat');
Network = Network.net1;

[thichness, varThickness,NR_input,SE_input10,SE_input20,MO_input,ST_input,LL_input, SC_input, posArray, DC_input, VC_input, SU_input ] = featureExtraction(handles.input);
     
[totalAngleFactor, varCurve, varDistanceBetweenWords, ...
varAngleMozoon,VarAreaChar,VarHeight, varAngleNamosaviH,...
varThickness, varDist, AngleFactor, VarAreaWords]= Compute (  NR_input, ...
MO_input, ST_input, LL_input, posArray, VC_input, varThickness);

inputNetwork = ([totalAngleFactor, varCurve, varDistanceBetweenWords, ...
varAngleMozoon,VarAreaChar,VarHeight, varAngleNamosaviH,...
varThickness, varDist, AngleFactor, VarAreaWords])';

result = Network(inputNetwork);



set(findobj('Tag','text4'),'String',result);
end



% --- Outputs from this function are returned to the command line.
function varargout = HandWriting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end






    

function  [thichness, varThickness,NR_input,SE_input10,SE_input20,MO_input,ST_input,LL_input, SC_input, posArray, DC_input, VC_input, SU_input ]=featureExtraction (input)
    
BW_input = im2bw(input, 0.8);

% B) Finding thickness
[thichness, varThickness] = B_Finfing_thickness(BW_input);
% C) Noise Reduction
NR_input = C_NoiseReduction(thichness, BW_input);

% D) Segmentation
[SE_input10 , SE_input20]  = D_Segmentation (NR_input);

% E) Morphology and streaming
[MO_input, ST_input] = E_MorphologyStreaming(thichness , NR_input);

% F) labeling lines
LL_input = bwlabel (ST_input);
% G) smoothing and curve
[SC_input,posArray] = G_SmoothingCurving(LL_input);

% H) Distance Between lines
DC_input = H_DistanceComputation (SC_input);

% I) Vertical Components
VC_input = I_VerticalComponents(NR_input, LL_input , thichness);
imshow(VC_input);
% j) subtract
SU_input = imsubtract (VC_input , NR_input);


end
