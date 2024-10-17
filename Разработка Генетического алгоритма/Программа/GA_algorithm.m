clear all; clc;
%% Начальные параметры
mode = 1; %Выбор функции
Npop = 50; %Количество популяци 
Nvar = 2; %Количество переменных функции
iga = 0; %Номер итерации
u = 0.2; % Процент мутаций
xo = [5,5];
pop_temp = zeros(Npop,2);
Nkeep = Npop*0.5; %Количество отсеиваемых хромосом
cost = zeros(Npop,1); %вектор стоимости
beta = 0.4; %коэффициент при скрещивании 
pop_new = zeros(Nkeep,Nvar); %Массив новых генов (потомков)
maxit=100; %максимальное количество итераций
nmut = ceil(u*(Npop-1)*Nvar); %Количество мутаций
if mode == 1
    fitness = @(x) 100*(x(1).^2-x(2).^2).^2+(x(1)-1).^2; %Целевая функция
elseif mode == 2 
    %fitness = @(x) 1 + 1/4000*(x(1)^2 + x(2)^2) - cos(x(1)) * cos(1/2*x(2)/sqrt(2));
    %fitness = @(x) -20*exp(-0.2*sqrt(0.5*(x(1).^2+x(2).^2)))-exp(0.5*(cos(2*pi*x(1))+cos(2*pi*x(2))))+20;
    fitness = @(x) 1/800*(( x(1)-xo(1) ).^2 + ( x(2)-xo(2) ).^2) - cos(x(1)) * cos(x(2)/sqrt(2));
elseif mode == 3
    fitness = @(x) (x(1).^2+x(2)-11).^2+(x(1)+x(2).^2-7).^2; % Функция Химмельблау
end
M = ceil((Npop-Nkeep)/2); %Количество скрещиваний
%Ограничения генов
phi = [-10 -10]; %наименьшее значение доступного диапазона генов
plo = [10 10]; %наибольшее значение доступного диапазона генов

%% Формирование начальной популяции
pop = rand(Npop,Nvar); %нормализованные значения от 0 до 1
pop(:,1) = (phi(1,1)-plo(1,1))*pop(:,1)+plo(1,1);
pop(:,2) = (phi(1,2)-plo(1,2))*pop(:,2)+plo(1,2);
%массив pop - это начальная популяция, выбранная случайным образом в
%диапазоне от -5 до 5
%формирование стомости каждой хромосомы
for i=1:Npop
    cost(i) = fitness([pop(i,:)]);
end
[cost ind] = sort(cost);
%Сортировка популяций по их приспособленности к выживанию
for i=1:Npop
    pop_temp(i,:)=pop(ind(i),:);
end
pop = pop_temp;

%% Цилк программы
while iga<maxit
    iga = iga+1;
% Формирование родителей случайным образом
for i=1:Nkeep
ma = pop(ceil(Nkeep*rand(Nkeep, 1)),:); %вектор строк в pop для parent_1
pa = pop(ceil(Nkeep*rand(Nkeep, 1)),:); %вектор строк в pop для parent_2
end

%ДОДЕЛАТЬ
% %Турнирная сетка
% k=1;
% t=1;
% for i=1:Npop
%     cost_temp = 0;
%     numbers = randi([1,50],1,ceil(Npop*0.1)); %10 процентов хромосом участвуют в турнире
%     for j=1:ceil(Npop*0.1)
%         cost_temp(j) = fitness([pop(numbers(j),:)]);
%     end
%     [min_value index] = min(cost_temp);
%     pop_new(i,:) = pop(numbers(index),:);
% 
%     if mod(i,2) == 1
%         ma(k,:) = pop_new(i,:);
%         k= k+1;
%     elseif mod(i,2) == 0 
%         pa(t,:) = pop_new(i,:);
%         t=t+1;
%     end
% end
% for i=1:length(ma)
%     if rand()<u
%     for j=1:Nvar
%         pop_new(i,j) = beta*ma(i,j)+(1-beta)*pa(i,j); %потомки родителей
%     end
%     end
% end
% 


%Скрещивание родителей, всего новых особей (Npop - Nkeep)/2
for i=1:M
    for j=1:Nvar
        pop_new(i,j) = beta*ma(i,j)+(1-beta)*pa(i,j); %потомки родителей
    end
end
%Добавление потомков в популяцию
k=1;
for i=(Nkeep+1):Npop
    pop(i,:) = pop_new(k,:);
    k=k+1;
end


% %Процесс мутации
mrow=ceil(rand(1,nmut)*(Npop-1))+1;
mcol=ceil(rand(1,nmut)*Nvar);
for i=1:nmut
    pop(mrow(i),mcol(i)) = (phi(1)-plo(1))*rand+plo(1);
end

%Результаты функции
for i=1:Npop
    cost(i) = fitness([pop(i,:)]);
end
[cost ind] = sort(cost);
for i=1:Npop
    pop_temp(i,:)=pop(ind(i),:);
end
pop = pop_temp;
minc(iga)=cost(1); %Минимальная стоимость
meanc(iga)=mean(cost); %Средняя стоимость 
end

%% Построение графиков

%Контурный график
figure
x1 = -5:0.1:5;
x2 = -5:0.1:5;
[X1,X2]=meshgrid(x1,x2);
if mode == 1
    fitness = 100*(X1.^2-X2.^2).^2+(X1-1).^2;
elseif mode == 3
    fitness = (X1.^2+X2-11).^2+(X1+X2.^2-7).^2;
elseif mode == 4
    fintess = 1/800 *(( X1).^2 + ( X2).^2) - (cos(X1) * cos(X2/sqrt(2)));
end
contour(X1,X2,fitness);
hold on
title('Линии равного уровня');
plot(1,1,'*r'); 
plot(pop(1,1),pop(1,2),'+g');
hold off
figure
%График лучшей особи
semilogx(1:iga,minc);
%plot(1:iga,minc,'r');
grid on;
title('График изменения лучшей особи');
ylabel('Значение целевой функции');
xlabel('Номер итерации алгоритма');
figure
plot(1:iga,meanc,'g');
title('График изменения популяции в среднем');
ylabel('Значение целевой функции');
xlabel('Номер итерации алгоритма');
grid on;

%% Цикл увеличения популяций
% while iga < maxit
%     iga = iga+1;
% M=ceil((Npop-Nkeep)/2);
% prob = flipud([1:Nkeep]'/sum([1:Nkeep]));
% odds = [0 (cumsum(prob(1:Nkeep)))']';
% pick1=rand(1,M); % mate #1
% pick2=rand(1,M);
% ic=1;
% while ic<=M
%     for id=2:keep+1
%         if pick1(ic)<=odds(id) & pick1(ic)>odds(id-1)
%             ma(ic)=id-1;
%         end
%         if pick2(ic)<=odds(id) & pick2(ic)>odds(id-1)
%             pa(ic)=id-1;
%         end
%     end
%     ic=ic+1;
% end
% end
