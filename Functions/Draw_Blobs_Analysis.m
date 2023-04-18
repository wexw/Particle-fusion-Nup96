
% Define labels for the subplots
labels = {'d','e','f','g'};

% Create a figure with 5 subplots
figure('Units', 'pixels', 'Position', [100, 100, 1200, 1200]);

% First row
ax1 = subplot(2, 2, 1);
iter=6;
type=6;
DrawZhistogramFor1Rec
hold on
text(-0.2,1.1, labels{1}, 'Units', 'normalized','FontSize',20,'FontName','Arial');

ax2 = subplot(2, 2, 2);
load('Deltaz.mat')
x1 = 1:1:6;
y1=meanz';
boxplot(y1, 'Colors', ['b'], 'Widths', 0.2,'Symbol', ['+b']);
xticks([1 2 3 4 5 6])
xlim([0 7])
xticklabels({'1','2','3','4','5','6'})
set(gca, 'xticklabel', xticklabels);
xlabel('datasets')
ylabel('\Deltaz (nm)')
text(-0.2,1.1, labels{2}, 'Units', 'normalized','FontSize',20,'FontName','Arial');

set(gca,'FontSize',16,'FontName','Arial');



ax3 = subplot(2, 2, 3);
Index=8;
y1=reshape(allParam_N(:,Index),[10, 6]);
y2=reshape(allParam_C(:,Index),[10, 6]);
DrawBoxFigures

ylabel({'ellipticity'})
text(-0.2,1.1, labels{3}, 'Units', 'normalized','FontSize',20,'FontName','Arial');

% Second row
ax4 = subplot(2, 2, 4);
Index=6;
y1=reshape(allParam_N(:,Index),[10, 6]);
y2=reshape(allParam_C(:,Index),[10, 6]);
DrawBoxFigures

ylabel({['inclination angle \phi (^o)']})
text(-0.2,1.1, labels{4}, 'Units', 'normalized','FontSize',20,'FontName','Arial');
hold on
% Define the positions and sizes of the rectangles
rect1_pos = [10, 26, 0.5, 1];
rect2_pos = [10, 23, 0.5, 1];
% Create the first rectangle (blue) with label "NR"
rectangle('Position', rect1_pos, 'EdgeColor', 'b')
text(rect1_pos(1)+rect1_pos(3)*2.5, rect1_pos(2)+rect1_pos(4)/2, 'NR', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',16)

% Create the second rectangle (red) with label "CR"
rectangle('Position', rect2_pos, 'EdgeColor', 'r')
text(rect2_pos(1)+rect2_pos(3)*2.5, rect2_pos(2)+rect2_pos(4)/2, 'CR', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',16)
set(gcf,'Units','Inches');

set(gcf, 'InvertHardCopy', 'off');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
filename = 'AnalyzePureRings.svg'; 
print(gcf,filename,'-dsvg','-r0')




