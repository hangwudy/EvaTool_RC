function varargout = Kontur(varargin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%         Version 1.50                                                %%%
%%%         Last updated on September 7, 2018                           %%%
%%%         Created by Hang Wu at utg of TUM on June 26, 2018           %%%
%%%         Feedback & support: h.wu@tum.de                             %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%         Changelog                                                   %%%
%%%         v1.50:                                                      %%%
%%%             Added:                                                  %%%
%%%                 -Zoom                                               %%%
%%%                 -Direct Undercut                                    %%%
%%%             Fixed:                                                  %%%
%%%                 -Bugs                                               %%%
%%%                 -Current axes problem                               %%%
%%%         v1.00:                                                      %%%
%%%             Added:                                                  %%%
%%%                 -Comparison                                         %%%
%%%         v0.95:                                                      %%%
%%%             Fixed:                                                  %%%
%%%                 -Bugs                                               %%%
%%%         v0.91:                                                      %%%
%%%             Fixed:                                                  %%%
%%%                 -Bugs                                               %%%
%%%         v0.90:                                                      %%%
%%%             Added:                                                  %%%
%%%                 -Analysis                                           %%%
%%%         v0.82:                                                      %%%
%%%             Added:                                                  %%%
%%%                 -Comparison                                         %%%
%%%                 -Analysis                                           %%%
%%%         v0.81:                                                      %%%
%%%             Added:                                                  %%%
%%%                 -Import MAT-file directly to plot the outlines      %%%
%%%                 -Import MAT-file directly to plot the outlines from %%%
%%%                     Auswertungstool                                 %%%
%%%             Fixed:                                                  %%%
%%%                 -Plot in current axes error                         %%%
%%%         v0.80:                                                      %%%
%%%             Added:                                                  %%%
%%%                 -Adjustment                                         %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% KONTUR MATLAB code for Kontur.fig
%      KONTUR, by itself, creates a new KONTUR or raises the existing
%      singleton*.
%
%      H = KONTUR returns the handle to a new KONTUR or the handle to
%      the existing singleton*.
%
%      KONTUR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KONTUR.M with the given input arguments.
%
%      KONTUR('Property','Value',...) creates a new KONTUR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Kontur_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Kontur_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Kontur

% Last Modified by GUIDE v2.5 07-Sep-2018 15:47:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Kontur_OpeningFcn, ...
                   'gui_OutputFcn',  @Kontur_OutputFcn, ...
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


% --- Executes just before Kontur is made visible.
function Kontur_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Kontur (see VARARGIN)


% Initialization
clc

handles.scale = str2double(get(handles.edit_scale, 'String'));
handles.count1 = 0;
handles.count2 = 0;
handles.count3 = 0;
handles.count4 = 0;

% Step for adjustment

handles.step_distance = str2double(get(handles.edit_step_dis, 'String'));
handles.step_angle = str2double(get(handles.edit_step_angle, 'String'));




% Choose default command line output for Kontur
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Kontur wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Kontur_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_load_raw_pic.
function pushbutton_load_raw_pic_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_raw_pic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName] = uigetfile({'*.*',...
    'All Files (*.*)';...
    '*.jpg;*.jpeg;*.jpe',...
    'JPEG (*.jpg; *.jpeg; *.jpe)';...
    '*.png;*.pns',...
    'PNG (*.png; *.pns)';...
    '*.tif;*.tiff',...
    'TIFF (*.tif; *.tiff)'},...
    'Select the microsection','MultiSelect','off');
schliffbild = fullfile(PathName, FileName);


% 
handles.schliffbild = schliffbild;
% Location

set(handles.edit_path_pic, 'String', handles.schliffbild);
% disp(handles.schliffbild)
% disp(PathName)
% dir PathName
if PathName ~= 0
    % disp('empty')


    %
    h = waitbar(0, 'Loading...');
    I=imread(handles.schliffbild);
    I = im2double(I);
    % delete(h)
    waitbar(0.3333, h, 'Greyscale processing.');
    I = rgb2gray(I);
    [thr,sorh,keepapp]=ddencmp('den','wv',I);
    % delete(h)
    waitbar(0.6666, h, 'Noise reduction.');
    I = wdencmp('gbl',I,'sym4',2,thr,sorh,keepapp);
    % delete(h)
    waitbar(1, h, 'Finished!');
    handles.I = I;
    delete(h)
    answer = questdlg('Import completed! Do you want to check the input?', ...
        'Kontur', ...
        'Yes', ...
        'No', ...
        'No');
    switch answer
        case 'Yes'
            figure()
            imshow(handles.I);
    end
    %
    % figure()
    % imshow(handles.I);

else
    disp('Empty, please select one file!')

end
% Save the handles structure.
guidata(hObject,handles)



