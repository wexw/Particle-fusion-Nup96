clc
clear
addpath('functions')
set(0,'defaultfigurecolor','white')
nbins=150;
% load('A_StraightenNPC_Inertia.mat')
load('results/B1_Best_Rotation_Angle.mat')
nbins=150;
%B1_Search_forBestAngle2D

for type=1:6
    tic
    ix=0;
    iy=0;
    SuperParticle0=StraightenNPC{type,1}';
    SuperParticle1=SuperParticle0(:,1:3)';
    figure()
    imagesc(Anglex{type,1},Angley{type,1},U_All{type,1})
    title(['Dataset' num2str(type)])
    [min1,minp1]=min(U_All{type,1});%#row of every colums
    [min2,minp2]=min(U_All{type,1}');%#colum of every rpw
    rowsx=[];
    rowsx=unique(minp1)
    rowsy=[];
    rowsy=unique(minp2)
ky=[];
ky=1;%size(rowsy,2)-6;
kx=[];
kx=1;%size(rowsx,2)-6;
minkx=[];
minkx=(mink(Anglex{type,1}(1,rowsx),kx));
maxkx=[];
maxkx=maxk(Anglex{type,1}(1,rowsx),kx);
minky=[];
minky=(mink(Angley{type,1}(1,rowsy),ky));
maxky=[];
maxky=maxk(Angley{type,1}(1,rowsy),ky);
max(minkx):0.1:min(maxkx)
max(minky):0.1:min(maxky)
    for anglex2=max(minkx):0.1:min(maxkx)
        ix=ix+1;
        iy=0;
        SuperParticleX=[rotx(anglex2)*SuperParticle1];
        for angley2=max(minky):0.1:min(maxky)%min(Angley{type,1}(1,rowsy)):0.1:max(Anglex{type,1}(1,rowsy))
            iy=iy+1;
            SuperParticle=[roty(angley2)*SuperParticleX]';
               sizeview=80;
            idx = find(SuperParticle(:,1) <  sizeview& ...
                SuperParticle(:,1) > -sizeview  & ...
                SuperParticle(:,2) <  sizeview & ...
                SuperParticle(:,2) > -sizeview  & ...
                SuperParticle(:,3) <  sizeview & ...
                SuperParticle(:,3) > -sizeview);
            SuperParticle =SuperParticle(idx,:);

            [xzp,yzp]=zHistW(SuperParticle(:,3), nbins);

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
            Anglex2{type,1}(ix)=anglex2;
            Angley2{type,1}(iy)=angley2;
            meanz2{type,1}(ix,iy)=deltaxz;
            stdz2{type,1}(ix,iy)=uncertainty;
            U_All2{type,1}(ix,iy)=UAll;
        end
    end
    save("B2.mat")
    toc
end


for type1=1:6
      figure()
    imagesc( Anglex2{type1,1}, Angley2{type1,1},U_All2{type1,1}')
    xlabel('Rotation Angle along x axis(°)')
        ylabel('Rotation Angle along y axis(°)')
    title(['Dataset' num2str(type1)])
 end

