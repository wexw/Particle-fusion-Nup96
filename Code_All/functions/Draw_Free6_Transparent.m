addpath('functions')
addpath('results')
load('EMEmitters.mat')
load('J_SymmetricAndFreeEmitters.mat','MS','FE')
load('E_Rings_NGD.mat')

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

for type=6


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
     

       
    hold on
    
    data2c=FE{type,j}';

    hold on
    scatter(data2c(:,1)+80,data2c(:,2)+80,480,color(10,:),'.','linewidth',2);
    
    
    axis on
    axis equal
    

    view(0,90)


    alpha(0.9)
    axis off

    pos = get(gcf,'Position');
    set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
    axis off
%         set(gcf,'color','none');
%     set(gca,'color','none');
%     set(gcf, 'InvertHardCopy', 'off');
%     filename=['Free6ring' num2str(j) '.png']
%     print(gcf,filename,'-dpng','-r1000')
set(gcf,'color','none'); %设置figure背景色为无
set(gca,'color','none'); %设置坐标轴背景色为无
print -dmeta   %将图像拷贝到剪切板上
    
    %            scatter3(55,55, 0,1800,color(10,:),'.','linewidth',2);
    %           scatter3(55,45, 0,140,color(i,:),'o','linewidth',2);
    %           Utxt =  ['Unconstrained'];
    %           text(60,55,Utxt,'FontSize',24)
    %           Stxt =  ['Symmetry constrained'];
    %           text(60,45,Stxt,'FontSize',24)
    %
    %     filename='SideViewNPC6.svg';

end
end