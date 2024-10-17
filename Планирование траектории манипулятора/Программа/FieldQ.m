%% Функция построения пространства конфигураций
function [xStart, yStart, xTarget, yTarget, MAP,start,target,obst]= ...
    FieldQ(theta1_target,theta2_target,theta1_start,theta2_start...
    ,Obst,MIN_X,MIN_Y,MAX_X,MAX_Y)
figure;
set(gcf,'Color','white');
set(gca,'FontName','Times New Roman');
set(gca,'FontSize',14)
set(gca, 'XTick',MIN_X:25:MAX_X+1,'YTick',MIN_Y:25:MAX_Y+1);
MAP=2*(ones(0,MAX_X+abs(MIN_X)));
axis([MIN_X MAX_X+1 MIN_Y MAX_Y+1])
grid on
hold on
xlabel('theta1')
ylabel('theta2')
MAP(theta1_target+abs(MIN_X),theta2_target+abs(MIN_Y))=0;
target = plot(theta1_target,theta2_target,'diamond','color','red','linewidth',3);
%pause(0.1)
obst = plot(Obst(:,1),Obst(:,2),'ok','MarkerSize',3);
%pause(0.1)
MAP(theta1_start+abs(MIN_X),theta2_start+abs(MIN_Y))=1;
start = plot(theta1_start,theta2_start,'diamond','color','blue','linewidth',3);
xStart = theta1_start;
yStart = theta2_start;
xTarget = theta1_target;
yTarget = theta2_target;
title('')