%% ОЗК
function [theta1, theta2] = ozk(x2,y2,L1,L2)
    if y2 > 0 
        theta2 = acosd((x2^2 + y2^2 - L1^2 - L2^2)/(2*L1*L2));
    else 
        theta2 = -acosd((x2^2 + y2^2 - L1^2 - L2^2)/(2*L1*L2));
    end
    theta1 = atan2d(y2,x2) - atan2d((L2*sind(theta2)),(L1 + L2*cosd(theta2)));
