data2a=[];
data2a=V_straightened'; %%%Input
P_num=[];
for po=1:1:effectiveParticlesNumber%%input
    sizeP=size(TVPick_straightened{po,1},2);%%input
    P_temp=[];
    P_temp(1:sizeP,1)=po;
    P_num=[P_num;P_temp];
end
data2a(:,4)=P_num;
V_straightened(4,:)=data2a(:,4)';
StraightenNPC=V_straightened;%%Output
clear data2c P_num P_temp po