% --- Executes on button press in pushbutton_scale_manual.
function pushbutton_scale_manual_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_scale_manual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit_scale, 'Enable', 'on');


% Save the handles structure.
guidata(hObject,handles)



% --- Executes on button press in pushbutton_from_pic.
function pushbutton_from_pic_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_from_pic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% I=imread(handles.schliffbild);
% I = im2double(I);
% I = rgb2gray(I);
% [thr,sorh,keepapp]=ddencmp('den','wv',I);
% I = wdencmp('gbl',I,'sym4',2,thr,sorh,keepapp);

figure()
imshow(handles.I);

[x1, y1] = getpts();
X = [x1, y1];
% dis = abs(x1(1)-x1(2));
dis = pdist(X,'euclidean');
scale = dis; % 1/dis
handles.scale = scale;
close(gcf);

% 
set(handles.edit_scale, 'String', handles.scale);


% Save the handles structure.
guidata(hObject,handles)



function edit_scale_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scale as text
%        str2double(get(hObject,'String')) returns contents of edit_scale as a double


% --- Executes during object creation, after setting all properties.
function edit_scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_update_scale.
function pushbutton_update_scale_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_update_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


set(handles.edit_scale, 'Enable', 'off');
handles.scale = str2double(get(handles.edit_scale, 'String'));
display(handles.scale);
% test
% display(handles.scale);

% Save the handles structure.
guidata(hObject,handles)


% --- Executes on button press in pushbutton_uu.
function pushbutton_uu_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_uu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


in = 0;
count = 0;
while in == 0
    % msgbox('Operation Completed');
    if count == 0 && handles.count1 == 0
        uiwait(msgbox({'Trace the sheet metal contour at the upper sheet upper edge and click on it!'; 'Confirm with Enter!'}, ...
            'Hint 1', ...
            'help', ...
            'modal'));
        uiwait(msgbox('Pressing Backspace or Delete removes the previously selected point.', ...
            'Hint 2', ...
            'help', ...
            'modal'));
    end
    count = 1;
    handles.count1 = 1;
    guidata(hObject,handles)
    % disp(handles.count1)
    % hold off;
    fig1=figure(1);
    imshow(handles.I);
    hold on;
    
    cameratoolbar(fig1,'Show')
    % get points from mouse, use DELETE to remove point
    [a1,a2] = getpts();
    hold on
    zoom on;
    plot(a1,a2,'- .c', 'LineWidth',1, 'MarkerSize',10)
    answer = questdlg('Is the input suitable?', ...
        'Kontur', ...
        'Yes', ...
        'No', ...
        'No');
    switch answer
        case 'Yes'
            in = 1;
            close(gcf);
        case 'No'
            in = 0;
            close(gcf);
    end
end

handles.a1 = a1;
handles.a2 = a2;


ax2 = size(handles.I,1)-a2;


handles.M_uu = [a1,ax2]/handles.scale;
display(handles.M_uu);


% plot in GUI
hold on
plot(handles.axes_outline,handles.M_uu(:,1),handles.M_uu(:,2),'- c');
hold on
axis equal

%
% Data output
%

handles.x_Oo = handles.M_uu(:,1);
handles.y_Oo = handles.M_uu(:,2);






% Save the handles structure.
guidata(hObject,handles)


