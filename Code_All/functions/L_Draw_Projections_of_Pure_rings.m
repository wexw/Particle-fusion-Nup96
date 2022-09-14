%L_Draw_Projections_of_Pure_rings
clc
clear
addpath('functions')
addpath('results')
load('E_Rings_NGD.mat')
for type=1:1:6
    for j=1:2
        data2c=[];
        data2c=Rings_NGD{type,j};
        data2c=data2c;
        
        size(data2c,1)
        % colordef white
        % set(0,'defaultfigurecolor','white')
        
        
        beta=0
        cmax=10*size(data2c,1)/20000;
        renderprojection(data2c(:,1),data2c(:,2), data2c(:,3), 0,beta,[-80 80],[-80 80],1,1, 1,cmax);
        
        drawnow;
        axis off
        
        f = getframe(gcf);
        
        pos = get(gcf,'Position');
        
        set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
        filename =[ 'figures\xyProjectionPureRing',num2str(type),'ring',num2str(j), '.svg']; % 设定导出文件名
        print(gcf,filename,'-dsvg','-r0')
    end
end

for type=1:1:6
    
    data2c=[];
    data2c=[Rings_NGD{type,1};Rings_NGD{type,2}];
    data2c=data2c;
    
    size(data2c,1)
    % colordef white
    % set(0,'defaultfigurecolor','white')
    
    
    beta=90
    cmax=10*size(data2c,1)/20000;
    renderprojection(data2c(:,1),data2c(:,2), data2c(:,3), 0,beta,[-80 80],[-80 80],1,1, 1,cmax);
    
    drawnow;
    axis off
    
    f = getframe(gcf);
    
    pos = get(gcf,'Position');
    
    set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
    filename =[ 'figures\SideProjectionPureRing',num2str(type), '.svg']; % 设定导出文件名
    print(gcf,filename,'-dsvg','-r0')
end
