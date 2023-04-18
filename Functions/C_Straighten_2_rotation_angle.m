
Anglex2=Anglex;
Angley2=Angley;

A=[];
A=U_All;
columA=[];
rowA=[];
cloumA=sum(A);%
rowA=sum(A');
[~,ra]=min(rowA);%find the row with minimum sum fwhm
[~,ca]=min(cloumA);% find the coloum with the minimum sum fwhm
anglex3=Anglex2(1,ra);
angley3=Angley2(1,ca);

data2c2=[];
SuperParticle0=StraightenNPC';
SuperParticle1=SuperParticle0(:,1:3)';
SuperParticleX=[rotx(anglex3)*SuperParticle1];
SuperParticle=[roty(angley3)*SuperParticleX]';

data2c2=SuperParticle;

data2c2(:,4)=SuperParticle0(:,4);

Optimal_Straightened_NPC=data2c2;

clear SuperParticle0 SuperParticle SuperParticleX SuperParticle1