% --- Executes on button press in pushbutton_ul.
function pushbutton_ul_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ul (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


in = 0;
count = 0;
while in == 0
    % msgbox('Operation Completed');
    if count == 0 && handles.count2 == 0
        uiwait(msgbox({'Trace the sheet metal contour at the upper sheet lower edge and click on it!'; 'Confirm with Enter!'}, ...
            'Hint 1', ...
            'help', ...
            'modal'));
        uiwait(msgbox('Pressing Backspace or Delete removes the previously selected point.', ...
            'Hint 2', ...
            'help', ...
            'modal'));
    end
    count = 1;
    handles.count2 = 1;
    guidata(hObject,handles)
    % hold off;
    fig2=figure(2);
    imshow(handles.I);
    hold on;
    plot(handles.a1,handles.a2,'- .c', 'LineWidth',1, 'MarkerSize',10)
    cameratoolbar(fig2,'Show')
    % get points from mouse, use DELETE to remove point
    [a3,a4] = getpts();
    hold on
    plot(a3,a4,'- .c', 'LineWidth',1, 'MarkerSize',10)
    answer = questdlg('Is the input suitable?', ...
        'Kontur', ...
        'Yes', ...
        'No', ...
        'No');
    switch answer
        case 'Yes'
            in = 1;
            close(gcf);
        case 'No'
            in = 0;
            close(gcf);
    end
end


handles.a3 = a3;
handles.a4 = a4;

ax4 = size(handles.I,1)-a4;


handles.M_ul = [a3,ax4]/handles.scale;
display(handles.M_ul);



% plot in GUI
hold on
plot(handles.axes_outline,handles.M_ul(:,1),handles.M_ul(:,2),'- g');
hold on
axis equal


%
% Data output
%


handles.x_Ou = handles.M_ul(:,1);
handles.y_Ou = handles.M_ul(:,2);





% Save the handles structure.
guidata(hObject,handles)






% --- Executes on button press in pushbutton_lu.
function pushbutton_lu_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_lu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



in = 0;
count = 0;
while in == 0
    % msgbox('Operation Completed');
    if count == 0 && handles.count3 == 0
        uiwait(msgbox({'Trace the sheet metal contour at the lower sheet upper edge and click on it!'; 'Confirm with Enter!'}, ...
            'Hint 1', ...
            'help', ...
            'modal'));
        uiwait(msgbox('Pressing Backspace or Delete removes the previously selected point.', ...
            'Hint 2', ...
            'help', ...
            'modal'));
    end
    count = 1;
    handles.count3 = 1;
    guidata(hObject,handles)
    % hold off;
    fig3=figure(3);
    imshow(handles.I);
    hold on;
    plot(handles.a1,handles.a2,'- .c', 'LineWidth',1, 'MarkerSize',10)
    plot(handles.a3,handles.a4,'- .c', 'LineWidth',1, 'MarkerSize',10)
    cameratoolbar(fig3,'Show')
    % get points from mouse, use DELETE to remove point
    [b1,b2] = getpts();
    hold on
    plot(b1,b2,'- .c', 'LineWidth',1, 'MarkerSize',10)
    answer = questdlg('Is the input suitable?', ...
        'Kontur', ...
        'Yes', ...
        'No', ...
        'No');
    switch answer
        case 'Yes'
            in = 1;
            close(gcf);
        case 'No'
            in = 0;
            close(gcf);
    end
end


handles.b1 = b1;
handles.b2 = b2;

bx2 = size(handles.I,1)-b2;


handles.M_lu = [b1,bx2]/handles.scale;
display(handles.M_lu);


% plot in GUI
hold on
plot(handles.axes_outline,handles.M_lu(:,1),handles.M_lu(:,2),'- m');
hold on
axis equal




%
% Data output
%


handles.x_Uo = handles.M_lu(:,1);
handles.y_Uo = handles.M_lu(:,2);





% Save the handles structure.
guidata(hObject,handles)






% --- Executes on button press in pushbutton_ll.
function pushbutton_ll_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




in = 0;
count = 0;
while in == 0
    % msgbox('Operation Completed');
    if count == 0 && handles.count4 == 0
        uiwait(msgbox({'Trace the sheet metal contour at the lower sheet lower edge and click on it!'; 'Confirm with Enter!'}, ...
            'Hint 1', ...
            'help', ...
            'modal'));
        uiwait(msgbox('Pressing Backspace or Delete removes the previously selected point.', ...
            'Hint 2', ...
            'help', ...
            'modal'));
    end
    count = 1;
    handles.count4 = 1;
    guidata(hObject,handles)
    % hold off;
    fig4=figure(4);
    imshow(handles.I);
    hold on;
    plot(handles.a1,handles.a2,'- .c', 'LineWidth',1, 'MarkerSize',10)
    plot(handles.a3,handles.a4,'- .c', 'LineWidth',1, 'MarkerSize',10)
    plot(handles.b1,handles.b2,'- .c', 'LineWidth',1, 'MarkerSize',10)
    cameratoolbar(fig4,'Show')
    % get points from mouse, use DELETE to remove point
    [b3,b4] = getpts();
    hold on

    plot(b3,b4,'- .c', 'LineWidth',1, 'MarkerSize',10)
    answer = questdlg('Is the input suitable?', ...
        'Kontur', ...
        'Yes', ...
        'No', ...
        'No');
    switch answer
        case 'Yes'
            in = 1;
            close(gcf);
        case 'No'
            in = 0;
            close(gcf);
    end
end


bx4 = size(handles.I,1)-b4;


handles.M_ll = [b3,bx4]/handles.scale;
display(handles.M_ll);



% plot in GUI
hold on
plot(handles.axes_outline,handles.M_ll(:,1),handles.M_ll(:,2),'- b');
hold off
axis equal

%
% Data save
% 


handles.x_Uu = handles.M_ll(:,1);
handles.y_Uu = handles.M_ll(:,2);




% Save the handles structure.
guidata(hObject,handles)




function edit_path_pic_Callback(hObject, eventdata, handles)
% hObject    handle to edit_path_pic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_path_pic as text
%        str2double(get(hObject,'String')) returns contents of edit_path_pic as a double


% --- Executes during object creation, after setting all properties.
function edit_path_pic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_path_pic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_data.
function pushbutton_save_data_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


Dateiname = get(handles.edit_result, 'String');
Schliff_Oo = handles.M_uu;
Schliff_Ou = handles.M_ul;
Schliff_Uo = handles.M_lu;
Schliff_Uu = handles.M_ll;
save(sprintf('%s.mat',Dateiname),'Schliff_Oo','Schliff_Ou','Schliff_Uo','Schliff_Uu');
uiwait(msgbox('Saved!','Kontur','help','modal'))
disp('Gespeichert!')

% 


% Save the handles structure.
guidata(hObject,handles)


function edit_result_Callback(hObject, eventdata, handles)
% hObject    handle to edit_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_result as text
%        str2double(get(hObject,'String')) returns contents of edit_result as a double


% --- Executes during object creation, after setting all properties.
function edit_result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_get_the_bottom.
function pushbutton_get_the_bottom_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_get_the_bottom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


in = 0;
count = 0;
while in == 0
    % msgbox('Operation Completed');
    if count == 0
        uiwait(msgbox({'Trace the sheet metal contour at the bottom edge of the lower sheet and click on it!'; 'Thereafter confirm with Enter!'}, ...
            'Hint 1', ...
            'help', ...
            'modal'));
        uiwait(msgbox('Pressing Backspace or Delete removes the previously selected point.', ...
            'Hint 2', ...
            'help', ...
            'modal'));
    end
    count = 1;
    % hold off;
    figure(5);
    imshow(handles.I);
    hold on;
    % get points from mouse, use DELETE to remove point
    [x1,y1] = getpts();
    hold on
    plot(x1,y1,'- .c', 'LineWidth',1, 'MarkerSize',10)
    answer = questdlg('Is the input suitable?', ...
        'Kontur', ...
        'Yes', ...
        'No', ...
        'No');
    switch answer
        case 'Yes'
            in = 1;
            close(gcf);
        case 'No'
            in = 0;
            close(gcf);
    end
end

% disp([x1,y1]);
[xData, yData] = prepareCurveData(x1, y1);

ft = fittype( 'm*x+c', 'independent', 'x', 'dependent', 'y' ); % linearisieren
opts = fitoptions( 'Method', 'NonlinearLeastSquares' ); % Create Fit Options for Linear Least Squares
opts.Display = 'Off';
[fitresult, gof] = fit( xData, yData, ft, opts );
% disp(fitresult)
% disp(gof)
figure(6)
imshow(handles.I);
hold on
plot(fitresult, xData, yData)
alpha = atan(fitresult.m)/pi*180;

% Verschiebung
y_hub = size(handles.I,1) - fitresult.c;
handles.y_hub = y_hub/handles.scale;
disp(handles.y_hub)



% disp(fitresult.m)
disp(alpha)
% handles.m = fitresult.m;
handles.alpha = alpha;

% Save the handles structure.
guidata(hObject,handles)




% --- Executes on button press in pushbutton_rotate_image.
function pushbutton_rotate_image_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rotate_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


disp(handles.alpha)
% disp(handles.m)
J = imrotate(handles.I, handles.alpha, 'bilinear','crop');
figure(7)
imshow(J)

handles.I = J;
% Save the handles structure.
guidata(hObject,handles)












% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% cla reset
cla(handles.axes_outline, 'reset')
cla(handles.axes_adjust, 'reset')

handles.M_uu = [];
handles.M_ul = [];
handles.M_lu = [];
handles.M_ll = [];

% 
% % --- Executes on button press in pushbutton_translation.
% function pushbutton_translation_Callback(hObject, eventdata, handles)
% % hObject    handle to pushbutton_translation (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% 
% 
% 
% % handles.x_Oo = handles.M_uu(:,1);
% handles.y_Oo = handles.M_uu(:,2) - handles.y_hub;
% % handles.x_Ou = handles.M_ul(:,1);
% handles.y_Ou = handles.M_ul(:,2) - handles.y_hub;
% % handles.x_Uo = handles.M_lu(:,1);
% handles.y_Uo = handles.M_lu(:,2) - handles.y_hub;
% % handles.x_Uu = handles.M_ll(:,1);
% handles.y_Uu = handles.M_ll(:,2) - handles.y_hub;
% 
% 
% % axis(handles.axes_adjust)
% % figure(100)
% % hold on
% plot(handles.axes_adjust, handles.x_Oo, handles.y_Oo)
% hold on
% plot(handles.axes_adjust, handles.x_Ou, handles.y_Ou)
% 
% plot(handles.axes_adjust, handles.x_Uo, handles.y_Uo)
% 
% plot(handles.axes_adjust, handles.x_Uu, handles.y_Uu)
% 
% 
% axis equal
% 
% hold off
% 
% 
% 
% % Save the handles structure.
% guidata(hObject,handles)






% --- Executes on button press in pushbutton_up.
function pushbutton_up_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.step_distance = str2double(get(handles.edit_step_dis, 'String'));
% handles.step_angle = str2double(get(handles.edit_step_angle, 'String'));

axes(handles.axes_adjust)



% handles.x_Oo = handles.M_uu(:,1);
handles.y_Oo = handles.y_Oo + handles.step_distance;
% handles.x_Ou = handles.M_ul(:,1);
handles.y_Ou = handles.y_Ou + handles.step_distance;
% handles.x_Uo = handles.M_lu(:,1);
handles.y_Uo = handles.y_Uo + handles.step_distance;
% handles.x_Uu = handles.M_ll(:,1);
handles.y_Uu = handles.y_Uu + handles.step_distance;




% Plot

plot(handles.axes_adjust, handles.x_Oo, handles.y_Oo)
hold on
plot(handles.axes_adjust, handles.x_Ou, handles.y_Ou)

plot(handles.axes_adjust, handles.x_Uo, handles.y_Uo)

plot(handles.axes_adjust, handles.x_Uu, handles.y_Uu)


axis equal
grid on
hold off




% Save the handles structure.
guidata(hObject,handles)





% --- Executes on button press in pushbutton_down.
function pushbutton_down_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.step_distance = str2double(get(handles.edit_step_dis, 'String'));
% handles.step_angle = str2double(get(handles.edit_step_angle, 'String'));



axes(handles.axes_adjust)






% handles.x_Oo = handles.M_uu(:,1);
handles.y_Oo = handles.y_Oo - handles.step_distance;
% handles.x_Ou = handles.M_ul(:,1);
handles.y_Ou = handles.y_Ou - handles.step_distance;
% handles.x_Uo = handles.M_lu(:,1);
handles.y_Uo = handles.y_Uo - handles.step_distance;
% handles.x_Uu = handles.M_ll(:,1);
handles.y_Uu = handles.y_Uu - handles.step_distance;




% Plot

plot(handles.axes_adjust, handles.x_Oo, handles.y_Oo)
hold on
plot(handles.axes_adjust, handles.x_Ou, handles.y_Ou)

plot(handles.axes_adjust, handles.x_Uo, handles.y_Uo)

plot(handles.axes_adjust, handles.x_Uu, handles.y_Uu)


axis equal
grid on
hold off













% Save the handles structure.
guidata(hObject,handles)



% --- Executes on button press in pushbutton_left.
function pushbutton_left_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.step_distance = str2double(get(handles.edit_step_dis, 'String'));
% handles.step_angle = str2double(get(handles.edit_step_angle, 'String'));




axes(handles.axes_adjust)



% 
handles.x_Oo = handles.x_Oo - handles.step_distance;
% handles.y_Oo = handles.y_Oo - handles.step_distance;
handles.x_Ou = handles.x_Ou - handles.step_distance;
% handles.y_Ou = handles.y_Ou - handles.step_distance;
handles.x_Uo = handles.x_Uo - handles.step_distance;
% handles.y_Uo = handles.y_Uo - handles.step_distance;
handles.x_Uu = handles.x_Uu - handles.step_distance;
% handles.y_Uu = handles.y_Uu - handles.step_distance;




% Plot

plot(handles.axes_adjust, handles.x_Oo, handles.y_Oo)
hold on
plot(handles.axes_adjust, handles.x_Ou, handles.y_Ou)

plot(handles.axes_adjust, handles.x_Uo, handles.y_Uo)

plot(handles.axes_adjust, handles.x_Uu, handles.y_Uu)


axis equal
grid on
hold off





% Save the handles structure.
guidata(hObject,handles)




% --- Executes on button press in pushbutton_right.
function pushbutton_right_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.step_distance = str2double(get(handles.edit_step_dis, 'String'));
% handles.step_angle = str2double(get(handles.edit_step_angle, 'String'));


axes(handles.axes_adjust)


% 
handles.x_Oo = handles.x_Oo + handles.step_distance;
% handles.y_Oo = handles.y_Oo - handles.step_distance;
handles.x_Ou = handles.x_Ou + handles.step_distance;
% handles.y_Ou = handles.y_Ou - handles.step_distance;
handles.x_Uo = handles.x_Uo + handles.step_distance;
% handles.y_Uo = handles.y_Uo - handles.step_distance;
handles.x_Uu = handles.x_Uu + handles.step_distance;
% handles.y_Uu = handles.y_Uu - handles.step_distance;




% Plot

plot(handles.axes_adjust, handles.x_Oo, handles.y_Oo)
hold on
plot(handles.axes_adjust, handles.x_Ou, handles.y_Ou)

plot(handles.axes_adjust, handles.x_Uo, handles.y_Uo)

plot(handles.axes_adjust, handles.x_Uu, handles.y_Uu)


axis equal
grid on
hold off





% Save the handles structure.
guidata(hObject,handles)


% --- Executes on button press in pushbutton_cw.
function pushbutton_cw_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% handles.step_distance = str2double(get(handles.edit_step_dis, 'String'));
handles.step_angle = -str2double(get(handles.edit_step_angle, 'String'));


handles.x_Oo = handles.x_Oo*cos(handles.step_angle) - handles.y_Oo*sin(handles.step_angle);
handles.y_Oo = handles.x_Oo*sin(handles.step_angle) + handles.y_Oo*cos(handles.step_angle);
handles.x_Ou = handles.x_Ou*cos(handles.step_angle) - handles.y_Ou*sin(handles.step_angle);
handles.y_Ou = handles.x_Ou*sin(handles.step_angle) + handles.y_Ou*cos(handles.step_angle);
handles.x_Uo = handles.x_Uo*cos(handles.step_angle) - handles.y_Uo*sin(handles.step_angle);
handles.y_Uo = handles.x_Uo*sin(handles.step_angle) + handles.y_Uo*cos(handles.step_angle);
handles.x_Uu = handles.x_Uu*cos(handles.step_angle) - handles.y_Uu*sin(handles.step_angle);
handles.y_Uu = handles.x_Uu*sin(handles.step_angle) + handles.y_Uu*cos(handles.step_angle);


axes(handles.axes_adjust)


% Plot

plot(handles.axes_adjust, handles.x_Oo, handles.y_Oo)
hold on
plot(handles.axes_adjust, handles.x_Ou, handles.y_Ou)

plot(handles.axes_adjust, handles.x_Uo, handles.y_Uo)

plot(handles.axes_adjust, handles.x_Uu, handles.y_Uu)


axis equal
grid on
hold off




% Save the handles structure.
guidata(hObject,handles)



% --- Executes on button press in pushbutton_anticlockwise.
function pushbutton_anticlockwise_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_anticlockwise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% handles.step_distance = str2double(get(handles.edit_step_dis, 'String'));
handles.step_angle = str2double(get(handles.edit_step_angle, 'String'));





handles.x_Oo = handles.x_Oo*cos(handles.step_angle) - handles.y_Oo*sin(handles.step_angle);
handles.y_Oo = handles.x_Oo*sin(handles.step_angle) + handles.y_Oo*cos(handles.step_angle);
handles.x_Ou = handles.x_Ou*cos(handles.step_angle) - handles.y_Ou*sin(handles.step_angle);
handles.y_Ou = handles.x_Ou*sin(handles.step_angle) + handles.y_Ou*cos(handles.step_angle);
handles.x_Uo = handles.x_Uo*cos(handles.step_angle) - handles.y_Uo*sin(handles.step_angle);
handles.y_Uo = handles.x_Uo*sin(handles.step_angle) + handles.y_Uo*cos(handles.step_angle);
handles.x_Uu = handles.x_Uu*cos(handles.step_angle) - handles.y_Uu*sin(handles.step_angle);
handles.y_Uu = handles.x_Uu*sin(handles.step_angle) + handles.y_Uu*cos(handles.step_angle);


axes(handles.axes_adjust)


% Plot

plot(handles.axes_adjust, handles.x_Oo, handles.y_Oo)
hold on
plot(handles.axes_adjust, handles.x_Ou, handles.y_Ou)

plot(handles.axes_adjust, handles.x_Uo, handles.y_Uo)

plot(handles.axes_adjust, handles.x_Uu, handles.y_Uu)


axis equal
grid on
hold off










% Save the handles structure.
guidata(hObject,handles)



function edit_step_dis_Callback(hObject, eventdata, handles)
% hObject    handle to edit_step_dis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_step_dis as text
%        str2double(get(hObject,'String')) returns contents of edit_step_dis as a double


handles.step_distance = str2double(get(handles.edit_step_dis, 'String'));
disp(handles.step_distance)


% Save the handles structure.
guidata(hObject,handles)






% --- Executes during object creation, after setting all properties.
function edit_step_dis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_step_dis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_step_angle_Callback(hObject, eventdata, handles)
% hObject    handle to edit_step_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_step_angle as text
%        str2double(get(hObject,'String')) returns contents of edit_step_angle as a double



handles.step_angle = str2double(get(handles.edit_step_angle, 'String'));
disp(handles.step_angle)


% Save the handles structure.
guidata(hObject,handles)





% --- Executes during object creation, after setting all properties.
function edit_step_angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_step_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% 
% % --- Executes on button press in pushbutton_Translation_x.
% function pushbutton_Translation_x_Callback(hObject, eventdata, handles)
% % hObject    handle to pushbutton_Translation_x (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% 
% clc

% --- Executes on button press in pushbutton_Zufrieden.
function pushbutton_Zufrieden_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Zufrieden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





handles.M_uu(:,1) = handles.x_Oo;
handles.M_uu(:,2) = handles.y_Oo;
handles.M_ul(:,1) = handles.x_Ou;
handles.M_ul(:,2) = handles.y_Ou;
handles.M_lu(:,1) = handles.x_Uo;
handles.M_lu(:,2) = handles.y_Uo;
handles.M_ll(:,1) = handles.x_Uu;
handles.M_ll(:,2) = handles.y_Uu;

disp(handles.M_uu)
disp(handles.M_ul)
disp(handles.M_lu)
disp(handles.M_ll)





% Save the handles structure.
guidata(hObject,handles)


% --- Executes on button press in pushbutton_import_data.
function pushbutton_import_data_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_import_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





axes(handles.axes_outline)

[FileName,PathName] = uigetfile(...
    'Select the Matfile','MultiSelect','off');
matfile = fullfile(PathName, FileName);


% 
handles.matfile = matfile;
% Location

% set(handles.edit_path_pic, 'String', handles.schliffbild);
% disp(handles.schliffbild)
% disp(PathName)
% dir PathName
if PathName ~= 0
    mat_file = load(handles.matfile);
    S_Oo = mat_file.Schliff_Oo;
    S_Ou = mat_file.Schliff_Ou;
    S_Uo = mat_file.Schliff_Uo;
    S_Uu = mat_file.Schliff_Uu;
    cla(handles.axes_outline, 'reset')
%     disp(S_Oo)
    
    %%%
    handles.M_uu = S_Oo;
    handles.M_ul = S_Ou;
    handles.M_lu = S_Uo;
    handles.M_ll = S_Uu;
    % display(handles.M_uu);

    % hold on
    plot(handles.axes_outline, handles.M_uu(:,1),handles.M_uu(:,2),'- c');
    hold on
    plot(handles.axes_outline, handles.M_ul(:,1),handles.M_ul(:,2),'- g');
    plot(handles.axes_outline, handles.M_lu(:,1),handles.M_lu(:,2),'- m');
    plot(handles.axes_outline, handles.M_ll(:,1),handles.M_ll(:,2),'- b');
    axis equal

    %
    % Data output
    %

    handles.x_Oo = handles.M_uu(:,1);
    handles.y_Oo = handles.M_uu(:,2);
    handles.x_Ou = handles.M_ul(:,1);
    handles.y_Ou = handles.M_ul(:,2);
    handles.x_Uo = handles.M_lu(:,1);
    handles.y_Uo = handles.M_lu(:,2);
    handles.x_Uu = handles.M_ll(:,1);
    handles.y_Uu = handles.M_ll(:,2);

else
    disp('Empty, please select one file!')

end





%%%
% Save the handles structure.
guidata(hObject,handles)


% --- Executes on button press in pushbutton_plot_to_adjust.
function pushbutton_plot_to_adjust_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot_to_adjust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% hold on
axes(handles.axes_adjust)

plot(handles.axes_adjust, handles.x_Oo, handles.y_Oo)

hold(handles.axes_adjust, 'on')
plot(handles.axes_adjust, handles.x_Ou, handles.y_Ou)

plot(handles.axes_adjust, handles.x_Uo, handles.y_Uo)

plot(handles.axes_adjust, handles.x_Uu, handles.y_Uu)

axis(handles.axes_adjust, 'equal')
grid on
hold(handles.axes_adjust, 'off')


% --- Executes on button press in pushbutton_import_GUI_data.
function pushbutton_import_GUI_data_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_import_GUI_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




[FileName,PathName] = uigetfile(...
    'Select the Matfile','MultiSelect','off');
matfile2 = fullfile(PathName, FileName);

handles.PathName2 = PathName;
% 
handles.matfile2 = matfile2;
%







%%%
% Save the handles structure.
guidata(hObject,handles)


% --- Executes on button press in pushbutton_compare.
function pushbutton_compare_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_compare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if handles.PathName2 ~= 0
    mat_file2 = load(handles.matfile2);
    handles.X_Oo_GUI = mat_file2.x_Oo;
    handles.Y_Oo_GUI = mat_file2.y_Oo;
    handles.X_Ou_GUI = mat_file2.x_Ou;
    handles.Y_Ou_GUI = mat_file2.y_Ou;
    handles.X_Uo_GUI = mat_file2.x_Uo;
    handles.Y_Uo_GUI = mat_file2.y_Uo;
    handles.X_Uu_GUI = mat_file2.x_Uu;
    handles.Y_Uu_GUI = mat_file2.y_Uu;

    figure(10)
    plot(handles.X_Oo_GUI, handles.Y_Oo_GUI, '--')
    hold on
    plot(handles.X_Ou_GUI, handles.Y_Ou_GUI, '--')
    plot(handles.X_Uo_GUI, handles.Y_Uo_GUI, '--')
    plot(handles.X_Uu_GUI, handles.Y_Uu_GUI, '--')
    
    axis equal
    grid on

    plot(handles.M_uu(:,1),handles.M_uu(:,2),'- c');
    % hold on
    plot(handles.M_ul(:,1),handles.M_ul(:,2),'- g');
    plot(handles.M_lu(:,1),handles.M_lu(:,2),'- m');
    plot(handles.M_ll(:,1),handles.M_ll(:,2),'- b');
    axis equal
    hold off

else
    disp('Empty, please select one file!')

end



%%%
% Save the handles structure.
guidata(hObject,handles)

% --- Executes on button press in pushbutton_analyse.
function pushbutton_analyse_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


f1 = figure(20);
set(f1, 'Name', 'Result','NumberTitle','off');
[Halsdicke_austauch,Halsdicke_eintauch,Hinterschnitt_austauch,Hinterschnitt_eintauch] = Analysis(handles.x_Oo,handles.y_Oo,handles.x_Ou,handles.y_Ou,handles.x_Uo,handles.y_Uo);

Data = [Halsdicke_eintauch Halsdicke_austauch Hinterschnitt_eintauch Hinterschnitt_austauch];
% C = categorical({'HD ES','HD AS','HS ES','HS AS'});
% C = {'HD ES','HD AS','HS ES','HS AS'};
ax = axes(f1);
b = bar(ax, Data);
% h = histogram(ax, C,'BarWidth',0.5);
% legend(ax,'Halsdicke Eintauchseite','Halsdicke Austauchseite','Hinterschnitt Eintauchseite','Hinterschnitt Austauchseite')
xlabel(ax,'Merkmale')
ylabel(ax,'Länge in mm')
set(ax,'YTick', (0:0.1:2.0))
xlabelbar = {'Halsdicke ES','Halsdicke AS','Hinterschnitt ES','Hinterschnitt AS'};
set(ax,'xticklabel',xlabelbar);
% b(2).EdgeColor  = 'b';
% b(3).FaceColor = 'g';
% b(4).FaceColor = 'y';
grid on 
hold off

handles.hd_as_ms = Halsdicke_austauch;
handles.hd_es_ms = Halsdicke_eintauch;
handles.hs_as_ms = Hinterschnitt_austauch;
handles.hs_es_ms = Hinterschnitt_eintauch;




%%%
% Save the handles structure.
guidata(hObject,handles)

% --- Executes on button press in pushbutton_compare_bar.
function pushbutton_compare_bar_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_compare_bar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

xlabelbar = {'Schliffbild','Simulation'};

f2 = figure(30);
set(f2, 'Name', 'Comparison','NumberTitle','off');
ax = axes(f2);
[Halsdicke_austauch,Halsdicke_eintauch,Hinterschnitt_austauch,Hinterschnitt_eintauch] = Analysis_SIMULATION(handles.X_Oo_GUI, handles.Y_Oo_GUI, handles.X_Ou_GUI, handles.Y_Ou_GUI, handles.X_Uo_GUI, handles.Y_Uo_GUI);

handles.hd_as_aw = Halsdicke_austauch;
handles.hd_es_aw = Halsdicke_eintauch;
handles.hs_as_aw = Hinterschnitt_austauch;
handles.hs_es_aw = Hinterschnitt_eintauch;

handles.hd_as = [handles.hd_as_ms, handles.hd_as_aw];
handles.hd_es = [handles.hd_es_ms, handles.hd_es_aw];
handles.hs_as = [handles.hs_as_ms, handles.hs_as_aw];
handles.hs_es = [handles.hs_es_ms, handles.hs_es_aw];

Data = [handles.hd_es' handles.hd_as' handles.hs_es' handles.hs_as'];
disp(Data)
bar(ax, Data);
xlabel(ax,'Merkmale');
ylabel(ax,'Länge in mm');

legend(ax,'Halsdicke Eintauchseite','Halsdicke Austauchseite','Hinterschnitt Eintauchseite','Hinterschnitt Austauchseite')
set(ax,'YTick', (0:0.1:2.0))
set(ax,'xticklabel',xlabelbar);
%set(ax,'XTick',[1:1:length(Versuchsnummer)])
grid on 
hold off
%%%
% Save the handles structure.
guidata(hObject,handles)


% --- Executes on button press in pushbutton_get_undercut.
function pushbutton_get_undercut_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_get_undercut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% figure()
% imshow(handles.I);
% 
% [uc_x, uc_y] = getpts();
% 
% uc_dis = abs(uc_x(1)-uc_x(2));
% 
% 
% handles.scale = scale;
% close(gcf);
% 
% % 
% set(handles.edit_scale, 'String', handles.scale);
% 
% 
% % Save the handles structure.
% guidata(hObject,handles)














