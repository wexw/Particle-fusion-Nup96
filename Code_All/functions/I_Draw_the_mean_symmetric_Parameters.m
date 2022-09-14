%I_Draw_the_mean_symmetric_Parameters
% clc
% clear
% addpath('functions')
% addpath('results')
% %
%  load('H_Fitting_model8_100_randomoutplaneAngle_z=2xAllSaved.mat')
iterationtimes=size(NRs_FreeGMM,2)
set(0,'defaultfigurecolor','white')
E_R=54;
E_d=11.86;
E_phi_N=-32.6;%-27;Rr
E_phi_C=32.1;%27.3
E_theta=(77.66+75.85)/2;
for type=1:6
    for iter=1:iterationtimes
        i=type;
        topring=NRs_SymmetricEmitters{type,iter};
        [rd_Top(type,iter),Rr_Top(i,iter),Theta_Top(i,iter),Phi_Top(i,iter),c1x_Top(i,iter),c1y_Top(i,iter),c1z_Top(i,iter)] = MeasureSymmetricParameters(topring);
        botring=CRs_SymmetricEmitters{i,iter};
        [rd_Bottom(i,iter),  Rr_Bottom(i,iter),Theta_Bottom(i,iter),Phi_Bottom(i,iter),c1x_Bottom(i,iter),c1y_Bottom(i,iter),c1z_Bottom(i,iter)] = MeasureSymmetricParameters(botring);
           SymmericParameters_NR{type,1}(iter,:)=[Rr_Top(type,iter),rd_Top(i,iter),Theta_Top(i,iter),Phi_Top(i,iter),c1x_Top(i,iter),c1y_Top(i,iter),c1z_Top(i,iter)];
        SymmericParameters_CR{type,1}(iter,:)=[Rr_Bottom(i,iter),rd_Bottom(i,iter),Theta_Bottom(i,iter),Phi_Bottom(i,iter),c1x_Bottom(i,iter),c1y_Bottom(i,iter),c1z_Bottom(i,iter)];
        newNR=[];
        newCR=[];
        newNR=GenerateBindingSites_WithGlobalPhase4(SymmericParameters_NR{type,1}(iter,:));
        newCR=GenerateBindingSites_WithGlobalPhase4(SymmericParameters_CR{type,1}(iter,:));
         AD1=EmittersDistAverage([newNR';newCR'],[topring';botring']);
     
    end
end

