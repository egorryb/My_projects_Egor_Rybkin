close all; clear; clc;
Ymax= 8; % По оси y
Xmax = 8; %По оси x
axis equal;
axis([-1,Xmax+0.5,-1,Ymax+0.5]);
% 
 % Сетка
 hold on;
for i = 1:Ymax+1.5
   line([-0.5,Xmax-0.5],[i-1.5,i-1.5]); 
end

for j = 1:Xmax+1.5
   line([j-1.5,j-1.5],[-0.5,Ymax-0.5]);
end

%матрицу значений вершин
N=Xmax*Ymax;
s=1;
% объявление матрицы вершин

% Определим структуру каждой вершины, которая содержит информацию о ней
v.coordinate = [0,0]; %координаты текущей вершины
v.parent = 0; %вершина, которая является предшествующей для текущей
v.Gcost = 0; %стоимость перехода на данную вершину от начальной
v.Hcost = 0; %эмпирическая стоимость перехода на данную вершину
v.Fcost = 0; %общая стоимость перехода на данную вершину и равняется Gcost + Hcost
v.obstacle = 0; %определяет, является ли вершина препятствием
v.neighbors = []; %определяет, какие вершины связаны с текущей
%определяем начальную вершину
start_point=1;
%Определяем конечную вершину
target_point=60;
%Определяем параметры нашего графа
for i=1:Ymax
    for j=1:Xmax
        v(s).coordinate=[j-1,i-1];
        v(s).parent=0;
        %Определим всех соседей
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
      % последние четыре if определяют номера вершин соседей на диагонали
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
%Определение препятствий

mode = 1; %mode 1 = случайным образом, mode 2 - вручную
n_obstacle = 15; %Количество препятствий, выбираемые вручную
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
            v(s).obstacle = 0; %изначально нет препятствий до выбора препятствий
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
%Задаем параметры стоимости пути для начальной вершины
v(start_point).Gcost = 0;
v(start_point).Hcost = abs(v(start_point).coordinate(1)-v(target_point).coordinate(1))+ ...
    abs(v(start_point).coordinate(2)-v(target_point).coordinate(2));
v(start_point).Fcost = v(start_point).Gcost + v(start_point).Hcost;
%Заносим начальную вершину в открытый список
open_list = [v(start_point).Fcost,start_point]; % в открытый список заносим расстояние от начальной вершины до конечной вершины 
                                            % и номер начальной вершины
close_list = []; % список для вершин, которые полностью рассмотрены

