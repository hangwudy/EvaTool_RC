function varargout = Auswertungstool(varargin)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%         Version 0.70                                                %%%
%%%         Last updated on July 03, 2018                               %%%
%%%         Created by Hang Wu at utg of TUM on April 30, 2018          %%%
%%%         Feedback & support: h.wu@tum.de                             %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% AUSWERTUNGSTOOL MATLAB code for Auswertungstool.fig
%      AUSWERTUNGSTOOL, by itself, creates a new AUSWERTUNGSTOOL or raises the existing
%      singleton*.
%
%      H = AUSWERTUNGSTOOL returns the handle to a new AUSWERTUNGSTOOL or the handle to
%      the existing singleton*.
%
%      AUSWERTUNGSTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUSWERTUNGSTOOL.M with the given input arguments.
%
%      AUSWERTUNGSTOOL('Property','Value',...) creates a new AUSWERTUNGSTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Auswertungstool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Auswertungstool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Auswertungstool

% Last Modified by GUIDE v2.5 25-Jun-2018 12:22:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Auswertungstool_OpeningFcn, ...
                   'gui_OutputFcn',  @Auswertungstool_OutputFcn, ...
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


% --- Executes just before Auswertungstool is made visible.
function Auswertungstool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Auswertungstool (see VARARGIN)

clc
% Choose default command line output for Auswertungstool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Auswertungstool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Auswertungstool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_input_raw.
function pushbutton_input_raw_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_input_raw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%

FileName = [];
file = [];
[FileName,PathName] = uigetfile('*.txt','Select the Data file','MultiSelect','on');
for i = 1:length(FileName)
    file = [file fullfile(PathName,FileName(i))];
end

set(handles.edit_data_path, 'String',PathName);
set(handles.listbox_selected_files, 'String', FileName);
Num_of_files = length(FileName);
% display(Num_of_files)
edit_total_string = ['Total ', num2str(Num_of_files), ' files'];
set(handles.edit_total_files, 'String', edit_total_string);
%
handles.Dateipfad = PathName;



%
% Color
Color = strsplit(get(handles.edit_color, 'String'),', ');
handles.Color = Color;
% display(handles.Color);
% -> {'r'}    {'b'}    {'g'}    {'k'}    {'y'}    {'m'}    {'c'}    {'r'}
%

% Initialization
M_Node_All = [];
handles.M_Node_All = M_Node_All;
handles.scope_enlarge = false;
%M_Scope = [];

M_Scope(1,1) = str2double(get(handles.edit_x_1, 'String'));
M_Scope(1,2) = str2double(get(handles.edit_x_2, 'String'));
M_Scope(2,1) = str2double(get(handles.edit_y_1, 'String'));
M_Scope(2,2) = str2double(get(handles.edit_y_2, 'String'));
handles.M_Scope = M_Scope;

M_NT = [];
handles.M_NT = M_NT;
M_UC = [];
handles.M_UC = M_UC;





% Save the handles structure.
guidata(hObject,handles)


function edit_data_path_Callback(hObject, eventdata, handles)
% hObject    handle to edit_data_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_data_path as text
%        str2double(get(hObject,'String')) returns contents of edit_data_path as a double


% --- Executes during object creation, after setting all properties.
function edit_data_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_data_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_selected_files.
function listbox_selected_files_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_selected_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_selected_files contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_selected_files


% --- Executes during object creation, after setting all properties.
function listbox_selected_files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_selected_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_total_files_Callback(hObject, eventdata, handles)
% hObject    handle to edit_total_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_total_files as text
%        str2double(get(hObject,'String')) returns contents of edit_total_files as a double
% print(gcf,'-deps','GUI_test.eps')

% --- Executes during object creation, after setting all properties.
function edit_total_files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_total_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_test_number.
function pushbutton_test_number_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_test_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


Versuchsnummer_list = get(handles.listbox_selected_files, 'String');
% Convert into number
Versuchsnummer_list_cell_array = regexp(Versuchsnummer_list,'\d+(\.)?(\d+)?','match');
Versuchsnummer = unique(cellstr([Versuchsnummer_list_cell_array{:}]));
% display(Versuchsnummer);
% -> {'150'}    {'151'}    {'152'}    {'153'}    {'154'}    {'155'}    {'156'}    {'157'}    {'158'}
Versuchsnummer_num = unique(str2double([Versuchsnummer_list_cell_array{:}]));
% display(Versuchsnummer_num);
% test_123 = str2double(unique(Versuchsnummer));
% display(test_123);
% -> 150   151   152   153   154   155   156   157   158
% In list display
set(handles.listbox_test_number,'String',Versuchsnummer)
%
% 
test_nr = length(Versuchsnummer);
%

