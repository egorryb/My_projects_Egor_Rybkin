%% Построение препятствий
function [xp,yp]= circle(x,y,r,workspace)
ang=0:0.01:2*pi;
xp=(r*cos(ang));
yp=(r*sin(ang));
if workspace
    plot(x+xp,y+yp,'k--');
else
    fill(x+xp,y+yp,[0.5 0.5 0.5]);
end
end