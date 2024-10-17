% Решение ПЗК для ТУР10-К
clear all; clc;
%Обобщенные координаты
teta(1)= 0; teta(2)= 45; teta(4)= 45; teta(5)= 0; teta(7)= 0; % Угол м/у x_i и x_i-1
%Добавление вирутальных звеньев
teta(3)=-teta(2);
teta(6)=-2*teta(5);
teta(2)=teta(2)-90;
teta(4)=teta(4)+90;
teta=teta*pi/180;
%Четыре параметра для описания кинематической конфигурации
alp = [-90 0 0 0 90 0 0]*pi/180; % Угол м/у z_i и z_i-1
a = [0 500 0 670 220 0 0]; % Кратчайшее расстояние м/у z_i и z_i-1
d = [700 0 0 0 0 0 0]; % Кратчайшее расстояние м/у x_i и x_i-1

%Примененение преобразования Денавита-Хартенберга
[A, T, coords] = den_hart(teta,alp, a, d);
disp('Координаты схвата (мм) = '); disp(coords); figure()
plot3(coords(1), coords(2),coords(3),'r')
hold on; grid on; title('Конфигурация робота')
x = [0,T(1,1),T(2,1),T(3,1),T(4,1),T(5,1),T(6,1),T(7,1)];
y = [0,T(1,2),T(2,2),T(3,2),T(4,2),T(5,2),T(6,2),T(7,2)];
z = [0,T(1,3),T(2,3),T(3,3),T(4,3),T(5,3),T(6,3),T(7,3)];
for i = 1:8
    if abs(x(i)) < 0.0000000001
        x(i)=0;
    end
    if abs(y(i)) < 0.0000000001
        y(i)=0;
    end
    if abs(z(i)) < 0.0000000001
        z(i)=0;
    end
end
plot3(x,y,z,'o-r','MarkerSize',5,'LineWidth',3)
hold off

%Представление Денавита-Хартенберга
function [A, T, coords] = den_hart(teta, alp, a, d) 
A = 1; T = zeros(7,3);
for j = 1:7
    %ПОлучение матриц A1...A7 в цикле
B = [cos(teta(j)) -cos(alp(j))*sin(teta(j)) sin(alp(j))*sin(teta(j)) a(j)*cos(teta(j));
    sin(teta(j)) cos(alp(j))*cos(teta(j)) -sin(alp(j))*cos(teta(j)) a(j)*sin(teta(j));
    0 sin(alp(j)) cos(alp(j)) d(j);
    0 0 0 1];
%Рассматриваем каждое звено и записываем координаты
A = A*B;
%T - матрица с координатами всех звеньев (1 строка - 1 звено)
T(j,1) = A(1,4);
T(j,2) = A(2,4);
T(j,3) = A(3,4);
end
%Координаты схвата
coords = [A(1,4),A(2,4), A(3,4)];
end