%E_filter_outliers_by_GMM_and_density
% options=statset('MaxIter', 2000,'Display','Final')
clc
clear
addpath('functions')
set(0,'defaultfigurecolor','white')
load('D_StraightendRings.mat','NRs','CRs')
figure()
tiledlayout(4,3,'TileSpacing','Compact');
for type=1:6
NR_straighten=[];
CR_straighten=[];
NR_straighten=NRs{type,1};
CR_straighten=CRs{type,1};

[NR_pure_G,Classify_NR]=filter_outliers_GMM(NR_straighten');
hold on
title('NR of NPC' ,num2str(type))
[CR_pure_G,Classify_CR]=filter_outliers_GMM(CR_straighten');
hold on
title('CR of NPC', num2str(type))
NRs_pure_G{type,1}=NR_pure_G;
CRs_pure_G{type,1}=CR_pure_G;
Classify{type,1}=Classify_NR;
Classify{type,2}=Classify_CR;
end
index=0.5;  
figure()
tiledlayout(4,3,'TileSpacing','Compact');
for type=1:6
    for rlabel=1:2
        ring=[];
            if rlabel==1
            ring=NRs_pure_G{type,1};
        else
            ring=CRs_pure_G{type,1};
        end
       
        Ring_nooutlier_GD=[];
        Ring_outlier_GD=[];
        
        [Ring_nooutlier_GD,Ring_outlier_GD]=filter_outliers_Density(ring',index);
        Rings_NGD{type,rlabel}=Ring_nooutlier_GD;
        Rings_OGD{type,rlabel}=Ring_outlier_GD;
        
        data2cDraw=[];
        data2cDraw= Rings_NGD{type,rlabel};
      nexttile
        scatter3(data2cDraw(:,1),data2cDraw(:,2), data2cDraw(:,3),4,'b','.');
        hold on
        set(gcf,'color','w')
        set(gca,'color','w')
%         data2cDraw2=[];
%         data2cDraw2= Rings_OD{type,rlabel};
%         scatter3(data2cDraw2(:,1),data2cDraw2(:,2), data2cDraw2(:,3),8,'r','x');
    end
end

save('E_Rings_NGD.mat','NRs','CRs','Rings_NGD','NRs_pure_G','CRs_pure_G','Classify')
