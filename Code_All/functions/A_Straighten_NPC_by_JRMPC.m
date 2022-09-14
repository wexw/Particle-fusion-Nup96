clc
clear
addpath('functions')
B_initial=Generate16blobcenters(55,25);
load('OriginalNPC.mat')
for type=1:6
V_origin{1,1}=OriginalNPC{type,1}(:,1:3)';
[Rm,tm,Xm,Sm,am] = jrmpc_Nooutliers_noXupdate(V_origin,B_initial,'maxNumIter',50, 'epsilon', 1e-5);%'gamma',0.2);%'S',1000);   %JRMPC
P_straightened= cellfun(@(V,R,t) bsxfun(@plus,R*V,t),V_origin,Rm,tm,'uniformoutput',false);


V_straightened=cell2mat(P_straightened);
V_straightened(4:5,:)=OriginalNPC{type,1}(:,4:5)';
StraightenNPC{type,1}=V_straightened;
end
save('A_StraightenNPC_JRMPC.mat','StraightenNPC')