handles.Versuchsnummer = Versuchsnummer;
handles.Versuchsnummer_num = Versuchsnummer_num;
% calculate Node_end 

M_Node_End = [];
for i = 1:test_nr
    % oo
    M = [];
    Dateiname = sprintf('%sOutput-Nr-%d_oo_start.txt',handles.edit_data_path.String,handles.Versuchsnummer_num(i));
    M = dlmread(Dateiname,';',0,0);
    clearvars Dateiname
    M_Node_End(i) = length(M(:,1));
end
% display(M_Node_End)
handles.M_Node_End = M_Node_End;
handles.test_nr = test_nr;

% advanced settings test number
% 1
i = 1;
if i <= handles.test_nr
    set(handles.text_test_1, 'String', handles.Versuchsnummer(i));
    set(handles.text_node_end_1, 'String', handles.M_Node_End(i));
    set(handles.edit_t1_n1, 'String', '45');
    set(handles.edit_t1_n2, 'String', '95');

else
    set(handles.text_test_1, 'String', 'N/A');
    set(handles.edit_t1_n1, 'String', 'N/A');
    set(handles.edit_t1_n2, 'String', 'N/A');
    set(handles.text_node_end_1, 'String', 'N/A');
end
i = i+1;
% 2
if i <= handles.test_nr
    set(handles.text_test_2, 'String', handles.Versuchsnummer(i));
    set(handles.text_node_end_2, 'String', handles.M_Node_End(i));
    set(handles.edit_t2_n1, 'String', '45');
    set(handles.edit_t2_n2, 'String', '95');

else
    set(handles.text_test_2, 'String', 'N/A');
    set(handles.edit_t2_n1, 'String', 'N/A');
    set(handles.edit_t2_n2, 'String', 'N/A');
    set(handles.text_node_end_2, 'String', 'N/A');
end
i = i+1;
% 3
if i <= handles.test_nr
    set(handles.text_test_3, 'String', handles.Versuchsnummer(i));
    set(handles.text_node_end_3, 'String', handles.M_Node_End(i));
    set(handles.edit_t3_n1, 'String', '45');
    set(handles.edit_t3_n2, 'String', '95');

else
    set(handles.text_test_3, 'String', 'N/A');
    set(handles.edit_t3_n1, 'String', 'N/A');
    set(handles.edit_t3_n2, 'String', 'N/A');
    set(handles.text_node_end_3, 'String', 'N/A');
end
i = i+1;
% 4
if i <= handles.test_nr
    set(handles.text_test_4, 'String', handles.Versuchsnummer(i));
    set(handles.text_node_end_4, 'String', handles.M_Node_End(i));
    set(handles.edit_t4_n1, 'String', '45');
    set(handles.edit_t4_n2, 'String', '95');

else
    set(handles.text_test_4, 'String', 'N/A');
    set(handles.edit_t4_n1, 'String', 'N/A');
    set(handles.edit_t4_n2, 'String', 'N/A');
    set(handles.text_node_end_4, 'String', 'N/A');
end
i = i+1;
% 5
if i <= handles.test_nr
    set(handles.text_test_5, 'String', handles.Versuchsnummer(i));
    set(handles.text_node_end_5, 'String', handles.M_Node_End(i));
    set(handles.edit_t5_n1, 'String', '45');
    set(handles.edit_t5_n2, 'String', '95');

else
    set(handles.text_test_5, 'String', 'N/A');
    set(handles.edit_t5_n1, 'String', 'N/A');
    set(handles.edit_t5_n2, 'String', 'N/A');
    set(handles.text_node_end_5, 'String', 'N/A');
end
i = i+1;
% 6
if i <= handles.test_nr
    set(handles.text_test_6, 'String', handles.Versuchsnummer(i));
    set(handles.text_node_end_6, 'String', handles.M_Node_End(i));
    set(handles.edit_t6_n1, 'String', '45');
    set(handles.edit_t6_n2, 'String', '95');

else
    set(handles.text_test_6, 'String', 'N/A');
    set(handles.edit_t6_n1, 'String', 'N/A');
    set(handles.edit_t6_n2, 'String', 'N/A');
    set(handles.text_node_end_6, 'String', 'N/A');
