%Calculate Difference between 2 datasets
function [AverageD,mzd,mxydd]=EmittersDistAverage(EMModel, SEmitters)
%Average distance between bindingsites of asymmetric models
%Input
%TBindingSites: Transformed binding sites of particles
%Output
%Average D
SNAP=EMModel;
SMLM=SEmitters;
ring=SMLM';
TE0=ring(:,find(ring(3,:)>mean(ring(3,:))));
BE0=ring(:,find(ring(3,:)<mean(ring(3,:))));

ring=SNAP';
TC0=ring(:,find(ring(3,:)>mean(ring(3,:))));
BC0=ring(:,find(ring(3,:)<mean(ring(3,:))));

[TTE,TBE]=sort_ring(TE0);

[BTE,BBE]=sort_ring(BE0);

[TTC,TBC]=sort_ring(TC0);

[BTC,BBC]=sort_ring(BC0);

SMLM1=[TTE,TBE,BTE,BBE];
SNAP1=[TTC,TBC,BTC,BBC];

%Find the corresponding sites of Em and CM
for i=1:1:32

for j=1:1:32
    xyd(i,j)=norm(SMLM(i,:)-SNAP(j,1:3));
end
[a,b]=find(xyd(i,:)==min(xyd(i,:)));
pb(i)=b;
end
SMLM(:,4)=pb;
SMLM(:,5)=SMLM(:,3)+SMLM(:,4)*1000;

ASM=sortrows(SMLM,5);
SNAP(:,4)=ASM(:,4);
SNAP(:,5)=SNAP(:,3)+SNAP(:,4)*1000;
AEM=sortrows(SNAP,5);
for i=1:32
zd(i)=norm(ASM(i,3)-AEM(i,3));
xydd(i)=norm(ASM(i,1:2)-AEM(i,1:2));
dd(i)=norm(ASM(i,1:3)-AEM(i,1:3));
end
AverageD=mean(dd);
mzd=mean(zd);
mxydd=mean(xydd);
end