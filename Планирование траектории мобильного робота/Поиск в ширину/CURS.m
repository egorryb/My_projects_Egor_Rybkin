function varargout = CURS(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CURS_OpeningFcn, ...
                   'gui_OutputFcn',  @CURS_OutputFcn, ...
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


function CURS_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);


function varargout = CURS_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function popupmenu4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function checkbox2_Callback(hObject, eventdata, handles)
tagv1=findobj(gcf,'tag','checkbox2'); 
v1=tagv1.Value;
tagv2=findobj(gcf,'tag','checkbox4'); 
v2=tagv2.Value;
if(v1==1 && v2==1)
    tagv2.Value=0;
elseif(v1==0)
    tagv1.Value=1;
end

function checkbox4_Callback(hObject, eventdata, handles)
tagv1=findobj(gcf,'tag','checkbox2'); 
v1=tagv1.Value;
tagv2=findobj(gcf,'tag','checkbox4'); 
v2=tagv2.Value;
if(v1==1 && v2==1)
    tagv1.Value=0;
elseif(v2==0)
    tagv2.Value=1;
end
%Функция, которая работает при нажатии кнопки "Принять" в области выбора
%раставления траектории: самому или случайно
function pushbutton2_Callback(hObject, eventdata, handles)
tagv1=findobj(gcf,'tag','checkbox2'); 
tagv2=findobj(gcf,'tag','checkbox4'); 
tagv1.Enable='off';
tagv2.Enable='off';
tagv3=findobj(gcf,'tag','pushbutton5'); 
tagv3.Enable='on';
tagv4=findobj(gcf,'tag','pushbutton2');
tagv4.Enable = 'off';

function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%Функция, которая работает при нажатии кнопки "Принять" в области выбора
%начальной и конечной точки
function pushbutton3_Callback(hObject, eventdata, handles)
tagv1=findobj(gcf,'tag', 'edit3'); 
edit3=str2double(tagv1.String);
tagv2=findobj(gcf,'tag','edit4');
edit4=str2double(tagv2.String);
tagv3=findobj(gcf,'tag','edit5');
edit5=str2double(tagv3.String);
tagv4=findobj(gcf,'tag','edit6');
tagtxt=findobj(gcf,'tag','text16'); 
edit6=str2double(tagv4.String);
tagXmax=findobj(gcf,'tag','popupmenu2'); 
Xmax=tagXmax.Value+1;
tagYmax=findobj(gcf,'tag', 'popupmenu4'); 
Ymax=tagYmax.Value+1;
if  isnan(edit3)==1 || isnan(edit4)==1 || isnan(edit5)==1 || isnan(edit6)==1 
tagtxt.String='Не полностью заполнено поле с координатами начального и конечного положения';  
elseif strcmp(tagv1.String,tagv3.String)==1 && strcmp(tagv2.String,tagv4.String)==1 
tagtxt.String='Начальная и конечная точка не могут совпадать, измените координаты';
elseif ((edit3>=Xmax) || (edit4>=Ymax) || (edit5>=Xmax) || (edit6>=Ymax))
tagtxt.String='Кооридинаты начальной и конечной точки превышают масштаб карты. Измените масштаб карты или коррдинаты начальной и конечной точки'; 
else
tagv1.Enable='off';
tagv2.Enable='off';
tagv3.Enable='off';
tagv4.Enable='off';
tagv5=findobj(gcf,'tag','pushbutton3'); 
tagv5.Enable='off';
tagv6=findobj(gcf,'tag','pushbutton4');
tagv6.Enable = 'on';
tagtxt.String ='Для построения карты выберете параметры и нажмите кнопку "Построить карту"';
end

function pushbutton5_Callback(hObject, eventdata, handles)
tagv1=findobj(gcf,'tag','checkbox2'); 
tagv2=findobj(gcf,'tag','checkbox4'); 
tagv1.Enable='on';
tagv2.Enable='on';
tagv3=findobj(gcf,'tag','pushbutton5'); 
tagv3.Enable='off';
tagv4=findobj(gcf,'tag','pushbutton2');
tagv4.Enable = 'on';

function pushbutton4_Callback(hObject, eventdata, handles)
tagv1=findobj(gcf,'tag', 'edit3');
edit3=str2double(tagv1.String);
tagv2=findobj(gcf,'tag','edit4');
edit4=str2double(tagv2.String);
tagv3=findobj(gcf,'tag','edit5');
edit5=str2double(tagv3.String);
tagv4=findobj(gcf,'tag','edit6');
edit6=str2double(tagv4.String);
tagv1.Enable='on';
tagv2.Enable='on';
tagv3.Enable='on';
tagv4.Enable='on';
tagv5=findobj(gcf,'tag','pushbutton3'); 
tagv5.Enable='on';
tagv6=findobj(gcf,'tag','pushbutton4');
tagv6.Enable = 'off';


