
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
s1=80
s2=900
num=0
for type=1:1:6
for iter=1:1:10
    num=num+1
SN=data2save{type,iter}.SymmetricEmitter_N';
SC=data2save{type,iter}.SymmetricEmitter_C';
FN=data2save{type,iter}.Fitted_GMM_N.mu;
FC=data2save{type,iter}.Fitted_GMM_C.mu;
SM=[SN;SC];
FM=[FN;FC];

ring=SM';
TE0=ring(:,find(ring(3,:)>mean(ring(3,:))));
BE0=ring(:,find(ring(3,:)<mean(ring(3,:))));

ring=FM';
TC0=ring(:,find(ring(3,:)>mean(ring(3,:))));
BC0=ring(:,find(ring(3,:)<mean(ring(3,:))));

[TTE,TBE]=sort_ring(TE0);

[BTE,BBE]=sort_ring(BE0);

[TTC,TBC]=sort_ring(TC0);

[BTC,BBC]=sort_ring(BC0);

SM1=[TTE,TBE,BTE,BBE];
FM1=[TTC,TBC,BTC,BBC];
% 
% figure()
% scatter3(FM(:,1),FM(:,2),FM(:,3),1800,color(10,:),'.','linewidth',2)
% hold on
% scatter3(SM(:,1),SM(:,2),SM(:,3),140,color(6,:),'o','linewidth',2)
% hold on
%Find the corresponding sites of Em and CM
for i=1:1:32
    for j=1:1:32
        xyd(i,j)=norm(SM(i,:)-FM(j,:));
    end
    [a,b]=find(xyd(i,:)==min(xyd(i,:)));
    pb(i)=b;
end
SM(:,4)=pb;
AEM=sortrows(SM,4);
EMC=AEM(:,1:3);
for i=1:32
    zd(i)=norm(AEM(i,3)-FM(i,3));
    xydd(i)=norm(AEM(i,1:2)-FM(i,1:2));
    dd(i)=norm(AEM(i,1:3)-FM(i,1:3));
end

topdd=dd(1:16);
botdd=dd(17:32);
dis2(num,:)=[mean(zd),std(zd),mean(xydd),std(xydd),mean(topdd),std(topdd),mean(botdd),std(botdd)];
end
end
[mind,mindp]=min(dis2(:,5)+dis2(:,7));
types=6;%mod(mindp,10);
iters=6;%mindp-10*types;
dis2(nums,:)
nums=(types-1)*10+iters;
SN=data2save{types,iters}.SymmetricEmitter_N';
SC=data2save{types,iters}.SymmetricEmitter_C';
FN=data2save{types,iters}.Fitted_GMM_N.mu;
FC=data2save{types,iters}.Fitted_GMM_C.mu;
figure()
nexttile

data2c=SN;
scatter3(data2c(:,2),data2c(:,1), data2c(:,3),s1,color(6,:),'o','linewidth',2);
hold on
data2c=FN;
hold on
scatter3(data2c(:,2),data2c(:,1), data2c(:,3),s2,color(10,:),'.','linewidth',2);
axis off
axis equal
xlim([-60 60])
ylim([-60 60])
view(0,90)
hold on
text(-58, 58, 'a', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 24)

hold on
line([40, 60], [-60, -60],'LineWidth',10,'color','k')
text(50, -58, '20nm', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 24)

nexttile
data2c=SC;
scatter3(data2c(:,2),data2c(:,1), data2c(:,3),s1,color(6,:),'o','linewidth',2);
hold on
data2c=FC;
hold on
scatter3(data2c(:,2),data2c(:,1), data2c(:,3),s2,color(10,:),'.','linewidth',2);

axis equal
xlim([-60 60])
ylim([-60 60])
view(0,90)
axis off
grid off
hold on
hold on
text(-58, 58, 'b', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 24)

nexttile
data2c=[SC;SN];
scatter3(data2c(:,2),data2c(:,1), data2c(:,3),s1,color(6,:),'o','linewidth',2);
hold on
data2c=[FC;FN];
hold on
scatter3(data2c(:,2),data2c(:,1), data2c(:,3),s2,color(10,:),'.','linewidth',2);
axis off
axis equal
xlim([-60 60])
ylim([-60 60])
zlim([-60 60])
view(0,15)

hold on
text(-58, 58,50, 'c', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 24)
hold on
scatter3(-20, 58,50,s1,color(6,:),'o','linewidth',2);
hold on
text(30, 58,45, 'Symmetric constrianed', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 20)

hold on
scatter3(-20, 58,40,s2,color(10,:),'.','linewidth',2);
hold on
text(13, 58,35, 'Unconstrianed', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 20)

filename = ['Results/CompareSFndFModel' num2str(type) '.svg']; % 
%title(['fit Rings of Dataset ' num2str(type) 'NR\Delta=' num2str(mean(topdd)) '\pm' num2str(std(topdd)) sprintf('\n') 'CR\Delta=' num2str(mean(botdd)) '\pm' num2str(std(botdd)) ])
set(gcf,'position',[200,200,1800,600])
set(gca,'FontSize',24);
set(gcf,'Units','Inches');
alpha(0.9)
axis off
set(gcf, 'InvertHardCopy', 'off');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
print(gcf,filename,'-dsvg','-r1000')