%Основной цикл работы
while (~isempty(open_list) && ~(open_list(1,2)==target_point))
    indicator = 0; %индикатор для отсечения вершин на диагонали, к которым нельзя добраться
     v_open = open_list(1,2); %записываем номер текущей вершины
     open_list(1,:) = []; %удаляем информацию о текущей вершине из открытого списка
     close_list(length(close_list)+1) = v_open; % заносим текущую вершину в закрытый список
     %Определим для текущей вершины всех соседей (из условия, что наш граф явялется сеткой, расстояние между вершинами
     % вдоль прямой равно 1, а расстояние по диагонали корень из двух
     % первые четыре if определяют номера вершин соседей на расстоянии едицины
     if v_open == target_point
         disp('Начальная и конечная вершины совпадают');
        break;
     end
     %Начинаем обработку соседних вершин
     for i=1:length(v(v_open).neighbors)
         v_neighbor = v(v_open).neighbors(i); %v_neighbor равняется номеру вершины 
            %если соседняя вершина - препятствие, или она в закрытом списке, мы пропускаем ее
         if (v(v_neighbor).obstacle == 1)  || (~isempty(find(close_list == v_neighbor,1)))
            continue; 
         end
         
         %Определяем условие на срезку углов (ограничение на движение по диагонали через препятствие)
         %Если у двух вершин нет равных координат (x или y), то есть соседние
         %вершины расположены диагонально, тогда находим общих соседей между ними и проверяюем, являются ли эти общие соседи препятствиями
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
         % Если в цикле поиска найдено ограничение на диагональное перемещение, я перехожу к следующему соседу
         if indicator == 1
             continue;
         end

         %если этой вершины нет в открытом списке
         if isempty(find(open_list(:,2)==v_neighbor,1)) 
             v(v_neighbor).parent = v_open; % для соседней вершины определяем вершину,
                                           % взятую из открытого списка, как предшествующую
             if (v(v_open).coordinate(1)==v(v_neighbor).coordinate(1)) || ... 
                (v(v_open).coordinate(2) == v(v_neighbor).coordinate(2)) % в этом if мы задаем фактическое расстояние от вершины 
                                                                        % из открытого списка до исследуемой вершины
                 v(v_neighbor).Gcost = v(v_open).Gcost+1; %если клетка находятся на расстоянии единицы
             else
                 v(v_neighbor).Gcost = v(v_open).Gcost + sqrt(2); % если клекти расположены диагонально
             end 
             v(v_neighbor).Hcost = abs(v(v_neighbor).coordinate(1)-v(target_point).coordinate(1))+ ...
                                  abs(v(v_neighbor).coordinate(2)-v(target_point).coordinate(2)); % эмпирическая стоимость
             v(v_neighbor).Fcost = v(v_neighbor).Gcost+v(v_neighbor).Hcost; % общая стоимость соседней вершины
             open_list(length(open_list(:,1))+1,:) = [v(v_neighbor).Fcost,v_neighbor]; %заносим сведения о вершине в открытый список
         end
         
          %если эта вершина есть в открытом списке
         if isempty(~find(open_list(:,2)==v_neighbor,1))
             % определяем расстояние между вершиной из открытого списка и соседней вершиной
             if (v(v_open).coordinate(1)==v(v_neighbor).coordinate(1)) || ... 
                (v(v_open).coordinate(2) == v(v_neighbor).coordinate(2)) 
                 Gnew = 1; %если клетка находятся на расстоянии единицы
             else
                 Gnew = sqrt(2); 
             end 
             % Если расстояние до соседней вершины через вершину из открытого списка меньше,
             % чем текущее расстояние соседней вершины, мы записываем новое расстояние для соседней вершины
             if v(v_open).Gcost + Gnew < v(v_neighbor).Gcost 
                v(v_neighbor).Gcost = v(v_open).Gcost + Gnew;
                v(v_neighbor).Fcost = v(v_neighbor).Gcost+v(v_neighbor).Hcost;
                row = find((open_list(:,2)==v_neighbor),1); % номер строки, содерржащей в открытом списке эту вершину 
                open_list(row,1) = v(v_neighbor).Fcost; %заменяем в открытом списке расстояние этой вершины на новое
             else 
                 continue; %ничего не меняем, пропускаем итерацию
             end 
         end
     end
     open_list = sortrows (open_list); %сортируем октрытый список по первому столбцу, в котором записаны расстояния до конечной вершины
                                               % чтобы в первой строке открытого списка была вершина с наименьшим расстоянием                                          
     pause(0.2);
     if isempty(open_list)
         disp('Нет пути');
         break
     elseif (open_list(1,2)~=target_point)
        plot(v(open_list(1,2)).coordinate(1),v(open_list(1,2)).coordinate(2),'sb','MarkerFaceColor','b');
     elseif open_list(1,2)==target_point
         disp('Путь найден');
         p = target_point;
         trajectory(1)=p;
         while (p~=start_point)
            trajectory(length(trajectory)+1)=v(p).parent;
            p = v(p).parent;
         end
        %конечная траектория в номерах вершин
        disp('Путь, проейденный по номерам вершин');
        trajectory = fliplr(trajectory);
        disp(trajectory);
        for i=1:length(fliplr(trajectory))
            plot(v(trajectory(i)).coordinate(1),v(trajectory(i)).coordinate(2),'sm','MarkerFaceColor','m');
            pause(0.4);
        end
        disp('Длина пути');
        disp(v(target_point).Gcost);
     break;
     end
end