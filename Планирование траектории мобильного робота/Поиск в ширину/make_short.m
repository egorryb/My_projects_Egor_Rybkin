function make_short()
%Создает отдельную траекторию, которая является кратчайшей, и удаляет
%волну, созданную при поиске кратчайшего пути
hold on
tagvX=findobj(gcf,'tag','popupmenu2');
Xmax=tagvX.Value+1;
tagvY=findobj(gcf,'tag','popupmenu4');
Ymax=tagvY.Value+1;
N=Xmax*Ymax;
v=read_file();
tagX1=findobj(gcf,'tag','edit3');
 X1=str2double(tagX1.String);
    tagY1=findobj(gcf,'tag','edit4');
    Y1=str2double(tagY1.String);
    tagX2=findobj(gcf,'tag','edit5');
    X2=str2double(tagX2.String);
    tagY2=findobj(gcf,'tag','edit6');
    Y2=str2double(tagY2.String);
    start=Xmax*Y1+X1+1;
    finish=Xmax*Y2+X2+1;
 plot(v(start).coordinate(1),v(start).coordinate(2),'sg','MarkerFaceColor','g');
 plot(v(finish).coordinate(1),v(finish).coordinate(2),'sm','MarkerFaceColor','m');
for i=1:N
    if v(i).obstacle==-1
     plot(v(i).coordinate(1),v(i).coordinate(2),'sk','MarkerFaceColor','k');
    end
end
