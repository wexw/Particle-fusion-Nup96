 function [data2process] = Get_Pure_Rings(TVPick_straightened)
V_straightened=cell2mat(TVPick_straightened');
effectiveParticlesNumber=size(TVPick_straightened,1);
data2process.TVPick_Straightened=TVPick_straightened;
data2process.effectiveParticlesNumber=effectiveParticlesNumber;

AttachParticleNum
data2process.V_straightened=V_straightened;

B_FindOptimalRotation
data2process.UAll=U_All;

C_Straighten_2_rotation_angle
data2process.Optimal_rotated_V=data2c2;

D_Split_ring
data2process.NRall=NR;
data2process.CRall=CR;

 end