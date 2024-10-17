%% А стар для поиска
function Theta = AstarAlgorithm3(xStart, yStart, xTarget, yTarget, MAP,MIN_X,MIN_Y,MAX_X,MAX_Y,x0,y0,r,L1,L2,num)
title('Пространство конфигураций RR робота')
Alg = 1;
OPEN=[];
CLOSED=[];
k=1; % Счетчик для преград в закрытом списке
MAPsize = size(MAP);
for i=1:MAPsize(:,1)
    for j=1:MAPsize(:,2)
        if(MAP(i,j) == -1)
            CLOSED(k,1)=i - abs(MIN_X);
            CLOSED(k,2)=j - abs(MIN_X);
            k=k+1;
        end
    end
end
CLOSED_COUNT=size(CLOSED,1);
%% Помещаем первую ноду (точку начала поиска) в открытый список
xNode=xStart;
yNode=yStart;
%%
OPEN_COUNT = 1;
past_cost = [];
past_cost(1)=0;
past_cost(2)=Inf;
OPEN(OPEN_COUNT,:) = [xNode, yNode, past_cost(1)];
parent = [];
nbr_num = 2;
g = 1;
parent(g,:) = [-1 -1 -1 -1];
current_num = 1;
s = 0;
v = 1;
%%
while ~isempty(OPEN)
    if s == 1
        break;
    end
    if OPEN_COUNT > 1
        OPEN_COUNT = OPEN_COUNT - 1;
    end
    current = OPEN(1,:);
    OPEN(1,:) = [];
    CLOSED_COUNT = CLOSED_COUNT + 1;
    CLOSED(CLOSED_COUNT,:) = [current(1) current(2)];
    [ArrayOfNbr, NeProhod]= (nbr_of_current3(current(1:2),CLOSED,MIN_X,MIN_Y,MAX_X,MAX_Y,Alg,v,L1,L2,x0,y0,r,num));
    ArrayOfNbr = round(ArrayOfNbr);
    NeProhod = round(NeProhod);
    if ~isempty(ArrayOfNbr)
        for i = 1:length(ArrayOfNbr(:,1))
            tentative_past_cost = (past_cost(current_num) + ...
                cost(current(1,1),ArrayOfNbr(i,1),current(1,2),ArrayOfNbr(i,2)));
            if tentative_past_cost < past_cost(nbr_num)
                past_cost(nbr_num + 1) = Inf;
                past_cost(nbr_num)= tentative_past_cost;
                parent(g,:) = [ArrayOfNbr(i,(1:2)) current(1:2)];
                plot(parent(g,1), parent(g,2), 'ob','MarkerSize',1)
                pause(0.0001)
                if parent(g,1) == xTarget && parent(g,2) == yTarget
                    s = 1;
                    break;
                end
                est_total_cost = round(past_cost(nbr_num) + ...
                    cost(ArrayOfNbr(i,1),xTarget,ArrayOfNbr(i,2),yTarget));
                OPEN(OPEN_COUNT,:) = [ArrayOfNbr(i,(1:2)) est_total_cost];
                OPEN_COUNT = OPEN_COUNT + 1;
                OPEN = sortrows(OPEN,3);
            end
            nbr_num = nbr_num + 1;
            g = g + 1;
        end
        current_num =current_num + 1;
    end
end
%% Вывод оптимального пути или сообщения о том что решения нет
z = 1;
if g <= length(parent(:,1))
    if parent(g,1) == xTarget && parent(g,2) == yTarget
        L = length(parent(:,1));
        X = parent(L,1); Y = parent(L,2);
        Xparent = parent(L,3); Yparent = parent(L,4);
        while L  >= 1
            if Xparent == parent(L,1) && Yparent == parent(L,2)
                Theta(z,:) = [X, Y];
                z = z + 1;
                X = Xparent;
                Y = Yparent;
                Xparent = parent(L,3);
                Yparent = parent(L,4);
            end
            step = plot(X , Y  , 'g','markersize',1);
            L = L - 1;
        end
        plot(xStart , yStart , 'g','markersize',1)
    end
else
    disp('Решения нет')
end