function pushbutton6_Callback(hObject, eventdata, handles)
tagtxt=findobj(gcf,'tag', 'edit16');
tagv1=findobj(gcf,'tag', 'edit3');
edit3=str2double(tagv1.String);
tagv2=findobj(gcf,'tag','edit4');
edit4=str2double(tagv2.String);
tagv3=findobj(gcf,'tag','edit5');
edit5=str2double(tagv3.String);
tagv4=findobj(gcf,'tag','edit6');
edit6=str2double(tagv4.String);
tagXmax=findobj(gcf,'tag','popupmenu2'); 
Xmax=tagXmax.Value+1;
tagYmax=findobj(gcf,'tag', 'popupmenu4'); 
Ymax=tagYmax.Value+1;
tagv1=findobj(gcf,'tag','popupmenu2'); 
tagv2=findobj(gcf,'tag','popupmenu4'); 
tagv1.Enable='off';
tagv2.Enable='off';
tagv3=findobj(gcf,'tag','pushbutton7'); 
tagv3.Enable='on';
tagv4=findobj(gcf,'tag','pushbutton6');
tagv4.Enable = 'off';

function pushbutton7_Callback(hObject, eventdata, handles)
tagv1=findobj(gcf,'tag','popupmenu2'); 
tagv2=findobj(gcf,'tag','popupmenu4'); 
tagv1.Enable='on';
tagv2.Enable='on';
tagv3=findobj(gcf,'tag','pushbutton7'); 
tagv3.Enable='off';
tagv4=findobj(gcf,'tag','pushbutton6');
tagv4.Enable = 'on';

%Функция, которая работает при нажатии кнопки "Построить карту"
%в зависимости от того, какой чекбокс был выбран, использует функцию,
%которая создает структуру графа
function pushbutton8_Callback(hObject, eventdata, handles)
tagv1=findobj(gcf,'tag', 'pushbutton2'); 
tagv2=findobj(gcf,'tag','pushbutton6');
tagv3=findobj(gcf,'tag','pushbutton3');
tagvstart=findobj(gcf,'tag', 'pushbutton8');
tagbut=findobj(gcf,'tag', 'pushbutton10');
tagve4=findobj(gcf,'tag','edit3');
tagve5=findobj(gcf,'tag', 'edit4'); 
tagve6=findobj(gcf,'tag','edit5');
tagve7=findobj(gcf,'tag','edit6');
tagvcheck1=findobj(gcf,'tag','checkbox2');
tagvcheck2=findobj(gcf,'tag','checkbox4');
tagtxt=findobj(gcf,'tag','text16');
if strcmp(tagv1.Enable,'off')==0 || strcmp(tagv2.Enable,'off')==0 || strcmp(tagv3.Enable,'off')==0
    tagtxt.String ='Вы выбрали не все параметры, параметр выбран, когда нажата кнопка "Применить"';
elseif strcmp(tagve4.String,'')==0 && strcmp(tagve5.String,'')==0 && strcmp(tagve6.String,'')==0 && strcmp(tagve7.String,'')==0 && tagvcheck1.Value==1
    tagtxt.String ='Вы выбрали произвольное построение препятствий. Теперь остается только нажать на кнопку "Найти путь"';
    tagvX=findobj(gcf,'tag','popupmenu2');
    Xmax=tagvX.Value+1;
    tagvY=findobj(gcf,'tag','popupmenu4');
    Ymax=tagvY.Value+1;
    make_grid();
    tagXmax=findobj(gcf,'tag','popupmenu2'); 
    tagYmax=findobj(gcf,'tag','popupmenu4');
    Xmax=tagXmax.Value+1;
    Ymax=tagYmax.Value+1;
    tagX1=findobj(gcf,'tag','edit3');
    X1=str2double(tagX1.String);
    tagY1=findobj(gcf,'tag','edit4');
    Y1=str2double(tagY1.String);
    tagX2=findobj(gcf,'tag','edit5');
    X2=str2double(tagX2.String);
    tagY2=findobj(gcf,'tag','edit6');
    Y2=str2double(tagY2.String);
    tagCheck=findobj(gcf,'tag','checkbox2'); 
    check=tagCheck.Value;
    tagknopka=findobj(gcf,'tag','pushbutton9');
    tagknopka.Enable='on';
    tagvstart.Enable='off';
    tagbut.Enable='on';
    make_graph(); 
    tagv3=findobj(gcf,'tag', 'pushbutton5'); 
    tagv3.Enable='off';
