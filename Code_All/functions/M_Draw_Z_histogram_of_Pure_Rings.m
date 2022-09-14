%M_Draw_Z_histogram_of_Pure_Rings
clc
clear
addpath('functions')
addpath('results')
load('E_Rings_NGD.mat')
nbins=150;
for type=6
    data2c=[];
    data2c=[Rings_NGD{type,1};Rings_NGD{type,2}];
    data2c=data2c;
    
%    sizeview=80;
%     idx = find(SuperParticle(:,1) <  sizeview& ...
%         SuperParticle(:,1) > -sizeview  & ...
%         SuperParticle(:,2) <  sizeview & ...
%         SuperParticle(:,2) > -sizeview  & ...
%         SuperParticle(:,3) <  sizeview & ...
%         SuperParticle(:,3) > -sizeview);
%     SuperParticle =SuperParticle(idx,:);
%     cmax=10*size(data2c,1)/20000;
%     beta=90;
%     renderprojection(data2c(:,1),data2c(:,2), data2c(:,3), 0,beta,[-80 80],[-80 80],1,1, 1,cmax);
%      drawnow;
%     f = getframe(gcf);
%     set(gcf,'Units','Inches');
%     set(gcf, 'InvertHardCopy', 'off');
%     pos = get(gcf,'Position');
%     set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
%     filename = ['SideViewProjectionOfStraightenNPC' num2str(type) '.svg']; % 设定导出文件名
%     print(gcf,filename,'-dsvg','-r0')
    SuperParticle=data2c;
    
    % colormap('winter');
    [xzp,yzp]=zHist(SuperParticle(:,3), nbins);
    set(gcf,'color','w')
    set(gca,'color','w')
    [minx,X0place]=min(abs(xzp));
    [max1,p1]=max(yzp(1,1:X0place));
    xmax1=xzp(1,p1);
    %     i
    %     Num_loc(i)=size(SuperParticle,1)
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
    
    set(gcf,'position',[200,200,800,600])
    %annotation('doublearrow',[xmax1/200+0.55,xmax2/200+0.55],[0.7,0.7])
    ylength=0.06*yline;
    line([xmax1,xmax2],[yline,yline],'color','k','linestyle','--','LineWidth',1)
    txt = [num2str(round(deltaxz,1)) '\pm' num2str(round(uncertainty,1)) ' nm'];
    
    text(33,yline,txt,'FontSize',20,'FontName','Arial','Color','k')
    line([xmax1,xmax1],[yline-ylength,yline+ylength],'color','k','linestyle','-','LineWidth',1)
    line([xmax2,xmax2],[yline-ylength,yline+ylength],'color','k','linestyle','-','LineWidth',1)
    
    if type==6
        lgd=legend('z histogram','Gaussian fit','FontName','Arial');
        lgd.TextColor='black';
        % ylim[]
    end
    
%     set(gcf,'Units','Inches');
%     set(gca,'FontSize',24,'FontName','Arial');
% %     set(gca,'FontSize',24,'FontName','Arial','XColor','k','YColor','k');
%     % set(gcf, 'InvertHardCopy', 'off');
% %     pos = get(gcf,'Position');
%     set(gcf,'position',[200,200,800,600])
%     set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
set(gcf,'position',[200,200,800,600])
set(gcf,'Units','Inches');
set(gca,'FontSize',24,'FontName','Arial');
% set(gcf, 'InvertHardCopy', 'off');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
filename = ['figures/ZHistogramOfReconstructionPure' num2str(type) '.svg']; % 设定导出文件名
    meanz1(type,1)=deltaxz;
    stdz1(type,1)=uncertainty;
    Optimal_Straightened_NPC{type,1}=data2c;
     print(gcf,filename,'-dsvg','-r0')
end
xb=1:6;
yb=meanz1;
stdyb=stdz1;
figure()
errorbar(xb,yb,stdyb,'o','MarkerSize',10,'LineWidth',1,'Color',[1 0.38 0.01])

hold on

xticks([1 2 3 4 5 6 7])
% xticklabels({'dataset 1','dataset 2','dataset 3','dataset 4','dataset 5','combined dataset'})
xticklabels({'1','2','3','4','5','combined'})
xlabel('datasets')
ylabel('distance between the rings (nm)')
% scatter(6,45,20,'red','filled')
% text(6.1,45,'bottom ring');
% hold on
% scatter(6,48,20,'blue','filled')
% text(6.1,48,'top ring');


xlim([0 7])
ylim([47 60])
set(gcf,'position',[200,200,800,600])
set(gcf,'Units','Inches');
set(gca,'FontSize',24,'FontName','Arial');
% set(gcf, 'InvertHardCopy', 'off');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
filename = 'figures/DistanceBetweenRings.svg'; % 设定导出文件名
print(gcf,filename,'-dsvg','-r0')
save('results/M_PureRing_Z_histogram.mat','meanz1','stdz1')
