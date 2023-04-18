function [SE] = GenerateSymmetricEmitters(Param)
%Generate Symmetric Emitters for a single ring by parameters
%The center of the first pair of emitters locates at [0,R_Ring,z]
R_Ring=Param(1,1);
r=Param(1,2);
theta=Param(1,3)/180*pi;%out of plane angle, it should be in 0 to pi/2
phi=Param(1,4)/180*pi;% In plane angle, 0 to 2pi
z=Param(1,5);
center_0=[0,R_Ring,z];
x_0=r*sin(theta)*cos(phi);
y_0=r*sin(theta)*sin(phi);
z_0=r*cos(theta);
SE(:,1)=[x_0,y_0,z_0]+center_0;
SE(:,2)=-[x_0,y_0,z_0]+center_0;

for i=1:1:7
    angle = 2*pi/8*i;
    Rot=[cos(angle) -sin(angle) 0; sin(angle) cos(angle) 0; 0 0 1];
    SE(:,2*i+1) = SE(:,1)'*Rot';
    SE(:,2*i+2) = SE(:,2)'*Rot';
end
end
