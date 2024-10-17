function manual_obstacle 
%‘ункци€, срабатывающа€ при режими самосто€тельного выбора траектории:
%позвол€ет на графике задавать кликом мыши преп€тстви€, значение которых
%занос€тс€ в структуру графа
tag11=findobj(gcf,'tag','pushbutton8'); 
tagbutton1=findobj(gcf,'tag','pushbutton2');
tagbutton2=findobj(gcf,'tag','pushbutton3');
tagbutton3=findobj(gcf,'tag','pushbutton6');
tagX1=findobj(gcf,'tag','edit3');
 X1=str2double(tagX1.String);
    tagY1=findobj(gcf,'tag','edit4');
    Y1=str2double(tagY1.String);
    tagX2=findobj(gcf,'tag','edit5');
    X2=str2double(tagX2.String);
    tagY2=findobj(gcf,'tag','edit6');
    Y2=str2double(tagY2.String);
    tagCheck1=findobj(gcf,'tag','checkbox2'); 
    check1=tagCheck1.Value;
tagvcheck=findobj(gcf,'tag','checkbox4');
tagbutton = findobj(gcf,'tag','pushbutton8');
tagvX=findobj(gcf,'tag','popupmenu2');
Xmax=tagvX.Value+1;
tagvY=findobj(gcf,'tag','popupmenu4');
Ymax=tagvY.Value+1;
%определ€ем начальную вершину
start=Xmax*Y1+X1+1;
%ќпредел€ем конечную вершину
finish=Xmax*Y2+X2+1;
if( tagvcheck.Value==1 && strcmp(tag11.Enable,'off')==1)
[x,y] = ginput(1);
x=round(x);
y=round(y);
hold on
%“екущий номер вершины
n=Xmax*y+x+1;
%≈сли при нажатии мы выходим за рамки пол€, то значение не будет
%отображатьс€ на графике и в структуре
if(x>-0.5 && x < Xmax+1.5 && y>-0.5 && y<Ymax+1.5 && n~=finish && n~=start)
    plot(x,y,'sk','MarkerFaceColor','k');
k=fopen('Graphs.txt','rt');
FILE='Graphs.txt';
M=dlmread(FILE,'',1,0 );
N=length(M);
fclose(k);
% ѕосле того, как произведено нажатие на поле, эти значени€ записываютс€ в
% файл 
for i=1:N
v(i).d=M(i,2);
v(i).parent=M(i,3);
v(i).obstacle=M(i,4);
v(i).sm(1)=M(i,5);
v(i).sm(2)=M(i,6);
v(i).sm(3)=M(i,7);
v(i).sm(4)=M(i,8);
v(i).coordinate(1)=M(i,9);
v(i).coordinate(2)=M(i,10);
end
v(n).obstacle=-1;
open_file(v,N);
end
end
hold off