end
i = i+1;
% 7
if i <= handles.test_nr
    set(handles.text_test_7, 'String', handles.Versuchsnummer(i));
    set(handles.text_node_end_7, 'String', handles.M_Node_End(i));
    set(handles.edit_t7_n1, 'String', '45');
    set(handles.edit_t7_n2, 'String', '95');

else
    set(handles.text_test_7, 'String', 'N/A');
    set(handles.edit_t7_n1, 'String', 'N/A');
    set(handles.edit_t7_n2, 'String', 'N/A');
    set(handles.text_node_end_7, 'String', 'N/A');
end
i = i+1;
% 8
if i <= handles.test_nr
    set(handles.text_test_8, 'String', handles.Versuchsnummer(i));
    set(handles.text_node_end_8, 'String', handles.M_Node_End(i));
    set(handles.edit_t8_n1, 'String', '45');
    set(handles.edit_t8_n2, 'String', '95');
else
    set(handles.text_test_8, 'String', 'N/A');
    set(handles.edit_t8_n1, 'String', 'N/A');
    set(handles.edit_t8_n2, 'String', 'N/A');
    set(handles.text_node_end_8, 'String', 'N/A');
end
i = i+1;
% 9
if i <= handles.test_nr
    set(handles.text_test_9, 'String', handles.Versuchsnummer(i));
    set(handles.text_node_end_9, 'String', handles.M_Node_End(i));
    set(handles.edit_t9_n1, 'String', '45');
    set(handles.edit_t9_n2, 'String', '95');

else
    set(handles.text_test_9, 'String', 'N/A');
    set(handles.edit_t9_n1, 'String', 'N/A');
    set(handles.edit_t9_n2, 'String', 'N/A');
    set(handles.text_node_end_9, 'String', 'N/A');
end





% test
% display(handles.Dateipfad);
% -> Y:\Hiwi\Simulation\Postprocessing_Data\
% display(handles.Versuchsnummer);
% -> {'150'}    {'151'}    {'152'}    {'153'}    {'154'}    {'155'}    {'156'}    {'157'}    {'158'}
%
% Save the handles structure.
guidata(hObject,handles)

% --- Executes on selection change in listbox_test_number.
function listbox_test_number_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_test_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_test_number contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_test_number


% --- Executes during object creation, after setting all properties.
function listbox_test_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_test_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_color_Callback(hObject, eventdata, handles)
% hObject    handle to edit_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_color as text
%        str2double(get(hObject,'String')) returns contents of edit_color as a double


% --- Executes during object creation, after setting all properties.
function edit_color_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_analyse.
function pushbutton_analyse_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% clear axes in GUI
cla reset

%
Linewidth = 1.5;
Massstab = 1;
Offset_x = 0;
Offset_y = 0;
%
handles.Linewidth = Linewidth;
handles.Massstab = Massstab;
handles.Offset_x = Offset_x;
handles.Offset_y = Offset_y;



% advanced settings test number
% 1
i = 1;
if i <= handles.test_nr
    M_Node(1,1) = str2double(get(handles.edit_t1_n1, 'String'));
    M_Node(1,2) = str2double(get(handles.edit_t1_n2, 'String'));
end
i = i+1;
% 2
if i <= handles.test_nr
    M_Node(2,1) = str2double(get(handles.edit_t2_n1, 'String'));
    M_Node(2,2) = str2double(get(handles.edit_t2_n2, 'String'));
end
i = i+1;
% 3
if i <= handles.test_nr
    M_Node(3,1) = str2double(get(handles.edit_t3_n1, 'String'));
    M_Node(3,2) = str2double(get(handles.edit_t3_n2, 'String'));
end
i = i+1;
% 4
if i <= handles.test_nr
    M_Node(4,1) = str2double(get(handles.edit_t4_n1, 'String'));
    M_Node(4,2) = str2double(get(handles.edit_t4_n2, 'String'));
end
i = i+1;
% 5
if i <= handles.test_nr
    M_Node(5,1) = str2double(get(handles.edit_t5_n1, 'String'));
    M_Node(5,2) = str2double(get(handles.edit_t5_n2, 'String'));
end
i = i+1;
% 6
if i <= handles.test_nr
    M_Node(6,1) = str2double(get(handles.edit_t6_n1, 'String'));
    M_Node(6,2) = str2double(get(handles.edit_t6_n2, 'String'));