tagv7=findobj(gcf,'tag','pushbutton4');
tagv7.Enable='off';
tagv4=findobj(gcf,'tag','pushbutton7');
tagv4.Enable='off';
elseif strcmp(tagve4.String,'')==0 && strcmp(tagve5.String,'')==0 && strcmp(tagve6.String,'')==0 && strcmp(tagve7.String,'')==0 && tagvcheck2.Value==1
    tagtxt.String ='Перед тем как нажать на кнопку "Найти путь, выберете произвольные препятствия на карте, нажимая на нужную клеточку"';
    tagvX=findobj(gcf,'tag','popupmenu2');
    Xmax=tagvX.Value+1;
    tagvY=findobj(gcf,'tag','popupmenu4');
    Ymax=tagvY.Value+1;
    make_grid();
    tagXmax=findobj(gcf,'tag','popupmenu2'); 
    tagYmax=findobj(gcf,'tag','popupmenu4');
    Xmax=tagXmax.Value+1;
    Ymax=tagYmax.Value+1;
    tagX1=findobj(gcf,'tag','edit3');
    X1=str2double(tagX1.String);
    tagY1=findobj(gcf,'tag','edit4');
    Y1=str2double(tagY1.String);
    tagX2=findobj(gcf,'tag','edit5');
    X2=str2double(tagX2.String);
    tagY2=findobj(gcf,'tag','edit6');
    Y2=str2double(tagY2.String);
    tagCheck=findobj(gcf,'tag','checkbox2'); 
    check=tagCheck.Value;
    tagknopka=findobj(gcf,'tag','pushbutton9');
    tagknopka.Enable='on';
    tagbut.Enable='on';
    make_graph(); 
    tagv3=findobj(gcf,'tag', 'pushbutton5'); 
    tagv3.Enable='off';
tagv7=findobj(gcf,'tag','pushbutton4');
tagv7.Enable='off';
tagv4=findobj(gcf,'tag','pushbutton7');
tagv4.Enable='off';
tagvstart.Enable='off';
end
%Функция, которая работает при нажатии кнопки "Очистить карту", очищает
%карту
function pushbutton9_Callback(hObject, eventdata, handles)
cla 
tagvX=findobj(gcf,'tag','popupmenu2');
    Xmax=tagvX.Value+1;
    tagvY=findobj(gcf,'tag','popupmenu4');
    Ymax=tagvY.Value+1;
    make_grid();
    tagknopka=findobj(gcf,'tag','pushbutton9');
    tagknopka.Enable='off';
tag=findobj(gcf,'tag','pushbutton8');
tag.Enable='on';
tag=findobj(gcf,'tag','pushbutton10');
tag.Enable='off';
    tagv3=findobj(gcf,'tag', 'pushbutton5'); 
    tagv3.Enable='on';
tagv7=findobj(gcf,'tag','pushbutton4');
tagv7.Enable='on';
tagv4=findobj(gcf,'tag','pushbutton7');
tagv4.Enable='on';
tag=findobj(gcf,'tag','text16');
tag.String = 'Вы можете поменять значения или заново построить карту';

%Функция, которая работает при нажатии кнопки "Найти путь", создает волну и определяет кратчайшее расстояние     
function pushbutton10_Callback(hObject, eventdata, handles)
tag11=findobj(gcf,'tag','pushbutton8'); 
tag11.Enable='off'; 
tagvX=findobj(gcf,'tag','popupmenu2');
Xmax=tagvX.Value+1;
tagvY=findobj(gcf,'tag','popupmenu4');
Ymax=tagvY.Value+1;
tagX1=findobj(gcf,'tag','edit3');
X1=str2double(tagX1.String);
tagY1=findobj(gcf,'tag','edit4');
Y1=str2double(tagY1.String);
tagX2=findobj(gcf,'tag','edit5');
X2=str2double(tagX2.String);
tagY2=findobj(gcf,'tag','edit6');
Y2=str2double(tagY2.String);
v=read_file();
number_start=Xmax*Y1+X1+1;
number_finish=Xmax*Y2+X2+1;
tagv4=findobj(gcf,'tag','pushbutton9');
tagv4.Enable='off';
 make_trajectory(v,number_start,number_finish);
 tagv4.Enable='on';
 
function pushbutton11_Callback(hObject, eventdata, handles)
clear_space();

function axes2_CreateFcn(hObject, eventdata, handles)
Ymax= 15; % По оси y
Xmax = 15; %По оси x
make_grid();
%Функция, которая работает при нажатии на оси
function axes2_ButtonDownFcn(hObject, eventdata, handles)
manual_obstacle();


function popupmenu2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit3_KeyPressFcn(hObject, eventdata, handles)
