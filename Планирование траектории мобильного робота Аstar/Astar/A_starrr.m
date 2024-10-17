close all; clear; clc;
Ymax= 8; % �� ��� y
Xmax = 8; %�� ��� x
axis equal;
axis([-1,Xmax+0.5,-1,Ymax+0.5]);
% 
 % �����
 hold on;
for i = 1:Ymax+1.5
   line([-0.5,Xmax-0.5],[i-1.5,i-1.5]); 
end

for j = 1:Xmax+1.5
   line([j-1.5,j-1.5],[-0.5,Ymax-0.5]);
end

%������� �������� ������
N=Xmax*Ymax;
s=1;
% ���������� ������� ������

% ��������� ��������� ������ �������, ������� �������� ���������� � ���
v.coordinate = [0,0]; %���������� ������� �������
v.parent = 0; %�������, ������� �������� �������������� ��� �������
v.Gcost = 0; %��������� �������� �� ������ ������� �� ���������
v.Hcost = 0; %������������ ��������� �������� �� ������ �������
v.Fcost = 0; %����� ��������� �������� �� ������ ������� � ��������� Gcost + Hcost
v.obstacle = 0; %����������, �������� �� ������� ������������
v.neighbors = []; %����������, ����� ������� ������� � �������
%���������� ��������� �������
start_point=1;
%���������� �������� �������
target_point=60;
%���������� ��������� ������ �����
for i=1:Ymax
    for j=1:Xmax
        v(s).coordinate=[j-1,i-1];
        v(s).parent=0;
        %��������� ���� �������
        if v(s).coordinate(1)+1 <=Xmax-1
             v(s).neighbors(length(v(s).neighbors)+1) = s+1;
     end
     if v(s).coordinate(1)-1 >= 0
             v(s).neighbors(length(v(s).neighbors)+1) = s-1;
     end
     if v(s).coordinate(2)+1 <=Ymax-1
             v(s).neighbors(length(v(s).neighbors)+1) = s+Xmax;
     end
     if v(s).coordinate(2)-1 >= 0
            v(s).neighbors(length(v(s).neighbors)+1) = s-Xmax;
     end
      % ��������� ������ if ���������� ������ ������ ������� �� ���������
     if (v(s).coordinate(1)<Xmax-1) && (v(s).coordinate(2) < Ymax-1)
            v(s).neighbors(length(v(s).neighbors)+1) = s+Xmax+1;
     end
     if (v(s).coordinate(1)>0) && (v(s).coordinate(2) < Ymax-1)
            v(s).neighbors(length(v(s).neighbors)+1) = s+Xmax-1;
     end
     if (v(s).coordinate(1)>0) && (v(s).coordinate(2) > 0)
            v(s).neighbors(length(v(s).neighbors)+1) = s-Xmax-1;
     end
     if (v(s).coordinate(1)<Xmax-1) && (v(s).coordinate(2) > 0)
            v(s).neighbors(length(v(s).neighbors)+1) = s-Xmax+1;
     end
         s=s+1;
    end
end
%����������� �����������

mode = 1; %mode 1 = ��������� �������, mode 2 - �������
n_obstacle = 15; %���������� �����������, ���������� �������
plot(v(start_point).coordinate(1),v(start_point).coordinate(2),'sg','MarkerFaceColor','g');
plot(v(target_point).coordinate(1),v(target_point).coordinate(2),'sr','MarkerFaceColor','r');
if mode==1
    s=1;
    for i=1:Ymax
        for j=1:Xmax
            RND = random('normal', 1.5, 1);
                if(RND<1 && s~=start_point && s~=target_point)
                    v(s).obstacle = 1;
                    plot(v(s).coordinate(1),v(s).coordinate(2),'sk','MarkerFaceColor','k');
                else 
                    v(s).obstacle =0;
                end
                s=s+1;
        end
    end
elseif mode == 2
    s=1;
    for i=1:Ymax
        for j=1:Xmax
            v(s).obstacle = 0; %���������� ��� ����������� �� ������ �����������
            s=s+1;
        end
    end
    for i=1:n_obstacle
        [x,y] = ginput(1);
        x=round(x);
        y=round(y);
        hold on
        n=Xmax*y+x+1;
        if(x>-0.5 && x < Xmax+1.5 && y>-0.5 && y<Ymax+1.5 && n~=target_point && n~=start_point)
            plot(x,y,'sk','MarkerFaceColor','k');
            v(n).obstacle = 1;
        end
    end
end
pause(3);
%������ ��������� ��������� ���� ��� ��������� �������
v(start_point).Gcost = 0;
v(start_point).Hcost = abs(v(start_point).coordinate(1)-v(target_point).coordinate(1))+ ...
    abs(v(start_point).coordinate(2)-v(target_point).coordinate(2));
v(start_point).Fcost = v(start_point).Gcost + v(start_point).Hcost;
%������� ��������� ������� � �������� ������
open_list = [v(start_point).Fcost,start_point]; % � �������� ������ ������� ���������� �� ��������� ������� �� �������� ������� 
                                            % � ����� ��������� �������
close_list = []; % ������ ��� ������, ������� ��������� �����������

