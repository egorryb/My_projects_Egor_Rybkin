% Функция вычисления расстояния
function cost = cost(x1,x2,y1,y2)
%cost = (abs(x1-x2) + abs(y1-y2));
cost = sqrt((x1-x2)^2 + (y1-y2)^2);

