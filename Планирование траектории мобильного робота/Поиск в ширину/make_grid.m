function make_grid()
%Функция создает дискретное рабочее поле размерностью, заданной пользователем
tagXmax=findobj(gcf,'tag','popupmenu2'); 
    tagYmax=findobj(gcf,'tag','popupmenu4');
    Xmax=tagXmax.Value+1;
    Ymax=tagYmax.Value+1;
cla
axis equal;
axis([-1,Xmax+0.5,-1,Ymax+0.5]);
hold on;
for i = 1:Ymax+1.5
   line([-0.5,Xmax-0.5],[i-1.5,i-1.5]); 
end

for j = 1:Xmax+1.5
   line([j-1.5,j-1.5],[-0.5,Ymax-0.5]);
end
sizeX=zeros(1,Xmax);
sizeY=zeros(1,Ymax);
for i=1:Xmax
    sizeX(i)=i-1;
end
for i=1:Ymax
    sizeY(i)=i-1;
end
for i=1:Xmax
    sizeX(i)=i-1;
end
for i=1:Ymax
    sizeY(i)=i-1;
end
set(gca, 'XTick', sizeX);
set(gca, 'YTick', sizeY);
hold off
set(gca, 'XTick', sizeX);
set(gca, 'YTick', sizeY);
hold off