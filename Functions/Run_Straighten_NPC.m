B_initial=Generate16blobcenters(55,25);
V_origin{1,1}=cell2mat(TVPick');
[Rm,tm,Xm,Sm,am] = jrmpc_Nooutliers_noXupdate(V_origin,B_initial,'maxNumIter',50, 'epsilon', 1e-5);%'gamma',0.2);%'S',1000);   %JRMPC
P_straightened= cellfun(@(V,R,t) bsxfun(@plus,R*V,t),V_origin,Rm,tm,'uniformoutput',false);
% Straightened_NPC{i,1}=V_straightened;
[Rm,tm,Xm,Sm,am] = jrmpc_Nooutliers_noXupdate(V_origin,B_initial,'maxNumIter',50, 'epsilon', 1e-5);%'gamma',0.2);%'S',1000);   %JRMPC
RmP=[];
tmP=[];
for ip=1:effectiveParticlesNumber
    RmP{ip,1}=cell2mat(Rm);
    tmP{ip,1}=cell2mat(tm);
end
TVPick_straightened=[];
TVPick_straightened=cellfun(@(V,R,t) bsxfun(@plus,R*V,t),TVPick,RmP,tmP,'uniformoutput',false);

V_straightened=cell2mat(P_straightened);
%  figure()
% hist(V_straightened(3,:),1000)