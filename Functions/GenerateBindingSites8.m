function [BindingSites8]=GenerateBindingSites8(R_Ring)

center_0=[0,R_Ring,0];

BindingSites8(:,1)=center_0;
for i=1:1:7
    angle = 2*pi/8*i;
    Rot=[cos(angle) -sin(angle) 0; sin(angle) cos(angle) 0; 0 0 1];
    BindingSites8(:,i+1) = BindingSites8(:,1)'*Rot';
end
end