function clear_space()
%������� ������� ��� ���� ���������� � ������, ��������� � �� � ����������
%���������
tagtxt=findobj(gcf,'tag','text16');
tagbutton10=findobj(gcf,'tag','pushbutton10');
tagvX=findobj(gcf,'tag','popupmenu2');
tagvX.Value=14;
tagvX.Enable='on';
tagvY=findobj(gcf,'tag','popupmenu4');
tagvY.Value=14;
tagvY.Enable='on';
tagX1=findobj(gcf,'tag','edit3');
tagX1.String='';
tagX1.Enable='on';
tagY1=findobj(gcf,'tag','edit4');
tagY1.String='';
tagY1.Enable='on';
tagX2=findobj(gcf,'tag','edit5');
tagX2.String='';
tagX2.Enable='on';
tagY2=findobj(gcf,'tag','edit6');
tagY2.String='';
tagY2.Enable='on';
tag2=findobj(gcf,'tag','pushbutton2'); 
tag2.Enable='on';
tag3=findobj(gcf,'tag','pushbutton3'); 
tag3.Enable='on';
tag6=findobj(gcf,'tag','pushbutton6'); 
tag6.Enable='on';
tag8=findobj(gcf,'tag','pushbutton8'); 
tag8.Enable='on';
tag5=findobj(gcf,'tag','pushbutton5'); 
tag5.Enable='off';
tag4=findobj(gcf,'tag','pushbutton4'); 
tag4.Enable='off';
tag7=findobj(gcf,'tag','pushbutton7'); 
tag7.Enable='off';
tag9=findobj(gcf,'tag','pushbutton9'); 
tag9.Enable='off';
tagv1=findobj(gcf,'tag','checkbox2'); 
tagv2=findobj(gcf,'tag','checkbox4'); 
tagv1.Enable='on';
tagv2.Enable='on';
tag6=findobj(gcf,'tag','pushbutton6'); 
tag6.Enable='on';
tag11=findobj(gcf,'tag','pushbutton11'); 
tag11.Enable='off';
tagbutton10.Enable = 'off';
t=findobj(gcf,'tag','uitable2');
set(t,'Data',[]);
tagtxt.String ='�������� ��������� ��� ���������� �����';
make_grid();