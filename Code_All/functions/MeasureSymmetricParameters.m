function [rd,R,theta,phi,c1x,c1y,c1z,angle2] = MeasureSymmetricParameters(ring)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
%find pairs
[tt,tb]=sort_ring(ring);
%distance in the dimers
for i=1:8
tdindimers(i)=norm(tt(1:3,i)-tb(1:3,i));
end
rd=mean(tdindimers)/2;
%radius of the ring
% for i=1:4
% ttrradius(i)=norm(tt(1:3,i)-tt(1:3,i+4))./2;
% tbrradius(i)=norm(tb(1:3,i)-tb(1:3,i+4))./2;
% 
% end
% attrradius=mean(ttrradius);
% atbrradius=mean(tbrradius);
% R=(attrradius+atbrradius)/2;
center=((tt'+tb')/2)';
for i=1:8
    Rc(i)=norm(center(1:2,i));
end
R=mean(Rc);

% figure()
% scatter3(tt(1,:),tt(2,:),tt(3,:),'r')
% hold on 
% scatter3(tb(1,:),tb(2,:),tb(3,:),'b')
% hold on
% scatter3(center(1,:),center(2,:),center(3,:),'g')
% axis equal
% view(0,90)
for i=1:8
    %Out of plane angle
    theta_t_dindimers(i)=atan2(norm(tt(1:2,i)-tb(1:2,i)),tt(3,i)-tb(3,i))/pi*180;
%     phi_t_dindimers(i)=atan2(norm(tt(2,i)-tb(2,i)),norm(tt(1,i)-tb(1,i)))/pi*180;
%Angle between center and origin point in the xy plane
angle2(i)=atan2(center(2,i),center(1,i))/pi*180;%psi
%     phi_b_dindimers(i)=atan2(norm(bt(2,i)-bb(2,i)),norm(bt(1,i)-bb(1,i)))/pi*180;
    phi_t_dindimers(i)=atan2(tt(2,i)-tb(2,i),tt(1,i)-tb(1,i))/pi*180;

  Phi_t_new(i)=90+phi_t_dindimers(i)-atan2(center(2,i),center(1,i))/pi*180;
  if Phi_t_new(i)<-90
     Phi_t_new(i)=Phi_t_new(i)+180;
      end
    if Phi_t_new(i)>90
    Phi_t_new(i)=Phi_t_new(i)-180;
    end
      if Phi_t_new(i)<-90
    Phi_t_new(i)=Phi_t_new(i)+180;
      end
    if Phi_t_new(i)>90
      Phi_t_new(i)=Phi_t_new(i)-180;
    end
end
center(4,:)=angle2;
[mina,minp]=min(abs(angle2-90));
theta=mean(theta_t_dindimers);
phi=mean(Phi_t_new);
c1x=center(1,minp);
c1y=center(2,minp);
c1z=center(3,minp);
% center1=center(1,1);
end

