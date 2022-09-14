%D_Split_ring_and_draw_xy_view;
clc
clear
addpath('functions')
set(0,'defaultfigurecolor','white')
load('C_Optimal_straighten_NPC.mat')
for type=1:6
    NPC=[];
    DensityNPC=[];
    LabelNPC=[];

    NPC=Optimal_Straightened_NPC{type,1}';
    positionNR=find(NPC(3,:)>=0);
    NR=NPC(:,positionNR);
    positionCR=find(NPC(3,:)<0);    CR=NPC(:,positionCR);
    NRs{type,1}=NR;
    CRs{type,1}=CR;
end
save('D_StraightendRings.mat','NRs','CRs')

for type=1:1:6
    for j=1:2
        data2c=[];
        if j==1
            data2c=NRs{type,1};
        else
            data2c=CRs{type,1};
        end
        
    
        data2c=data2c';
        
        size(data2c,1)

        
        beta=0
        cmax=10*size(data2c,1)/20000;
        renderprojection(data2c(:,1),data2c(:,2), data2c(:,3), 0,beta,[-80 80],[-80 80],1,1, 1,cmax);
        
        drawnow;
        axis off
        
        f = getframe(gcf);
        
        pos = get(gcf,'Position');
        
        set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
        filename =[ 'xyProjectionNPC',num2str(type),'ring',num2str(j), '.svg']; 
        print(gcf,filename,'-dsvg','-r0')
        
    end
end