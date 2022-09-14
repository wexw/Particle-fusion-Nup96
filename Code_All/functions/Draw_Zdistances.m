load('results/M_PureRing_Z_histogram.mat','meanz1','stdz1')

distance2=c1z_Top-c1z_Bottom;
xb=0.9:1:5.9;
yb=meanz1;
stdyb=stdz1;
Dse=48.8;
DEM=57.2
figure()
errorbar(xb,yb,stdyb,'o','MarkerSize',10,'LineWidth',1,'Color',[1 0.38 0.01])

hold on
xb=1.1:1:6.1
yb=mean(distance2');
stdyb=std(distance2');

errorbar(xb,yb,stdyb,'o','MarkerSize',10,'LineWidth',1,'Color','b')
hold on
line([0,7],[DEM,DEM],'color','k','linestyle','--','LineWidth',1)

hold on
xlim([0 7])
ylim([47 60])
hold on
scatter(3,56,70,[1 0.38 0.01],'o')
text(3.2,56,'z histogram','FontSize',24,'FontName','Arial');
hold on
scatter(3,55,70,'blue','o','LineWidth',1)
text(3.2,55,'symmetric emitters','FontSize',24,'FontName','Arial');
hold on
line([2.5,3],[54,54],'color','k','linestyle','--','LineWidth',1)
text(3.2,54,'EM model','FontSize',24,'FontName','Arial');
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



set(gcf,'position',[200,200,800,600])
set(gcf,'Units','Inches');
set(gca,'FontSize',24,'FontName','Arial');
% set(gcf, 'InvertHardCopy', 'off');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
