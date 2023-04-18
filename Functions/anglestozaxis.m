function [angle_degrees] = anglestozaxis(Emitters_2)
% Calculate the vector between the two points
if Emitters_2(3,1)>Emitters_2(3,2)
    vec = Emitters_2(:,1)-Emitters_2(:,2);
else
    vec = Emitters_2(:,2)-Emitters_2(:,1);
end
%[x2-x1; y2-y1; z2-z1];
% Calculate the angle between the vector and the z-axis
angle = acos(vec(3)/norm(vec));
% Convert the angle to degrees
angle_degrees = angle*180/pi;
angle_degrees =wrapTo180(angle_degrees);
end