function [angleline,anglevector] = Phi2Tangent(Emitters_2)
%Calculate the angle between the tagent and the connecting line
% % % Define the coordinates of the two points
% % if Emitters_2(3,1)>Emitters_2(3,2)
% %     x1=Emitters_2(1,1);
% %     y1=Emitters_2(2,1);
% %     x2=Emitters_2(1,2);
% %     y2=Emitters_2(2,2);
% % else
% %     x1=Emitters_2(1,2);
% %     y1=Emitters_2(2,2);
% %     x2=Emitters_2(1,1);
% %     y2=Emitters_2(2,1);
% % end
%%(x,y) to (y,x) to keep the same with the EM coordinates
% Define the coordinates of the two points
if Emitters_2(3,1)>Emitters_2(3,2)
    y1=Emitters_2(1,1);
    x1=Emitters_2(2,1);
    y2=Emitters_2(1,2);
    x2=Emitters_2(2,2);
else
    y1=Emitters_2(1,2);
    x1=Emitters_2(2,2);
    y2=Emitters_2(1,1);
    x2=Emitters_2(2,1);
end
% Calculate the radius of the circle
% r = sqrt(x1^2 + y1^2);

% Calculate the center of the line segment
x0 = (x1 + x2)/2;
y0 = (y1 + y2)/2;

% Calculate the angle betwee the line to the x-axis
alpha = atan2(y2-y1, x2-x1);
% alpha*180/pi
beta=atan2(y0,x0);
% beta*180/pi
% Calculate the angle from the tagent to the line
%angle = alpha - 0 - atan2(y0, x0) + pi/2;
angle=(pi/2+beta-alpha);%nishizhen+
% -(pi/2+beta-alpha)*180/pi
angle=angle/pi*180;
anglevector=wrapTo180(angle);
angleline=wrapTo90(angle);

end