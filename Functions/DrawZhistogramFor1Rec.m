nbins=150;
Rings_NGD{type,1}=data2save{type,iter}.NR_pure_GD;
Rings_NGD{type,2}=data2save{type,iter}.CR_pure_GD;
data2c=[];
data2c=[Rings_NGD{type,1};Rings_NGD{type,2}];
data2c=data2c;

SuperParticle=data2c;

% colormap('winter');
[xzp,yzp]=zHist(SuperParticle(:,3), nbins);
set(gcf,'color','w')
set(gca,'color','w')
[minx,X0place]=min(abs(xzp));
[max1,p1]=max(yzp(1,1:X0place));
xmax1=xzp(1,p1);
%     i
%     Num_loc(i)=size(SuperParticle,1)
yzp1=yzp(1,1:X0place);
fmax1=0.5*max1;

yzp1minus=abs(yzp1-fmax1);
[min1,pmin1]=min(yzp1minus(1,1:round(size(yzp1minus,2)/2)));
[min2,pmin2]=min(yzp1minus(1,round(size(yzp1minus,2)/2)+1:round(size(yzp1minus,2))));
xmin1=xzp(1,pmin1);
xmin2=xzp(1,pmin2+round(size(yzp1minus,2)/2));

[max2,p2]=max(yzp(1,X0place+1:size(yzp,2)));
xmax2=xzp(1,p2+X0place);
yzp2=yzp(1,X0place+1:size(yzp,2));
uncertainty1=abs(xmin1-xmin2)/sqrt(size(SuperParticle,1)/2);
U1=abs(xmin1-xmin2);

fmax2=0.5*max2;
yzp2minus=abs(yzp2-fmax2);
[min3,pmin3]=min(yzp2minus(1,1:round(size(yzp2minus,2)/2)-1));
[min4,pmin4]=min(yzp2minus(1,round(size(yzp2minus,2)/2):size(yzp2minus,2)));
xmin3=xzp(1,pmin3+X0place);
xmin4=xzp(1,pmin4+round(size(yzp2minus,2)/2)+X0place-1);
uncertainty2=abs(xmin3-xmin4)/sqrt(size(SuperParticle,1)/2);
U2=abs(xmin3-xmin4);
uncertainty=uncertainty1+uncertainty2;
deltaxz=xmax2-xmax1;
yline=0.7*max(yzp);
ylength=0.06*yline;
line([xmax1,xmax2],[yline,yline],'color','k','linestyle','--','LineWidth',1)
txt = [num2str(round(deltaxz,1)) '\pm' num2str(round(uncertainty,1)) ' nm'];

text(33,yline,txt,'FontSize',16,'FontName','Arial','Color','k')
line([xmax1,xmax1],[yline-ylength,yline+ylength],'color','k','linestyle','-','LineWidth',1)
line([xmax2,xmax2],[yline-ylength,yline+ylength],'color','k','linestyle','-','LineWidth',1)

if type==6
    lgd=legend('z histogram','Gaussian fit','FontName','Arial');
    lgd.TextColor='black';
    lgd = findobj(gcf, 'Type', 'Legend');
   
    % ylim[]
end
set(gca,'FontSize',16,'FontName','Arial');
% set(gcf,'Units','Inches');
% set(gca,'FontSize',24,'FontName','Arial');
% set(gcf, 'InvertHardCopy', 'off');