end
i = i+1;
% 7
if i <= handles.test_nr
    M_Node(7,1) = str2double(get(handles.edit_t7_n1, 'String'));
    M_Node(7,2) = str2double(get(handles.edit_t7_n2, 'String'));
end
i = i+1;
% 8
if i <= handles.test_nr
    M_Node(8,1) = str2double(get(handles.edit_t8_n1, 'String'));
    M_Node(8,2) = str2double(get(handles.edit_t8_n2, 'String'));
end
i = i+1;
% 9
if i <= handles.test_nr
    M_Node(9,1) = str2double(get(handles.edit_t9_n1, 'String'));
    M_Node(9,2) = str2double(get(handles.edit_t9_n2, 'String'));
end

% merge
%
handles.M_Node = M_Node;
% display(handles.M_Node_End)
%
% don't forget to transpose the M_Node_End
handles.M_Node_All = [handles.Versuchsnummer_num.', handles.M_Node, handles.M_Node_End.'];







%
fid=fopen('Halsdicke-Hinterschnitt.txt','w');
% Header line
fprintf(fid, 'Versuchsnummer\t Halsdicke eintauch in mm\t Halsdicke austauch in mm\t Hinterschnitt eintauch in mm\t Hinterschnitt austauch in mm\r\n');
fclose(fid);


i=1;
while i<=length(handles.Versuchsnummer)
    [x_oo{i},y_oo{i},x_ou{i},y_ou{i},x_uo{i},y_uo{i},x_uu{i},y_uu{i},achsenabschnitt(i),Halsdicke_austauch(i),Halsdicke_eintauch(i),Hinterschnitt_austauch(i),Hinterschnitt_eintauch(i)]=CP_Analyse(handles.Dateipfad,handles.Versuchsnummer{i},handles.Color{mod(i,length(handles.Color))+1},handles.M_Node_All, handles.M_Scope, handles.M_NT,handles.M_UC, handles.scope_enlarge);
    %
    % axes(handles.axes1);
    f1 = figure(1);
    set(f1, 'Name', 'Aligned curves','NumberTitle','off');
    hold on
    h_oo(i)=plot(x_oo{i}*handles.Massstab+handles.Offset_x,y_oo{i}*handles.Massstab+handles.Offset_y,'Color',handles.Color{mod(i,length(handles.Color))+1},'LineWidth',handles.Linewidth);
    hold on
    h_ou=plot(x_ou{i}*handles.Massstab+handles.Offset_x,y_ou{i}*handles.Massstab+handles.Offset_y,'Color',handles.Color{mod(i,length(handles.Color))+1},'LineWidth',handles.Linewidth);
    hold on
    h_uo=plot(x_uo{i}*handles.Massstab+handles.Offset_x,y_uo{i}*handles.Massstab+handles.Offset_y,'Color',handles.Color{mod(i,length(handles.Color))+1},'LineWidth',handles.Linewidth);
    hold on
    h_uu=plot(x_uu{i}*handles.Massstab+handles.Offset_x,y_uu{i}*handles.Massstab+handles.Offset_y,'Color',handles.Color{mod(i,length(handles.Color))+1},'LineWidth',handles.Linewidth);
    hold on
    grid on
    axis equal
    %legend(h_oo(i),sprintf('%s',handles.Versuchsnummer{i}))
    hold on
    
    %
    % Kennwerte in Textdatei schreiben
    fid=fopen('Halsdicke-Hinterschnitt.txt','a');
    fprintf(fid, '%s\t%f\t %f\t %f\t %f\r\n',handles.Versuchsnummer{i},Halsdicke_eintauch(i),Halsdicke_austauch(i),Hinterschnitt_eintauch(i),Hinterschnitt_austauch(i));
    fclose(fid);
    
    % save data x_oo ...
    % for compare with microsection
    x_Oo = x_oo{i};
    y_Oo = y_oo{i};
    x_Ou = x_ou{i};
    y_Ou = y_ou{i};
    x_Uo = x_uo{i};
    y_Uo = y_uo{i};
    x_Uu = x_uu{i};
    y_Uu = y_uu{i};
    save(sprintf('%s.mat',['Versuchsnummer',num2str(i)]),'x_Oo','y_Oo','x_Ou','y_Ou','x_Uo','y_Uo','x_Uu','y_Uu')
