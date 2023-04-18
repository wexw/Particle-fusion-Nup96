set (0,'defaultfigurecolor','w')
% SEN = GenerateSymmetricEmitters(Param_NS)';
% SEC = GenerateSymmetricEmitters(Param_CS)';%reverse xy to measure parameters
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

labels = {'a','b','c','d'};

x1 = 1.2:1:6.2;
x2=0.8:1:5.8;

%%%%%%%%%%%%%%%%%%%%Draw Symmetric Parameters
figure
nexttile
Index=1;
y1=reshape(allParam_N(:,Index),[10, 6]);
y2=reshape(allParam_C(:,Index),[10, 6]);
DrawBoxFigures
hold on
mR=mean(Param_NS(1,1)+Param_CS(1,1))/2;
line([0,13],[mR,mR],'color','k','linestyle','--','LineWidth',1)
hold on
text(-0.2,1.1, labels{1}, 'Units', 'normalized','FontSize',20,'FontName','Arial');

ylabel('radius of the ring R (nm)')


nexttile
%
Index=2;
y1=reshape(allParam_N(:,Index).*2,[10, 6]);
y2=reshape(allParam_C(:,Index).*2,[10, 6]);
DrawBoxFigures
hold on
md=mean(Param_NS(1,2)+Param_CS(1,2));
line([0,13],[md,md],'color','k','linestyle','--','LineWidth',1)
ylabel('distance in the dimer d (nm)')
hold on
text(-0.2,1.1, labels{2}, 'Units', 'normalized','FontSize',20,'FontName','Arial');

hold on
% Define the positions and sizes of the rectangles
rect1_pos = [11, 32, 0.5, 1];
rect2_pos = [11, 34, 0.5, 1];
% Create the first rectangle (blue) with label "NR"
rectangle('Position', rect1_pos, 'EdgeColor', 'b')
text(rect1_pos(1)+rect1_pos(3)*2, rect1_pos(2)+rect1_pos(4)/2, 'NR', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',16)

% Create the second rectangle (red) with label "CR"
rectangle('Position', rect2_pos, 'EdgeColor', 'r')
text(rect2_pos(1)+rect2_pos(3)*2, rect2_pos(2)+rect2_pos(4)/2, 'CR', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',16)

nexttile
Index=3;
y1=reshape(allParam_N(:,Index),[10, 6]);
y2=reshape(allParam_C(:,Index),[10, 6]);
DrawBoxFigures
hold on
text(-0.2,1.1, labels{3}, 'Units', 'normalized','FontSize',20,'FontName','Arial');

ylabel('out of plane angle \theta (^°)')
hold on

line([0,13],[Param_NS(1,Index),Param_NS(1,Index)],'color','b','linestyle','--','LineWidth',1)
hold on
line([0,13],[Param_CS(1,Index),Param_CS(1,Index)],'color','r','linestyle','--','LineWidth',1)

nexttile
Index=4;
y1=reshape(allParam_N(:,Index),[10, 6]);
y2=reshape(allParam_C(:,Index),[10, 6]);
hold on
line([0,13],[Param_CS(1,Index),Param_CS(1,Index)],'color','r','linestyle','--','LineWidth',1)
hold on
line([0,13],[Param_NS(1,Index),Param_NS(1,Index)],'color','b','linestyle','--','LineWidth',1)

hold on
DrawBoxFigures
hold on
text(-0.2,1.1, labels{4}, 'Units', 'normalized','FontSize',20,'FontName','Arial');

ylabel('in plane angle \phi (^°)')

set(gcf,'position',[200,200,1200,1200])

set(gcf,'Units','Inches');

set(gcf, 'InvertHardCopy', 'off');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
filename = 'SPParameters.svg'; % 设定导出文件名
print(gcf,filename,'-dsvg','-r0')



