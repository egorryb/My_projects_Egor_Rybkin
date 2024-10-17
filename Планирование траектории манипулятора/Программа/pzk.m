%% ПЗК
function [x1,y1,x2,y2] = pzk(theta1,theta2,L1,L2)
x1 = (L1 * cosd(theta1));
y1 = (L1 * sind(theta1));
x2 = x1 + L2 * cosd(theta1+theta2);
y2 = y1 + L2 * sind(theta1+theta2);
end