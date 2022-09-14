%J_Compare_Calculate_Mean_Symmetric_and_Most_Close_Free_Emitters
clc
clear
addpath('functions')
% load('H_Fitting_model8_100_randomInandoutplaneAngle_z=2xAllSaved2.mat')
load('H_Fitting_model8_100_randomInandoutplaneAngle_z=3xAllSaved.mat')
color=[0.77, 0.18, 0.78
    0.21, 0.33, 0.64
    0.88, 0.17, 0.56
    0.20, 0.69, 0.28
    0.26, 0.15, 0.47
    0.83, 0.27, 0.44
    0.87, 0.85, 0.42
    0.85, 0.51, 0.87
    0.99, 0.62, 0.76
    0.52, 0.43, 0.87
    0.00, 0.68, 0.92
    0.26, 0.45, 0.77
    0.98, 0.75, 0.00
    0.72, 0.81, 0.76
    0.77, 0.18, 0.78
    0.28, 0.39, 0.44
    0.22, 0.26, 0.24
    0.64, 0.52, 0.64
    0.87, 0.73, 0.78
    0.94, 0.89, 0.85
    0.85, 0.84, 0.86];
%Search for the symmetric model which is most close to the mean symmertic
%model
for type=1:6
    for j=1:2
        if j==2
            for iter=1:100
                CRs_SP_M(iter,:)=CRs_SymmetricParameters{type,iter};
            end
            meanCRs_SP=mean(CRs_SP_M)
            for iter=1:100
                Delta(iter,:)=abs(CRs_SymmetricParameters{type,iter}- meanCRs_SP);
            end
        else
            for iter=1:100
                NRs_SP_M(iter,:)=NRs_SymmetricParameters{type,iter};
            end
            meanNRs_SP=mean(NRs_SP_M)
            for iter=1:100
                Delta(iter,:)=abs(NRs_SymmetricParameters{type,iter}- meanNRs_SP);
            end
        end
        
        DeltaSum=sum(Delta');
        [mindelta(type,j),minp(type,j)]=min(DeltaSum);
    end
    meanNRs_SPA{type,1}=meanNRs_SP;
    meanCRs_SPA{type,1}=meanCRs_SP;
end
%Draw Figures x-y view for single ring
for type=1:6


for j=1:2
    figure()
    if j==1
%         TV{i,j}=NRs_SymmetricEmitters{i,minp(i,j)};
 MS{type,j}= GenerateBindingSites_WithGlobalPhase(meanNRs_SPA{type,1});
    else   
%         TV{i,j}=CRs_SymmetricEmitters{i,minp(i,j)};
 MS{type,j}=  GenerateBindingSites_WithGlobalPhase(meanCRs_SPA{type,1});
    end
    
    
    data2c=MS{type,j}';
    
    scatter3(data2c(:,2),data2c(:,1), data2c(:,3),140,color(6,:),'o','linewidth',2);
    hold on
    
    
    if j==1
        FE{type,j}=NRs_FreeGMM{type,minp(type,j)}.mu';
        filename = ['RegisteredEmittersNR' num2str(type) '.svg']; % 设定导出文件名
    end
    if j==2
        FE{type,j}=CRs_FreeGMM{type,minp(type,j)}.mu';
        filename = ['RegisteredEmittersCR' num2str(type) '.svg']; % 设定导出文件名
    end
    
    hold on
    
    data2c=FE{type,j}';

    hold on
    scatter3(data2c(:,2),data2c(:,1), data2c(:,3),1800,color(10,:),'.','linewidth',2);
    
    
    axis on
    axis equal
    
    xlim([-60 60])
    ylim([-60 60])
    view(0,90)

    set(gcf,'position',[200,200,800,600])
    set(gca,'FontSize',24);
    set(gcf,'Units','Inches');
    alpha(0.9)
    axis off
    set(gcf, 'InvertHardCopy', 'off');
    pos = get(gcf,'Position');
    set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
    axis off
    print(gcf,filename,'-dsvg','-r1000')
    
    %            scatter3(55,55, 0,1800,color(10,:),'.','linewidth',2);
    %           scatter3(55,45, 0,140,color(i,:),'o','linewidth',2);
    %           Utxt =  ['Unconstrained'];
    %           text(60,55,Utxt,'FontSize',24)
    %           Stxt =  ['Symmetry constrained'];
    %           text(60,45,Stxt,'FontSize',24)
    %
    %     filename='SideViewNPC6.svg';

end


figure()
data2cF=[FE{type,1},FE{type,2}]';
hold on
data2cS=[MS{type,1},MS{type,2}]';
hold on
scatter3(data2cF(:,2),data2cF(:,1), data2cF(:,3),1800,color(10,:),'.','linewidth',2);
hold on
scatter3(data2cS(:,2),data2cS(:,1), data2cS(:,3),140,color(6,:),'o','linewidth',2);

set(gcf,'position',[200,200,800,600])
set(gca,'FontSize',24);
set(gcf,'Units','Inches');
alpha(0.9)
axis off
set(gcf, 'InvertHardCopy', 'off');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
filename=['SideViewEmittersCompare' num2str(type) '.svg']
view(0,15)
%     if j==1
%         filename = 'RegisteredCompereEmittersNR6.svg'; % 设定导出文件名
%     else
%         filename = 'RegisteredCompareEmittersCR6.svg'; % 设定导出文件名
%     end

% figure()
% 
% scatter3(-50,0,45,1800,color(10,:),'.','linewidth',2);
% hold on
% scatter3(-50,0,55,140,color(i,:),'o','linewidth',2);
% Utxt =  ['Unconstrained'];
% hold on 
% text(-80,0,45,Utxt,'FontSize',24)
% Stxt =  ['Symmetry constrained'];
% hold on
% text(-50,65,Stxt,'FontSize',24)
axis off
print(gcf,filename,'-dsvg','-r1000')

end
for type=1:6
SM=[];
FM=[];
SM1=[];
FM1=[];

SM=[MS{type,1},MS{type,2}]'; 
FM=[FE{type,1},FE{type,2}]';

ring=SM';
TE0=ring(:,find(ring(3,:)>mean(ring(3,:))));
BE0=ring(:,find(ring(3,:)<mean(ring(3,:))));

ring=FM';
TC0=ring(:,find(ring(3,:)>mean(ring(3,:))));
BC0=ring(:,find(ring(3,:)<mean(ring(3,:))));

[TTE,TBE]=sort_ring(TE0);

[BTE,BBE]=sort_ring(BE0);

[TTC,TBC]=sort_ring(TC0);

[BTC,BBC]=sort_ring(BC0);

SM1=[TTE,TBE,BTE,BBE];
FM1=[TTC,TBC,BTC,BBC];

figure()
scatter3(FM(:,1),FM(:,2),FM(:,3),1800,color(10,:),'.','linewidth',2)
hold on
scatter3(SM(:,1),SM(:,2),SM(:,3),140,color(6,:),'o','linewidth',2)
hold on
%Find the corresponding sites of Em and CM
for i=1:1:32
for j=1:1:32
    xyd(i,j)=norm(SM(i,:)-FM(j,:));
end
[a,b]=find(xyd(i,:)==min(xyd(i,:)));
pb(i)=b;
end
SM(:,4)=pb;
AEM=sortrows(SM,4);
EMC=AEM(:,1:3);
for i=1:32
zd(i)=norm(AEM(i,3)-FM(i,3));
xydd(i)=norm(AEM(i,1:2)-FM(i,1:2));
dd(i)=norm(AEM(i,1:3)-FM(i,1:3));
end

topdd=dd(1:16);
botdd=dd(17:32);
Distance(type,:)=[mean(zd),std(zd),mean(xydd),std(xydd),mean(topdd),std(topdd),mean(botdd),std(botdd)];
filename = ['CompareSAndFModelswithDistance' num2str(type) '.svg']; % 设定导出文件名
title(['fit Rings of Dataset ' num2str(type) 'NR\Delta=' num2str(mean(topdd)) '\pm' num2str(std(topdd)) sprintf('\n') 'CR\Delta=' num2str(mean(botdd)) '\pm' num2str(std(botdd)) ])
set(gcf,'position',[200,200,800,600])
set(gca,'FontSize',24);
set(gcf,'Units','Inches');
alpha(0.9)
axis off
set(gcf, 'InvertHardCopy', 'off');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])

view(0,15)
axis off
print(gcf,filename,'-dsvg','-r1000')
end

save('J_SymmetricAndFreeEmitters.mat','MS','FE','Distance')