figure()
xb=1.1:1:6.1;
xt=0.9:1:5.9;
yb=mean(Rr_Bottom');
stdyb=std(Rr_Bottom');

yt=mean(Rr_Top');
stdyt=std(Rr_Top');

%
% scatter(xb,yb,180,'blue','x','LineWidth',2)
% hold on

mean(yt)
mean(yb)
errorbar(xb,yb,stdyb,'o','MarkerSize',10,...
    'MarkerEdgeColor','red','LineWidth',1,'color','red')

hold on

errorbar(xt,yt,stdyt,'o','MarkerSize',10,...
    'MarkerEdgeColor','blue','LineWidth',1,'color','blue')
hold on
line([0,7],[E_R,E_R],'color','k','linestyle','--','LineWidth',1)

xlim([0 7])

%title('Radius of rings')
set(gca,'FontSize',24,'FontName','Arial');
xticks([1 2 3 4 5 6 7])
% xticklabels({'dataset 1','dataset 2','dataset 3','dataset 4','dataset 5','combined dataset'})
xticklabels({'1','2','3','4','5','combined'})
xlabel('datasets')
ylabel('radius of the ring R (nm)')



% %ylim([0 60])
set(gcf,'position',[200,200,800,600])

set(gca,'FontSize',24,'FontName','Arial');
set(gcf,'Units','Inches');
% set(gcf, 'InvertHardCopy', 'off');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
filename ='figures/RadiusOfRings.svg'; % 设定导出文件名
 print(gcf,filename,'-dsvg','-r0')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
% xb=1:1:6;
yb=mean(rd_Bottom'.*2);
stdyb=std(rd_Bottom'.*2);
yt=mean(rd_Top'.*2);
stdyt=std(rd_Top'.*2);
mean(yt)
mean(yb)
y=mean(mean([rd_Top'.*2,rd_Bottom'.*2]))
errorbar(xb,yb,stdyb,'o','MarkerSize',10,...
    'MarkerEdgeColor','red','LineWidth',1,'color','red')

hold on

errorbar(xt,yt,stdyt,'o','MarkerSize',10,...
    'MarkerEdgeColor','blue','LineWidth',1,'color','blue')

hold on
line([0,7],[E_d,E_d],'color','k','linestyle','--','LineWidth',1)

%title('Radius of rings')
set(gca,'FontSize',24,'FontName','Arial');
xticks([1 2 3 4 5 6 7])
% xticklabels({'dataset 1','dataset 2','dataset 3','dataset 4','dataset 5','combined dataset'})
xticklabels({'1','2','3','4','5','combined'})
xlabel('datasets')
ylabel('distance in the dimer d (nm)')
hold on
scatter(6,16,70,'red','o')
text(6.2,16,'CR','FontSize',24,'FontName','Arial');
hold on
scatter(6,17,70,'blue','o','LineWidth',1)
text(6.2,17,'NR','FontSize',24,'FontName','Arial');
hold on
line([5.7,6.1],[15,15],'color','k','linestyle','--','LineWidth',1)
text(6.2,15,'EM','FontSize',24,'FontName','Arial');
xlim([0 7])
ylim([6 18])
set(gcf,'position',[200,200,800,600])
set(gca,'FontSize',24,'FontName','Arial');
set(gcf,'Units','Inches');

% set(gcf, 'InvertHardCopy', 'off');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
filename ='figures/DistanceInTheDimer.svg'; % 设定导出文件名
 print(gcf,filename,'-dsvg','-r0')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
xb=1:1:6;
yb=mean(Phi_Bottom');
stdyb=std(Phi_Bottom');
yt=mean(Phi_Top');
stdyt=std(Phi_Top');
% yb=mean(Phi_Bottom_new');
% stdyb=std(Phi_Bottom_new');
% yt=mean(Phi_Top_new');
% stdyt=std(Phi_Top_new');

mean(yt)
mean(yb)

errorbar(xb,yb,stdyb,'o','MarkerSize',10,...
    'MarkerEdgeColor','red','LineWidth',1,'color','red')

hold on

errorbar(xt,yt,stdyt,'o','MarkerSize',10,...
    'MarkerEdgeColor','blue','LineWidth',1,'color','blue')

hold on
line([0,7],[E_phi_C,E_phi_C],'color','r','linestyle','--','LineWidth',1)
hold on
line([0,7],[E_phi_N,E_phi_N],'color','b','linestyle','--','LineWidth',1)

set(gca,'FontSize',24,'FontName','Arial');
xticks([1 2 3 4 5 6 7])
xticklabels({'1','2','3','4','5','combined'})
xlabel('datasets')
ylabel('in plane angle \phi (^°)')
% scatter(7,8,20,'red','filled')
% text(6.1,45,'bottom ring');
% hold on
% scatter(7,10,20,'blue','filled')
% text(6.1,48,'top ring');

xlim([0 7])
% ylim([0 14])
set(gcf,'position',[200,200,800,600])
set(gcf,'position',[200,200,800,600])
set(gca,'FontSize',24,'FontName','Arial');
set(gcf,'Units','Inches');

set(gcf, 'InvertHardCopy', 'off');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
filename ='figures/InPlaneAngle.svg'; % 设定导出文件名
 print(gcf,filename,'-dsvg','-r0')





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
% xb=1:1:6;
yb=mean(Theta_Bottom');

stdyb=std(Theta_Bottom');
yt=mean(Theta_Top');
stdyt=std(Theta_Top');

mean(yt)
mean(yb)
errorbar(xb,yb,stdyb,'o','MarkerSize',10,...
    'MarkerEdgeColor','red','LineWidth',1,'color','red')

hold on

errorbar(xt,yt,stdyt,'o','MarkerSize',10,...
    'MarkerEdgeColor','blue','LineWidth',1,'color','blue')

hold on
line([0,7],[E_theta,E_theta],'color','k','linestyle','--','LineWidth',1)


set(gca,'FontSize',24,'FontName','Arial');
xticks([1 2 3 4 5 6 7])
% xticklabels({'dataset 1','dataset 2','dataset 3','dataset 4','dataset 5','combined dataset'})
xticklabels({'1','2','3','4','5','combined'})
% xticklabels(xticks([1 2 3 4 5 6]){'dataset 1','dataset 2','dataset 3','dataset 4','dataset 5','combined dataset'})

xlabel('datasets')
ylabel('out of plane angle \theta (^°)')

set(gcf,'position',[200,200,800,600])
set(gca,'FontSize',24,'FontName','Arial');
xlim([0 7])

set(gcf,'Units','Inches');
% set(gcf, 'InvertHardCopy', 'off');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
filename ='figures/OutofPlaneAngle.svg'; % 设定导出文件名
print(gcf,filename,'-dsvg','-r0')
