clc
clear
addpath('functions')
addpath('results')
load('F_AandE.mat')
figure()
xb=1:2:12;
xt=2:2:12;
% A_bm=AnglesAll(:,2);
A_bm=AnglesMean(:,2);
A_be=AnglesStd(:,2);
errorbar(1.1:1:6.1,A_bm,A_be,'o','MarkerSize',10,...
    'MarkerEdgeColor','red','LineWidth',1,'Color','red')

%title('Average rotation Angle of bottom rings ')
ylabel({'Inclination angle \phi (^o)'})
% for i=1:1:6
%     label=[];
% label=[num2str(roundn(A_bm(i,1),-1)) '\pm' num2str(roundn(A_be(i,1),-1))];
% text(i+0.2,A_bm(i,1),label);
% end
% set(gcf,'position',[200,200,800,600])

 hold on
% figure()
% A_tm=AnglesAll(:,1);
A_tm=AnglesMean(:,1);
A_te=AnglesStd(:,1);
errorbar(0.9:1:5.9,A_tm,A_te,'o','MarkerSize',10,...
    'MarkerEdgeColor','blue','LineWidth',1,'Color','blue')

% title('Average rotation Angle of top rings ')
xticks([1 2 3 4 5 6])
xlim([0 7])
ylim([-45 45])
% xticklabels({'dataset 1','dataset 2','dataset 3','dataset 4','dataset 5','combined dataset'})
xticklabels({'1','2','3','4','5','combined'})
xlabel('datasets')
% for i=1:1:6
%     label=[];
% label=[num2str(roundn(A_tm(i,1),-1)) '\pm' num2str(roundn(A_te(i,1),-1))];
% text(i+0.2,A_tm(i,1),label);
% end
set(gcf,'position',[200,200,800,600])
hold on
scatter(6,33,80,'red','o')
text(6.1,33,'CR','FontSize',24,'FontName','Arial');
hold on
scatter(6,38,80,'blue','o')
text(6.1,38,'NR','FontSize',24,'FontName','Arial');
% hold on
% scatter(6,35,880,'red','.')
% text(6.1,35,'bottom ring');
% hold on
% scatter(6,38,70,'blue','o')
% text(6.1,38,'top ring');
saveas(gcf,'Statistic_Angles2.fig')
set(gcf,'Units','Inches');
set(gca,'FontSize',24,'FontName','Arial');
% set(gcf, 'InvertHardCopy', 'off');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
filename = 'figures/Statistic_Angle.svg'; % 设定导出文件名
print(gcf,filename,'-dsvg','-r0')



figure()
set(gcf,'position',[200,200,800,600])
% Ex_bm=mv(xb,7);
% Ex_be=sv(xb,7);
Ex_bm=EsMean(:,2);
Ex_be=EsStd(:,2);
errorbar(1:6,Ex_bm,Ex_be,'o','MarkerSize',10,...
    'MarkerEdgeColor','red','LineWidth',1,'Color','red')
%title('Average Ellipticity of each blob')

hold on
set(gcf,'position',[200,200,800,600])
% Ex_tm=mv(xt,7);
% Ex_te=sv(xt,7);
Ex_tm=EsMean(:,1);
Ex_te=EsStd(:,1);
errorbar(0.85:1:5.85,Ex_tm,Ex_te,'o','MarkerSize',10,...
    'MarkerEdgeColor','blue','LineWidth',1,'Color','blue')%,'MarkerFaceColor','blue')
xlim([0 7])
ylim([0.5 1])
% title('Average rotation Angle of top rings ')
xticks([1 2 3 4 5 6])
% xticklabels({'dataset 1','dataset 2','dataset 3','dataset 4','dataset 5','combined dataset'})
xticklabels({'1','2','3','4','5','combined'})
xlabel('datasets')
ylabel('Ellipticity e')
% hold on
% scatter(5,0.9,880,'red','.')
% text(5.1,0.9,'cytoplasmic ring','FontSize',14);
% hold on
% scatter(5,0.93,70,'blue','o')
% text(5.1,0.93,'nucleoplasmic ring','FontSize',14);
% for i=1:1:6
%     label=[];
% label=[num2str(roundn(Ex_tm(i,1),-2)) '\pm' num2str(roundn(Ex_te(i,1),-2))];
% text(i+0.2,Ex_tm(i,1),label);
% end
set(gcf,'position',[200,200,800,600])
set(gca,'FontSize',24,'FontName','Arial');
%title('Average Ellipticity of each blob for top rings ')
set(gcf,'Units','Inches');
% set(gcf, 'InvertHardCopy', 'off');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
filename = 'figures\Statistic_E_Rings.svg'; % 设定导出文件名
print(gcf,filename,'-dsvg','-r0')
