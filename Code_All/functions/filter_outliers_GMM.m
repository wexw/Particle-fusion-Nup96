function [V_nooutlier,classify]=filter_outliers_GMM(data2filter)
color=[0,0,1;0,1,0;1,0,0;
    1,0,1;1,1,0;1,0.5,0.25;
    1,0,0.5; 0.5,0.5,0.5;0,0,0;
    ];
K=8;
az1 = 2*pi*rand(1,K);
el1 = 2*pi*rand(1,K);
Xin1Top = [cos(az1).*cos(el1); sin(el1); sin(az1).*cos(el1)];
Xin1Top = Xin1Top*50;%CCD_pixelsize;
Xin1Top(:,9)=[0,0,0];
% figure()
%  scatter3(data2filter(:,1),data2filter(:,2), data2filter(:,3),5,"blue",'x');
     
%------------------Generate Xin1-----------------
VTop{1,1}=data2filter(:,1:3)';
Sa=100000;
%------------------JRMPC 2D-----------------
%[R ,t,X,S,a] = jrmpc(V1,Xin1,'maxNumIter',100, 'epsilon', 1e-5,'gamma',0.2);   %JRMPC
[R ,t,X,S,a] = jrmpc_Nooutliers(VTop,Xin1Top,'maxNumIter',500, 'epsilon', 1e-5,'S',Sa);%'gamma',0.2);%'S',1000);   %JRMPC
% dense_k = find(S < Boundary*median(S));%Oringin
%dense_k = find(S <= 2*min(S));%Index
%keyboard
% classify points in V to centers 1,..,K or the outiler class K+1
Rback=cell2mat(R);
tback=cell2mat(t);
XfinalTop=Rback^-1*(X-tback);

% XfinalTop(4,:)=[1:1:K];

[~,classifyV] = cellfun(@(a) max([a 1-sum(a,2)],[],2),a,'uniformoutput',false);
classify=cell2mat(classifyV);
[~,positionTop]=max(S);
V_nooutlier=data2filter';
V_nooutlier(:,find(classify(:,1)==positionTop))=[];
data2cDraw=V_nooutlier';
% nexttile
for pk=1:9
    hold on
    V_d=data2filter';
    data2cDraw=[];
    data2cDraw=V_d(:,find(classify(:,1)==pk))';
%     if pk==positionTop
%         scatter3(data2cDraw(:,1),data2cDraw(:,2), data2cDraw(:,3),8,color(pk,:),'x');
%         hold on
%         %         axis euqal
%     end
%     set(gcf,'color','w')
%     set(gca,'color','w')
%     scatter3(data2cDraw(:,1),data2cDraw(:,2), data2cDraw(:,3),4,color(pk,:),'.');
end
end