color=[0,0,1;0,1,0;1,0,0;
    1,0,1;1,1,0;1,0.5,0.25;
    1,0,0.5; 0.5,0.5,0.5;0,0,0;
    ];
data2cDraw=NR_pure_G';
figure()
nexttile
for pk=1:9
    hold on
    V_d=NR_pure_G;
    data2cDraw=[];
    data2cDraw=V_d(:,find(Classify_NR(:,1)==pk))';

    set(gcf,'color','w')
    set(gca,'color','w')
    scatter3(data2cDraw(:,1),data2cDraw(:,2), data2cDraw(:,3),4,color(pk,:),'.');
end