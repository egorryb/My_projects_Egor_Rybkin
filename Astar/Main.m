clear; clc; close all;
%% Параметры манипуляторы
L1 = 1; L2 = 1; % Длины звеньев
theta1_min = -175; theta1_max = 175; % Ограничения по углам 1 сочленения
theta2_min = -175; theta2_max = 175; % Ограничения по углам 2 сочленения
%% Построение рабочего пространства робота
figure;
set(gcf,'Color','white');
set(gca,'FontName','Times New Roman');
set(gca,'FontSize',12)
set(gca, 'XTick',-3:0.5:2.5,'YTick',-3:0.5:2.5);
xlim([-3,3]);
ylim([-3,3]);
xlabel('X');
ylabel('Y');
title('Начальное положение робота');
hold on
grid on
make_workspace(0,0,1,1);
but = 0;
%% Построение начального положения робота
while (but == 0)
    [xval,yval,but]=ginput(1);
    xStart=xval;
    yStart=yval;
    if sqrt(xval^2 + yval^2) > L1 + L2 || sqrt(xval^2 + yval^2) < 0.087
        but = 0;
        disp('Нарушены условия')
    else
        [theta1_start, theta2_start] = ozk(xStart,yStart,L1,L2);
        if theta1_start < theta1_min || ...
                theta1_start > theta1_max || theta2_start < theta2_min || ...
                theta2_start > theta2_max
            but = 0;
            disp('Нарушены условия')
        end
    end
end
[x1,y1,x2,y2] = pzk(theta1_start,theta2_start,L1,L2);
plot ([0,x1],[0,y1],'linewidth',3,'color','b');
plot ([x1,x2],[y1,y2],'linewidth',3,'color','b');
%% Выбор конечного положения робота
title('Выберите конечное положение робота');
but=0;
while (but == 0)
    [xval,yval,but]=ginput(1);
    if sqrt(xval^2 + yval^2) > L1 + L2 || sqrt(xval^2 + yval^2) < 0.087
        but = 0;
        disp('Нарушены условия')
    end
end
xTarget=xval;
yTarget=yval;
[theta1_target, theta2_target] = ozk(xTarget,yTarget,L1,L2);
plot(xTarget,yTarget,"x",'color','green','markersize',10);
%% Выбор расположения препятствий и их размер
num = 1;
r = 0.2;
while but == 1
    title('Выберите центр препятствия');
    [xval,yval,but] = ginput(1);
    x0(num) = (xval); 
    y0(num) = (yval);
    num = num + 1;
    make_obstacle(xval,yval,r);
end
title('Результат поиска алгоритмом A*');
%% Определение непроходимых участков
Nbr_NeProhod = 1; 
for q1 = theta1_min-1:1:theta1_max
    for q2 = theta2_min-1:1:theta2_max
        [x1,y1,x2,y2] = pzk(q1 ,q2,L1,L2);
        for k = 1:num-1
            [Dm Dm1] = DistMin(x2,y2,x1, y1,x0,y0,k);
            if Dm  - r <= 0 || Dm1 - r <=0
                Obst(Nbr_NeProhod,1) = q1;
                Obst(Nbr_NeProhod,2) = q2;
                Nbr_NeProhod =  Nbr_NeProhod + 1;
            end
        end
    end
end
%% ПОИСК
[xStart, yStart, xTarget, yTarget, MAP,start,target,obst]=FieldQ(theta1_target,...
    theta2_target,theta1_start,theta2_start...
    ,Obst,theta1_min,...
    theta2_min,theta1_max,theta2_max);
Theta = (AstarAlgorithm3(xStart, yStart, xTarget, yTarget, MAP,...
    theta1_min,theta2_min,theta1_max,theta2_max,x0,y0,r,L1,L2,num));
%% Построение пути
figure(f1);
set(gcf,'Color','white');
set(gca,'FontName','Times New Roman');
set(gca,'FontSize',14)
set(gca, 'XTick',-2.5:0.5:2.5,'YTick',-2.5:0.5:2.5);
xlim([-2.5,2.5])
ylim([-2.5,2.5])
xlabel('X')
ylabel('Y')
hold on
grid on
[x1,y1,x2,y2] = pzk(Theta(length(Theta),1),Theta(length(Theta),2),L1,L2);
h1 =plot([0 x1],[0 y1],'linewidth',3,'color','r');
h2 =plot([x1 x2],[y1 y2],'linewidth',3,'color','r');
for i = length(Theta)-1:-1:1
    delete(h2)
    delete(h1)
    [x1,y1,x2,y2] = pzk(Theta(i,1),Theta(i,2),L1,L2);
    h1 =plot([0 x1],[0 y1],'linewidth',3,'color','r');
    h2 =plot([x1 x2],[y1 y2],'linewidth',3,'color','r');
    h3 = plot(x2,y2,'ok','markersize',1.5);
    pause(0.01)
end
