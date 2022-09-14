function [topEmitters,BottomEmitters] = sort_ring(ring)
%Split one ring with 16 emitters to two rings with 8 emitters

topEmitters0=ring(:,find(ring(3,:)>median(ring(3,:))));
BottomEmitters0=ring(:,find(ring(3,:)<median(ring(3,:))));
topEmitters=align_emitters(topEmitters0);
BottomEmitters=align_emitters(BottomEmitters0);
if norm(topEmitters(1:3,1)-BottomEmitters(1:3,1))>norm(topEmitters(1:3,1)-BottomEmitters(1:3,8))
    tb_temp(:,1)=BottomEmitters(:,8);
    tb_temp(:,2:8)=BottomEmitters(:,1:7);
    BottomEmitters=tb_temp;
end
end


function [alignedemitters] = align_emitters(ring)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
ring(4,:)=atan2(ring(2,:),ring(1,:));
alignedemitters=sortrows(ring',4)';
end