%     uiwait(msgbox('Saved!','Kontur','help','modal'))
    clearvars x_Oo y_Oo x_Ou y_Ou x_Uo y_Uo x_Uu y_Uu
    disp('Gespeichert')
    i=i+1;
end


hold on
legend(h_oo,handles.Versuchsnummer);


% axes(handles.axes1)
f2 = figure(2);
set(f2, 'Name', 'Results','NumberTitle','off');
Data = [Halsdicke_eintauch' Halsdicke_austauch' Hinterschnitt_eintauch' Hinterschnitt_austauch'];
bar(Data);
set(gca,'xticklabel',handles.Versuchsnummer);
legend('Halsdicke Eintauchseite','Halsdicke Austauchseite','Hinterschnitt Eintauchseite','Hinterschnitt Austauchseite')
xlabel('Versuchsnummer')
ylabel('Länge in mm')
ax = gca;
set(ax,'YTick',[0:0.1:2.0])
%set(ax,'XTick',[1:1:length(Versuchsnummer)])
grid on 
% in-Display

axes(handles.axes1)
bar(Data);


% saveas(gca,'Auswertung.eps')
% saveas(gca,'Auswertung.png')
fclose('all');




% Save the handles structure.
guidata(hObject,handles)



function edit_t1_n1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t1_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t1_n1 as text
%        str2double(get(hObject,'String')) returns contents of edit_t1_n1 as a double


% --- Executes during object creation, after setting all properties.
function edit_t1_n1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t1_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t1_n2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t1_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t1_n2 as text
%        str2double(get(hObject,'String')) returns contents of edit_t1_n2 as a double


% --- Executes during object creation, after setting all properties.
function edit_t1_n2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t1_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t2_n1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t2_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t2_n1 as text
%        str2double(get(hObject,'String')) returns contents of edit_t2_n1 as a double


% --- Executes during object creation, after setting all properties.
function edit_t2_n1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t2_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t2_n2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t2_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t2_n2 as text
%        str2double(get(hObject,'String')) returns contents of edit_t2_n2 as a double


% --- Executes during object creation, after setting all properties.
function edit_t2_n2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t2_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t3_n1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t3_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t3_n1 as text
%        str2double(get(hObject,'String')) returns contents of edit_t3_n1 as a double


% --- Executes during object creation, after setting all properties.
function edit_t3_n1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t3_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t3_n2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t3_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t3_n2 as text
%        str2double(get(hObject,'String')) returns contents of edit_t3_n2 as a double


% --- Executes during object creation, after setting all properties.
function edit_t3_n2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t3_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t4_n1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t4_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t4_n1 as text
%        str2double(get(hObject,'String')) returns contents of edit_t4_n1 as a double


% --- Executes during object creation, after setting all properties.
function edit_t4_n1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t4_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t4_n2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t4_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t4_n2 as text
%        str2double(get(hObject,'String')) returns contents of edit_t4_n2 as a double


% --- Executes during object creation, after setting all properties.
function edit_t4_n2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t4_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t5_n1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t5_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t5_n1 as text
%        str2double(get(hObject,'String')) returns contents of edit_t5_n1 as a double


% --- Executes during object creation, after setting all properties.
function edit_t5_n1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t5_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t5_n2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t5_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t5_n2 as text
%        str2double(get(hObject,'String')) returns contents of edit_t5_n2 as a double


% --- Executes during object creation, after setting all properties.
function edit_t5_n2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t5_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t6_n1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t6_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t6_n1 as text
%        str2double(get(hObject,'String')) returns contents of edit_t6_n1 as a double


% --- Executes during object creation, after setting all properties.
function edit_t6_n1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t6_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t6_n2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t6_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t6_n2 as text
%        str2double(get(hObject,'String')) returns contents of edit_t6_n2 as a double


% --- Executes during object creation, after setting all properties.
function edit_t6_n2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t6_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t7_n1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t7_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t7_n1 as text
%        str2double(get(hObject,'String')) returns contents of edit_t7_n1 as a double


% --- Executes during object creation, after setting all properties.
function edit_t7_n1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t7_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t7_n2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t7_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t7_n2 as text
%        str2double(get(hObject,'String')) returns contents of edit_t7_n2 as a double


% --- Executes during object creation, after setting all properties.
function edit_t7_n2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t7_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t8_n1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t8_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t8_n1 as text
%        str2double(get(hObject,'String')) returns contents of edit_t8_n1 as a double


