%% Построение пространства
function [xp,yp]= new_circle(x,y,L1,L2)
ang1=0:0.01:180;
ang2=0:0.01:10;
xp=((L1+L2)*cosd(ang1));
yp=((L1+L2)*sind(ang1));
xp1 = L1*cosd(175) + L2 * cosd(ang2+175);
yp1 = L1*sind(175) + L2 * sind(ang2+175);
xp = cat(2,xp,xp1);
yp = cat(2,yp,yp1);
plot(x+xp,y+yp,'k--');
ang3=0:-0.01:-180;
ang4=0:-0.01:-10;
xpy=((L1+L2)*cosd(ang3));
ypy=((L1+L2)*sind(ang3));
xp1y = L1*cosd(-175) + L2 * cosd(ang4-175);
yp1y = L1*sind(-175) + L2 * sind(ang4-175);
xpy = cat(2,xpy,xp1y);
ypy = cat(2,ypy,yp1y);
hold on;
plot(x+xpy,y+ypy,'k--');
grid on;
x1 = (L1 * cosd(ang1));
y1 = (L1 * sind(ang1));
x2 = x1 + L2 * cosd(ang1+175);
y2 = y1 + L2 * sind(ang1+175);
plot(x2,y2,'k--');
x1 = (L1 * cosd(ang3));
y1 = (L1 * sind(ang3));
x2 = x1 + L2 * cosd(ang3+175);
y2 = y1 + L2 * sind(ang3+175);
plot(x2,y2,'k--');

