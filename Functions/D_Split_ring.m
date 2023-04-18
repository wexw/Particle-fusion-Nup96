%D_Split_ring;

NPC=[];
DensityNPC=[];
LabelNPC=[];

NPC=Optimal_Straightened_NPC';

positionNR=find(NPC(3,:)>=0);

NR=NPC(:,positionNR);
positionCR=find(NPC(3,:)<0);

CR=NPC(:,positionCR);

NRs=NR;
CRs=CR;
