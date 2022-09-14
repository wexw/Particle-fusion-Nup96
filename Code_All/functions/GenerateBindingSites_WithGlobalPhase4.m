function [BindingSites]=GenerateBindingSites_WithGlobalPhase4(Param)
R_Ring=Param(1,1);
r=Param(1,2);
theta=Param(1,3);%out of plane angle, degree
phi0=Param(1,4);% inclination angle
center_0=[Param(1,5),Param(1,6),Param(1,7)];
psi=atan2(Param(1,6),Param(1,5));%rad
%  R_Ring*cos(psi)
% phi=phi0-90+atan2(Param(1,6),Param(1,5))/pi*180;
phi=phi0/180*pi;
theta=theta/180*pi;
% x_0=r*sin(theta)*cos(phi);
% y_0=r*sin(theta)*sin(phi);

% x_0=r*sin(theta)*sin(phi+psi);
% y_0=r*(-sin(theta))*cos(phi+psi);
% z_0=-r*cos(theta);
x_0=-r*sin(theta)*sin(phi+psi);
y_0=r*(sin(theta))*cos(phi+psi);
z_0=r*cos(theta);
BindingSites(:,1)=[x_0,y_0,z_0]+center_0;
BindingSites(:,2)=-[x_0,y_0,z_0]+center_0;

for i=1:1:7
    angle = 2*pi/8*i;
    Rot=[cos(angle) -sin(angle) 0; sin(angle) cos(angle) 0; 0 0 1];
    BindingSites(:,2*i+1) = BindingSites(:,1)'*Rot';
    BindingSites(:,2*i+2) = BindingSites(:,2)'*Rot';
end
end