% --- Executes during object creation, after setting all properties.
function edit_t8_n1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t8_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t8_n2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t8_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t8_n2 as text
%        str2double(get(hObject,'String')) returns contents of edit_t8_n2 as a double


% --- Executes during object creation, after setting all properties.
function edit_t8_n2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t8_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t9_n1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t9_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t9_n1 as text
%        str2double(get(hObject,'String')) returns contents of edit_t9_n1 as a double


% --- Executes during object creation, after setting all properties.
function edit_t9_n1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t9_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t9_n2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t9_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t9_n2 as text
%        str2double(get(hObject,'String')) returns contents of edit_t9_n2 as a double


% --- Executes during object creation, after setting all properties.
function edit_t9_n2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t9_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_update.
function pushbutton_update_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_update (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% get the numbers & save as matrix



% advanced settings test number
% 1
i = 1;
if i <= handles.test_nr
    M_Node(1,1) = str2double(get(handles.edit_t1_n1, 'String'));
    M_Node(1,2) = str2double(get(handles.edit_t1_n2, 'String'));
end
i = i+1;
% 2
if i <= handles.test_nr
    M_Node(2,1) = str2double(get(handles.edit_t2_n1, 'String'));
    M_Node(2,2) = str2double(get(handles.edit_t2_n2, 'String'));
end
i = i+1;
% 3
if i <= handles.test_nr
    M_Node(3,1) = str2double(get(handles.edit_t3_n1, 'String'));
    M_Node(3,2) = str2double(get(handles.edit_t3_n2, 'String'));
end
i = i+1;
% 4
if i <= handles.test_nr
    M_Node(4,1) = str2double(get(handles.edit_t4_n1, 'String'));
    M_Node(4,2) = str2double(get(handles.edit_t4_n2, 'String'));
end
i = i+1;
% 5
if i <= handles.test_nr
    M_Node(5,1) = str2double(get(handles.edit_t5_n1, 'String'));
    M_Node(5,2) = str2double(get(handles.edit_t5_n2, 'String'));
end
i = i+1;
% 6
if i <= handles.test_nr
    M_Node(6,1) = str2double(get(handles.edit_t6_n1, 'String'));
    M_Node(6,2) = str2double(get(handles.edit_t6_n2, 'String'));
end
i = i+1;
% 7
if i <= handles.test_nr
    M_Node(7,1) = str2double(get(handles.edit_t7_n1, 'String'));
    M_Node(7,2) = str2double(get(handles.edit_t7_n2, 'String'));
end
i = i+1;
% 8
if i <= handles.test_nr
    M_Node(8,1) = str2double(get(handles.edit_t8_n1, 'String'));
    M_Node(8,2) = str2double(get(handles.edit_t8_n2, 'String'));
end
i = i+1;
% 9
if i <= handles.test_nr
    M_Node(9,1) = str2double(get(handles.edit_t9_n1, 'String'));
    M_Node(9,2) = str2double(get(handles.edit_t9_n2, 'String'));
end

% merge
%
handles.M_Node = M_Node;
% display(handles.M_Node_End)
%
% don't forget to transpose the M_Node_End
handles.M_Node_All = [handles.Versuchsnummer_num.', handles.M_Node, handles.M_Node_End.'];


% test
display(handles.M_Node_All)

% set the edit off
set(handles.edit_t1_n1, 'Enable', 'off')
set(handles.edit_t1_n2, 'Enable', 'off')
set(handles.edit_t2_n1, 'Enable', 'off')
set(handles.edit_t2_n2, 'Enable', 'off')
set(handles.edit_t3_n1, 'Enable', 'off')
set(handles.edit_t3_n2, 'Enable', 'off')
set(handles.edit_t4_n1, 'Enable', 'off')
set(handles.edit_t4_n2, 'Enable', 'off')
set(handles.edit_t5_n1, 'Enable', 'off')
set(handles.edit_t5_n2, 'Enable', 'off')
set(handles.edit_t6_n1, 'Enable', 'off')
set(handles.edit_t6_n2, 'Enable', 'off')
set(handles.edit_t7_n1, 'Enable', 'off')
set(handles.edit_t7_n2, 'Enable', 'off')
set(handles.edit_t8_n1, 'Enable', 'off')
set(handles.edit_t8_n2, 'Enable', 'off')
set(handles.edit_t9_n1, 'Enable', 'off')
set(handles.edit_t9_n2, 'Enable', 'off')

% Save the handles structure.
guidata(hObject,handles)



% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% close all other figures
close(figure(100),figure(101),figure(102),figure(1),figure(2))

% clear axes in GUI
cla reset

clear all
% clear Command Window
clc



function edit_x_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_x_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_x_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_x_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_x_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_x_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_x_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_x_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_x_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_x_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_x_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_x_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_y_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_y_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_y_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_y_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_y_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_y_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_y_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_y_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_y_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_y_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_y_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_y_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_activate.
function pushbutton_activate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_activate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)






