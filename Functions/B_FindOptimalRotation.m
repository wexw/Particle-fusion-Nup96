set(0,'defaultfigurecolor','white')
nbins=150;


%     iter=0;
ix=0;
iy=0;
SuperParticle0=[];
SuperParticle1=[];
SuperParticle0=StraightenNPC';
SuperParticle1=SuperParticle0(:,1:3)';
Anglex=[];
Angley=[];
meanz=[];
stdz=[];
U_All=[];
for RxA=-3:0.2:3
    tic
    ix=ix+1;
    SuperParticleX=[rotx(RxA)*SuperParticle1];
    iy=0;
    for RyA=-3:0.2:3
        iy=iy+1;
        SuperParticle=[roty(RyA)*SuperParticleX]';
        sizeview=80;
        idx = find(SuperParticle(:,1) <  sizeview& ...
            SuperParticle(:,1) > -sizeview  & ...
            SuperParticle(:,2) <  sizeview & ...
            SuperParticle(:,2) > -sizeview  & ...
            SuperParticle(:,3) <  sizeview & ...
            SuperParticle(:,3) > -sizeview);
        SuperParticle =SuperParticle(idx,:);

        [xzp,yzp]=zHistW2(SuperParticle(:,3), nbins);
        [x1, y1, x2, y2]=split_bimodal(xzp,yzp);
        w1=calc_fwhm(x1,y1);
        w2=calc_fwhm(x2,y2);
        Anglex(ix)=RxA;
        Angley(iy)=RyA;

        U_All(ix,iy)=w1+w2;

    end
end
% figure()
% imagesc( Angley, Anglex,U_All)
% title(['Dataset' num2str(type)])
%     figure()
%     errorbar(Angle,meanz(type,:),stdz(type,:),'o','MarkerSize',10,...
%         'MarkerFaceColor',[1 0.38 0.01],'LineWidth',1,'Color',[1 0.38 0.01])
%     figure()
%     plot(Angle,stdz(type,:))
%     close all
%     deltatype(type)= xzp(2)-xzp(1)
