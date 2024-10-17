function make_trajectory(v,number_start,number_finish)
%�������, � ������� ���������� �������� �������� � �������� ���������� ��������� ����� ��������� 
q=CQueue();
tagb1=findobj(gcf,'tag','pushbutton10');
tagb2=findobj(gcf,'tag','pushbutton11');
tagvX=findobj(gcf,'tag','popupmenu2');
Xmax=tagvX.Value+1;
tagvY=findobj(gcf,'tag','popupmenu4');
Ymax=tagvY.Value+1;
tagb2.Enable='on';
tagtxt=findobj(gcf,'tag','text16');
q.push(number_start);
hold on
tagb1.Enable='off';
%������� �����, ������� ������� �����������
while q.size~=0 && v(number_finish).obstacle==0
    temp=(q.pop());
    for i=1:length(v(temp).sm)
%         number_sm - ��� ����� �������, ������� ������� � ��������,
%         �������� �� �������
        number_sm=v(temp).sm(i);
        if v(number_sm).obstacle==0
           q.push(number_sm);
           v(number_sm).d=v(temp).d+1;
           v(number_sm).obstacle=1;
           v(number_sm).parent = temp;
           pause(0.1);
           if(number_sm~=number_finish)
           plot(v(number_sm).coordinate(1),v(number_sm).coordinate(2),'sr','MarkerFaceColor','r');
           end
        end
    end
end
N=Xmax*Ymax;
%������� ����� � ���������� � ���� ����� ��������� ����� ����������� �����
for i=1:N
    %������ ��� ������ �������
    if v(i).coordinate(1)+1<=Xmax-1
        v(i).sm(1)=i+1;
    else v(i).sm(1)=0;
    end
    %������ ��� ����� �������
    if v(i).coordinate(1)-1>=0
        v(i).sm(2)=i-1;
    else v(i).sm(2)=0;
    end
    %C����� ��� ������� �������
    if v(i).coordinate(2)+1<=Ymax-1
        v(i).sm(3)=i+Xmax;
    else v(i).sm(3)=0;
    end
     %C����� ��� ������ �������
    if v(i).coordinate(2)-1>=0
        v(i).sm(4)=i-Xmax;
    else v(i).sm(4)=0;
    end
end
open_file(v,N);
make_grid();
%����� ����������� ���� �� ���������� �� ��������� �������
make_short();
m=v(number_finish).parent;
if(m==0)
    tagtxt.String ='����� �� ���� ����� ���� �� ������ �����, ��������� ��� ���� ���������';
else
par=zeros(1,v(number_finish).d);
for i=v(number_finish).d:-1:1
   par(i) = m;
   m=v(m).parent;
end
par(v(number_finish).d+1)=number_finish;
for i=2:v(number_finish).d+1
   pause(0.3);
   if(par(i)~=number_finish)
   plot(v(par(i)).coordinate(1),v(par(i)).coordinate(2),'sr','MarkerFaceColor','r');
   else 
       plot(v(par(i)).coordinate(1),v(par(i)).coordinate(2),'sg','MarkerFaceColor','g');
   end
end
for i=1:length(par)
coordinate_table(i,1) = v(par(i)).coordinate(1);
coordinate_table(i,2) =  v(par(i)).coordinate(2);
end
t=findobj(gcf,'tag','uitable2');
set(t,'Data',coordinate_table);
tagtxt.String ='����� ������� ����� ���������� ���� �� ������ �����';
end
hold off