% advanced settings test number
% 1
i = 1;
if i <= handles.test_nr

    set(handles.edit_t1_n1, 'Enable', 'on')
    set(handles.edit_t1_n2, 'Enable', 'on')

end
i = i+1;
% 2
if i <= handles.test_nr

    set(handles.edit_t2_n1, 'Enable', 'on')
    set(handles.edit_t2_n2, 'Enable', 'on')

end
i = i+1;
% 3
if i <= handles.test_nr

    set(handles.edit_t3_n1, 'Enable', 'on')
    set(handles.edit_t3_n2, 'Enable', 'on')

end
i = i+1;
% 4
if i <= handles.test_nr

    set(handles.edit_t4_n1, 'Enable', 'on')
    set(handles.edit_t4_n2, 'Enable', 'on')

end
i = i+1;
% 5
if i <= handles.test_nr

    set(handles.edit_t5_n1, 'Enable', 'on')
    set(handles.edit_t5_n2, 'Enable', 'on')

end
i = i+1;
% 6
if i <= handles.test_nr

    set(handles.edit_t6_n1, 'Enable', 'on')
    set(handles.edit_t6_n2, 'Enable', 'on')

end
i = i+1;
% 7
if i <= handles.test_nr

    set(handles.edit_t7_n1, 'Enable', 'on')
    set(handles.edit_t7_n2, 'Enable', 'on')

end
i = i+1;
% 8
if i <= handles.test_nr

    set(handles.edit_t8_n1, 'Enable', 'on')
    set(handles.edit_t8_n2, 'Enable', 'on')

end
i = i+1;
% 9
if i <= handles.test_nr

    set(handles.edit_t9_n1, 'Enable', 'on')
    set(handles.edit_t9_n2, 'Enable', 'on')

end


% Save the handles structure.
guidata(hObject,handles)


% --- Executes on button press in pushbutton_activate_scope.
function pushbutton_activate_scope_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_activate_scope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_x_1, 'Enable', 'on')
set(handles.edit_x_2, 'Enable', 'on')
set(handles.edit_y_1, 'Enable', 'on')
set(handles.edit_y_2, 'Enable', 'on')


% Save the handles structure.
guidata(hObject,handles)






% --- Executes on button press in pushbutton_update_scope.
function pushbutton_update_scope_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_update_scope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


M_Scope(1,1) = str2double(get(handles.edit_x_1, 'String'));
M_Scope(1,2) = str2double(get(handles.edit_x_2, 'String'));
M_Scope(2,1) = str2double(get(handles.edit_y_1, 'String'));
M_Scope(2,2) = str2double(get(handles.edit_y_2, 'String'));
handles.M_Scope = M_Scope;
% test
display(handles.M_Scope)

%
set(handles.edit_x_1, 'Enable', 'off')
set(handles.edit_x_2, 'Enable', 'off')
set(handles.edit_y_1, 'Enable', 'off')
set(handles.edit_y_2, 'Enable', 'off')


% Save the handles structure.
guidata(hObject,handles)





function edit_neck_thickness_y1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_neck_thickness_y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_neck_thickness_y1 as text
%        str2double(get(hObject,'String')) returns contents of edit_neck_thickness_y1 as a double


% --- Executes during object creation, after setting all properties.
function edit_neck_thickness_y1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_neck_thickness_y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_neck_thickness_y2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_neck_thickness_y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_neck_thickness_y2 as text
%        str2double(get(hObject,'String')) returns contents of edit_neck_thickness_y2 as a double


