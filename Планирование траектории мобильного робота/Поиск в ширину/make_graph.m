function make_graph()
%Функция в зависимости от того, каким образом выбрано построение
%препятствий задает граф в виде структуры, строит начальные и конечные
%точки на ДРП и заносит значения стркутуры в файл
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
    tagCheck1=findobj(gcf,'tag','checkbox2'); 
    check1=tagCheck1.Value;
    tagCheck2=findobj(gcf,'tag','checkbox4'); 
    check2=tagCheck2.Value;
    tagknopka=findobj(gcf,'tag','pushbutton9');
    tagknopka.Enable='on';
N=Xmax*Ymax;
s=1;
v.d=0;
v.obstacle=0;
v.parent=0;
v.sm=0;
hold on
%определяем начальную вершину
start=Xmax*Y1+X1+1;
%Определяем конечную вершину
finish=Xmax*Y2+X2+1;
%Определяем координаты каждой вершины и ее характер: начальная вершина,
%препятствие или обычная вершина
for i=1:Ymax
    for j=1:Xmax
        RND = rand();
        v(s).coordinate=[j-1,i-1];
        v(s).d=0;
        v(s).parent=0; 
        if(s==start)
        v(s).obstacle=1;
        elseif(s==finish)
          v(s).obstacle=0;
        elseif check2==1
          v(s).obstacle=0;
        elseif check1 == 1
            if(RND<0.7)
        v(s).obstacle=0;
            else
            v(s).obstacle=-1;
            plot(v(s).coordinate(1),v(s).coordinate(2),'sk','MarkerFaceColor','k');
            end
        end
         s=s+1;
    end
end
%Создаем матрицу смежности для каждой вершины
for i=1:s-1
    %Случай для правой вершины
    if v(i).coordinate(1)+1<=Xmax-1
        v(i).sm(1)=i+1;
    else v(i).sm(1)=0;
    end
    
    %Случай для левой вершины
    if v(i).coordinate(1)-1>=0
        v(i).sm(2)=i-1;
    else v(i).sm(2)=0;
    end
    %Cлусай для верхней вершины
    if v(i).coordinate(2)+1<=Ymax-1
        v(i).sm(3)=i+Xmax;
    else v(i).sm(3)=0;
    end
     %Cлучай для нижней вершины
    if v(i).coordinate(2)-1>=0
        v(i).sm(4)=i-Xmax;
    else v(i).sm(4)=0;
    end
end 
%строим на графике начальные и конечные значения, а также препятствия
plot(v(start).coordinate(1),v(start).coordinate(2),'sg','MarkerFaceColor','g');
v(start).obastacle = 1;
plot(v(finish).coordinate(1),v(finish).coordinate(2),'sm','MarkerFaceColor','m');
hold off
open_file(v,N);
read_file();

