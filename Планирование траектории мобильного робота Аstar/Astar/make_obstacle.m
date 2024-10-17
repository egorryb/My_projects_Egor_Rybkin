function make_obstacle(x,y,r)
ang = 0:0.1:360;
xplot = r*cosd(ang);
yplot = r*sind(ang);
fill(x+xplot,y+yplot,[0.5 0.5 0.5]);