% --- Executes during object creation, after setting all properties.
function edit_neck_thickness_y2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_neck_thickness_y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit32_Callback(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit32 as text
%        str2double(get(hObject,'String')) returns contents of edit32 as a double


% --- Executes during object creation, after setting all properties.
function edit32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit33_Callback(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit33 as text
%        str2double(get(hObject,'String')) returns contents of edit33 as a double


% --- Executes during object creation, after setting all properties.
function edit33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_undercut_left_y1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_undercut_left_y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_undercut_left_y1 as text
%        str2double(get(hObject,'String')) returns contents of edit_undercut_left_y1 as a double


% --- Executes during object creation, after setting all properties.
function edit_undercut_left_y1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_undercut_left_y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_undercut_left_y2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_undercut_left_y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_undercut_left_y2 as text
%        str2double(get(hObject,'String')) returns contents of edit_undercut_left_y2 as a double


% --- Executes during object creation, after setting all properties.
function edit_undercut_left_y2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_undercut_left_y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_undercut_right_y1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_undercut_right_y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_undercut_right_y1 as text
%        str2double(get(hObject,'String')) returns contents of edit_undercut_right_y1 as a double


% --- Executes during object creation, after setting all properties.
function edit_undercut_right_y1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_undercut_right_y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_undercut_right_y2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_undercut_right_y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_undercut_right_y2 as text
%        str2double(get(hObject,'String')) returns contents of edit_undercut_right_y2 as a double


% --- Executes during object creation, after setting all properties.
function edit_undercut_right_y2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_undercut_right_y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_activate_undercut.
function pushbutton_activate_undercut_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_activate_undercut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


set(handles.edit_undercut_left_y1, 'Enable', 'on')
set(handles.edit_undercut_left_y2, 'Enable', 'on')
set(handles.edit_undercut_right_y1, 'Enable', 'on')
set(handles.edit_undercut_right_y2, 'Enable', 'on')



% Save the handles structure.
guidata(hObject,handles)



% --- Executes on button press in pushbutton_update_undercut.
function pushbutton_update_undercut_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_update_undercut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%
M_UC(1,1) = str2double(get(handles.edit_undercut_left_y1, 'String'));
M_UC(1,2) = str2double(get(handles.edit_undercut_left_y2, 'String'));
M_UC(2,1) = str2double(get(handles.edit_undercut_right_y1, 'String'));
M_UC(2,2) = str2double(get(handles.edit_undercut_right_y2, 'String'));
handles.M_UC = M_UC;
% test
display(handles.M_UC)
%
set(handles.edit_undercut_left_y1, 'Enable', 'off')
set(handles.edit_undercut_left_y2, 'Enable', 'off')
set(handles.edit_undercut_right_y1, 'Enable', 'off')
set(handles.edit_undercut_right_y2, 'Enable', 'off')



% Save the handles structure.
guidata(hObject,handles)



% --- Executes on button press in pushbutton_activate_neck_thickness.
function pushbutton_activate_neck_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_activate_neck_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit_neck_thickness_y1, 'Enable', 'on')
set(handles.edit_neck_thickness_y2, 'Enable', 'on')
% Save the handles structure.
guidata(hObject,handles)


% --- Executes on button press in pushbutton_update_neck_thickness.
function pushbutton_update_neck_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_update_neck_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M_NT(1,1) = str2double(get(handles.edit_neck_thickness_y1, 'String'));
M_NT(1,2) = str2double(get(handles.edit_neck_thickness_y2, 'String'));
handles.M_NT = M_NT;
% test
display(handles.M_NT)

set(handles.edit_neck_thickness_y1, 'Enable', 'off')
set(handles.edit_neck_thickness_y2, 'Enable', 'off')
% Save the handles structure.
guidata(hObject,handles)


% --- Executes on button press in pushbutton_screenshot.
function pushbutton_screenshot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_screenshot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% saveas(gcf, 'output', 'bmp')
% wait(hObject,2);
saveas(gcf, 'output', 'eps')

h = getframe(gcf);
imwrite(h.cdata,'GUI.png');
% imwrite(h.cdata,'GUI.tiff');
% print(gcf,'-deps','GUI.eps')
% print(gcf,'-dpdf','test.pdf')


% --- Executes on button press in pushbutton_enlarge.
function pushbutton_enlarge_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_enlarge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.scope_enlarge = true;
display(handles.scope_enlarge)

% Save the handles structure.
guidata(hObject,handles)


% --- Executes on button press in pushbutton_shrink.
function pushbutton_shrink_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_shrink (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.scope_enlarge = false;
display(handles.scope_enlarge)
% Save the handles structure.
guidata(hObject,handles)
