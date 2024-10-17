function v=read_file()
%Функция, которая считывает значения из файла, преобрзая их в структуру,
%которая определяет граф
tagvX=findobj(gcf,'tag','popupmenu2');
    Xmax=tagvX.Value+1;
    tagvY=findobj(gcf,'tag','popupmenu4');
    Ymax=tagvY.Value+1;
k=fopen('Graphs.txt','rt');
FILE='Graphs.txt';
M=dlmread(FILE,'',1,0 );
fclose(k);
N=Xmax*Ymax;
for i=1:N
 p=1;
v(i).d=M(i,2);
v(i).parent=M(i,3);
v(i).obstacle=M(i,4);
if M(i,5)~=0
v(i).sm(p)=M(i,5);
p=p+1;
end
if M(i,6)~=0
v(i).sm(p)=M(i,6);
p=p+1;
end
if M(i,7)~=0
v(i).sm(p)=M(i,7);
p=p+1;
end
if M(i,8)~=0
v(i).sm(p)=M(i,8);
p=p+1;
end
v(i).coordinate(1)=M(i,9);
v(i).coordinate(2)=M(i,10);
end



