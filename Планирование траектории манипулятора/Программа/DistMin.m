%% Функция определения столкновений
function [Dm Dm1] = DistMin(x2,y2,x1, y1,x0,y0,k)
    Xt = ((x2 - x1) * (x1 - x0(k)));
    Yt = ((y2 - y1) * (y1 - y0(k)));
    t1 = ((-Xt-Yt)/((x2-x1)^2+(y2-y1)^2));
    if t1 < 0
        t = 0;
    elseif t1 > 1
        t = 1;
    else
        t = t1;
    end
    x4 = (x1 + (x2 - x1)*t);
    y4 = (y1 + (y2 - y1)*t);
    Dm = (sqrt((x4-x0(k))^2+(y4-y0(k))^2));
    
    Xt = ((x1 - 0) * (0 - x0(k)));
    Yt = ((y1 - 0) * (0 - y0(k)));
    t1 = ((-Xt-Yt)/((x1-0)^2+(y1-0)^2));
    if t1 < 0
        t = 0;
    elseif t1 > 1
        t = 1;
    else
        t = t1;
    end
    x4 = (0 + (x1 - 0)*t);
    y4 = (0 + (y1 - 0)*t);
    Dm1 = (sqrt((x4-x0(k))^2+(y4-y0(k))^2));
end