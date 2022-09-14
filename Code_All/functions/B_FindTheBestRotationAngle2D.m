% clc
% clear
addpath('functions')
addpath('results')
set(0,'defaultfigurecolor','white')
nbins=150;
load('A_StraightenNPC_JRMPC.mat')
for type=1:6
    ix=0;
    iy=0;
    SuperParticle0=[];
    SuperParticle1=[];
    SuperParticle0=StraightenNPC{type,1}';
    SuperParticle1=SuperParticle0(:,1:3)';
    Anglex{type,1}=[];
    Angley{type,1}=[];
    meanz{type,1}=[];
    stdz{type,1}=[];
    U_All{type,1}=[];
    for RxA=-3:0.1:3
        ix=ix+1
        SuperParticleX=[rotx(RxA)*SuperParticle1];
        iy=0;
        for RyA=-3:0.1:3
            iy=iy+1
            SuperParticle=[roty(RyA)*SuperParticleX]';
            sizeview=80;
            idx = find(SuperParticle(:,1) <  sizeview& ...
                SuperParticle(:,1) > -sizeview  & ...
                SuperParticle(:,2) <  sizeview & ...
                SuperParticle(:,2) > -sizeview  & ...
                SuperParticle(:,3) <  sizeview & ...
                SuperParticle(:,3) > -sizeview);
            SuperParticle =SuperParticle(idx,:);
            
            
            [xzp,yzp]=zHistW(SuperParticle(:,3), nbins);
            %         set(gcf,'color','w')
            %         set(gca,'color','w')
            [minx,X0place]=min(abs(xzp));
            [max1,p1]=max(yzp(1,1:X0place));
            xmax1=xzp(1,p1);
            yzp1=yzp(1,1:X0place);
            fmax1=0.5*max1;
            
            yzp1minus=abs(yzp1-fmax1);
            [min1,pmin1]=min(yzp1minus(1,1:round(size(yzp1minus,2)/2)));
            [min2,pmin2]=min(yzp1minus(1,round(size(yzp1minus,2)/2)+1:round(size(yzp1minus,2))));
            xmin1=xzp(1,pmin1);
            xmin2=xzp(1,pmin2+round(size(yzp1minus,2)/2));
            
            [max2,p2]=max(yzp(1,X0place+1:size(yzp,2)));
            xmax2=xzp(1,p2+X0place);
            yzp2=yzp(1,X0place+1:size(yzp,2));
            uncertainty1=abs(xmin1-xmin2)/sqrt(size(SuperParticle,1)/2);
            U1=abs(xmin1-xmin2);
            
            fmax2=0.5*max2;
            yzp2minus=abs(yzp2-fmax2);
            [min3,pmin3]=min(yzp2minus(1,1:round(size(yzp2minus,2)/2)-1));
            [min4,pmin4]=min(yzp2minus(1,round(size(yzp2minus,2)/2):size(yzp2minus,2)));
            xmin3=xzp(1,pmin3+X0place);
            xmin4=xzp(1,pmin4+round(size(yzp2minus,2)/2)+X0place-1);
            uncertainty2=abs(xmin3-xmin4)/sqrt(size(SuperParticle,1)/2);
            U2=abs(xmin3-xmin4);
            uncertainty=uncertainty1+uncertainty2;
            deltaxz=xmax2-xmax1;
            UAll=U1+U2;
            yline=0.7*max(yzp);
            
            Anglex{type,1}(ix)=RxA;
            Angley{type,1}(iy)=RyA;
            meanz{type,1}(ix,iy)=deltaxz;
            stdz{type,1}(ix,iy)=uncertainty;
            U_All{type,1}(ix,iy)=UAll;
            
        end
    end
    figure()
    imagesc( Angley{type,1}, Anglex{type,1},U_All{type,1})
    title(['Dataset' num2str(type)])
end
save('results/B_Best_Rotation_Angle.mat')