%�������� ���� ������
while (~isempty(open_list) && ~(open_list(1,2)==target_point))
    indicator = 0; %��������� ��� ��������� ������ �� ���������, � ������� ������ ���������
     v_open = open_list(1,2); %���������� ����� ������� �������
     open_list(1,:) = []; %������� ���������� � ������� ������� �� ��������� ������
     close_list(length(close_list)+1) = v_open; % ������� ������� ������� � �������� ������
     %��������� ��� ������� ������� ���� ������� (�� �������, ��� ��� ���� �������� ������, ���������� ����� ���������
     % ����� ������ ����� 1, � ���������� �� ��������� ������ �� ����
     % ������ ������ if ���������� ������ ������ ������� �� ���������� �������
     if v_open == target_point
         disp('��������� � �������� ������� ���������');
        break;
     end
     %�������� ��������� �������� ������
     for i=1:length(v(v_open).neighbors)
         v_neighbor = v(v_open).neighbors(i); %v_neighbor ��������� ������ ������� 
            %���� �������� ������� - �����������, ��� ��� � �������� ������, �� ���������� ��
         if (v(v_neighbor).obstacle == 1)  || (~isempty(find(close_list == v_neighbor,1)))
            continue; 
         end
         
         %���������� ������� �� ������ ����� (����������� �� �������� �� ��������� ����� �����������)
         %���� � ���� ������ ��� ������ ��������� (x ��� y), �� ���� ��������
         %������� ����������� �����������, ����� ������� ����� ������� ����� ���� � ����������, �������� �� ��� ����� ������ �������������
         if ~((v(v_open).coordinate(1) == v(v_neighbor).coordinate(1)) || (v(v_open).coordinate(2) == v(v_neighbor).coordinate(2)))
             for i=1:length(v(v_neighbor).neighbors)
                 if isempty(find(v(v_open).neighbors==v(v_neighbor).neighbors(i),1))
                    continue;
                 else 
                     number = v(v_open).neighbors(find(v(v_open).neighbors==v(v_neighbor).neighbors(i),1)); 
                     if v(number).obstacle ==1
                         indicator = 1;
                         break;
                     else 
                         continue
                     end
                 end
             end
         end
         % ���� � ����� ������ ������� ����������� �� ������������ �����������, � �������� � ���������� ������
         if indicator == 1
             continue;
         end

         %���� ���� ������� ��� � �������� ������
         if isempty(find(open_list(:,2)==v_neighbor,1)) 
             v(v_neighbor).parent = v_open; % ��� �������� ������� ���������� �������,
                                           % ������ �� ��������� ������, ��� ��������������
             if (v(v_open).coordinate(1)==v(v_neighbor).coordinate(1)) || ... 
                (v(v_open).coordinate(2) == v(v_neighbor).coordinate(2)) % � ���� if �� ������ ����������� ���������� �� ������� 
                                                                        % �� ��������� ������ �� ����������� �������
                 v(v_neighbor).Gcost = v(v_open).Gcost+1; %���� ������ ��������� �� ���������� �������
             else
                 v(v_neighbor).Gcost = v(v_open).Gcost + sqrt(2); % ���� ������ ����������� �����������
             end 
             v(v_neighbor).Hcost = abs(v(v_neighbor).coordinate(1)-v(target_point).coordinate(1))+ ...
                                  abs(v(v_neighbor).coordinate(2)-v(target_point).coordinate(2)); % ������������ ���������
             v(v_neighbor).Fcost = v(v_neighbor).Gcost+v(v_neighbor).Hcost; % ����� ��������� �������� �������
             open_list(length(open_list(:,1))+1,:) = [v(v_neighbor).Fcost,v_neighbor]; %������� �������� � ������� � �������� ������
         end
         
          %���� ��� ������� ���� � �������� ������
         if isempty(~find(open_list(:,2)==v_neighbor,1))
             % ���������� ���������� ����� �������� �� ��������� ������ � �������� ��������
             if (v(v_open).coordinate(1)==v(v_neighbor).coordinate(1)) || ... 
                (v(v_open).coordinate(2) == v(v_neighbor).coordinate(2)) 
                 Gnew = 1; %���� ������ ��������� �� ���������� �������
             else
                 Gnew = sqrt(2); 
             end 
             % ���� ���������� �� �������� ������� ����� ������� �� ��������� ������ ������,
             % ��� ������� ���������� �������� �������, �� ���������� ����� ���������� ��� �������� �������
             if v(v_open).Gcost + Gnew < v(v_neighbor).Gcost 
                v(v_neighbor).Gcost = v(v_open).Gcost + Gnew;
                v(v_neighbor).Fcost = v(v_neighbor).Gcost+v(v_neighbor).Hcost;
                row = find((open_list(:,2)==v_neighbor),1); % ����� ������, ����������� � �������� ������ ��� ������� 
                open_list(row,1) = v(v_neighbor).Fcost; %�������� � �������� ������ ���������� ���� ������� �� �����
             else 
                 continue; %������ �� ������, ���������� ��������
             end 
         end
     end
     open_list = sortrows (open_list); %��������� �������� ������ �� ������� �������, � ������� �������� ���������� �� �������� �������
                                               % ����� � ������ ������ ��������� ������ ���� ������� � ���������� �����������                                          
     pause(0.2);
     if isempty(open_list)
         disp('��� ����');
         break
     elseif (open_list(1,2)~=target_point)
        plot(v(open_list(1,2)).coordinate(1),v(open_list(1,2)).coordinate(2),'sb','MarkerFaceColor','b');
     elseif open_list(1,2)==target_point
         disp('���� ������');
         p = target_point;
         trajectory(1)=p;
         while (p~=start_point)
            trajectory(length(trajectory)+1)=v(p).parent;
            p = v(p).parent;
         end
        %�������� ���������� � ������� ������
        disp('����, ����������� �� ������� ������');
        trajectory = fliplr(trajectory);
        disp(trajectory);
        for i=1:length(fliplr(trajectory))
            plot(v(trajectory(i)).coordinate(1),v(trajectory(i)).coordinate(2),'sm','MarkerFaceColor','m');
            pause(0.4);
        end
        disp('����� ����');
        disp(v(target_point).Gcost);
     break;
     end
end