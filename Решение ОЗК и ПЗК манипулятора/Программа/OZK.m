% Решение ОЗК для ТУР10-К БЕЗ ОГРАНИЧЕНИЙ
% Начальные условия
clear all;
alp = [-90 0 0 0 90 0 0]*pi/180; % Угол м/у z_i и z_i-1
a = [0 500 0 670 220 0 0]; % Кратчайшее расстояние м/у z_i и z_i-1
d = [700 0 0 0 0 0 0]; % Кратчайшее расстояние м/у x_i и x_i-1

x0(1) = 0; x0(2) = 0; x0(3) = 0; %Декартовы координаты
xz(1) = 1048; xz(2) = 0; xz(3) = 580; %Целевые декартовы координаты


%% Случайный поиск
k=1; gamma=1; 
x(1,1)=0; x(1,2)=0; x(1,3)=0; x(1,4)=0; x(1,5)=0; x(1,6)=0; x(1,7)=0;%Нач. обобщ. координаты
F(k)=Q(x(k,:),xz);
delta=0.00001;

while k<=100
k=k+1;
eps=[2*rand()-1; 2*rand()-1; 2*rand()-1; 2*rand()-1; 2*rand()-1; 2*rand()-1; 2*rand()-1];
x(k,1)=x(k-1,1)+gamma*eps(1);
x(k,2)=x(k-1,2)+gamma*eps(2);
x(k,3)=-x(k,2);
x(k,4)=x(k-1,4)+gamma*eps(4);
x(k,5)=x(k-1,5)+gamma*eps(5);
x(k,6)=-2*x(k,5);
x(k,7)=x(k-1,7)+gamma*eps(7);
F(k)=Q(x(k,:),xz);
if (F(k)>0.1)&(F(k)<1)
    gamma=0.1;
end
if (F(k)>0.01)&(F(k)<0.1)
    gamma=0.01;
end
if abs(F(k)-F(k-1))<=delta
break
end
if F(k)>F(k-1)
k=k-1;
continue
end
N=F(k);
% k
end
disp('Число шагов поиска = '); disp(k);
disp('Ошибка позиционирования (мм) = '); disp(N);

k1=floor(k/4);
for i=k:k
   % i
    teta=x(i,:);%*pi/180; 
    teta1=x(i,:);
[A, T, coords] = den_hart(teta,alp, a, d);
disp('Координаты схвата (мм) = '); disp(coords); figure()
plot3(coords(1), coords(2),coords(3),'r')
hold on; grid on; title('Конфигурация робота')
x1 = [0,T(1,1),T(2,1),T(3,1),T(4,1),T(5,1),T(6,1),T(7,1)];
y1 = [0,T(1,2),T(2,2),T(3,2),T(4,2),T(5,2),T(6,2),T(7,2)];
z1 = [0,T(1,3),T(2,3),T(3,3),T(4,3),T(5,3),T(6,3),T(7,3)];
plot3(x1,y1,z1,'o-r')
hold off
end
 
%% Представление Денавита-Хартенберга для графики
function [A, T, coords] = den_hart(t, alp, a, d) % Представление Денавита-Хартенберга
t(2)=t(2)-90;
t(4)=t(4)+90;
t=t*pi/180;
A = 1; T = zeros(6,3);
for j = 1:7
B = [cos(t(j)) -cos(alp(j))*sin(t(j)) sin(alp(j))*sin(t(j)) a(j)*cos(t(j));
    sin(t(j)) cos(alp(j))*cos(t(j)) -sin(alp(j))*cos(t(j)) a(j)*sin(t(j));
    0 sin(alp(j)) cos(alp(j)) d(j);
    0 0 0 1];

A = A*B;
T(j,1) = A(1,4);
T(j,2) = A(2,4);
T(j,3) = A(3,4);
end
coords = [A(1,4),A(2,4), A(3,4)];
end

%% Представление Денавита-Хартенберга для расчетов
function B = BB( fi,i )
alpha = [-90 0 0 0 90 0 0]*pi/180; % Угол м/у z_i и z_i-1
a = [0 500 0 670 220 0 0]; % Кратчайшее расстояние м/у z_i и z_i-1
d = [700 0 0 0 0 0 0]; % Кратчайшее расстояние м/у x_i и x_i-1
 
B = [cos(fi(i)) -cos(alpha(i))*sin(fi(i)) sin(alpha(i))*sin(fi(i)) a(i)*cos(fi(i));
        sin(fi(i)) cos(alpha(i))*cos(fi(i)) -sin(alpha(i))*cos(fi(i)) a(i)*sin(fi(i));
        0 sin(alpha(i)) cos(alpha(i)) d(i);
        0 0 0 1];
end

%% Функция
function [ ret ] = Q (fi, xz)
fi(2)=fi(2)-90;
fi(4)=fi(4)+90;
fi= fi*pi/180;
T7 = BB(fi,1)*BB(fi,2)*BB(fi,3)*BB(fi,4)*BB(fi,5)*BB(fi,6)*BB(fi,7);
x(1) = T7(1,4);
x(2) = T7(2,4);
x(3) = T7(3,4);

%Целевая функция. Задавается пользователем.
ret = sqrt((xz(1) - x(1))^2 + (xz(2) - x(2))^2 + (xz(3) - x(3))^2);
end