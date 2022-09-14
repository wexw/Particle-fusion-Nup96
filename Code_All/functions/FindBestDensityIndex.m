clc
clear
addpath('functions')
addpath('results')
set(0,'defaultfigurecolor','white')
load('D_StraightendRings.mat','NRs','CRs')
load('EMEmitters.mat')

for index=0:0.2:1
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

%         data2cDraw2=[];
%         data2cDraw2= Rings_OD{type,rlabel};
%         scatter3(data2cDraw2(:,1),data2cDraw2(:,2), data2cDraw2(:,3),8,'r','x');
    end
end
options=statset('MaxIter', 2000,'Display','Final');
N_Gaussian=16;
init_Sigma=[49,49,169];
init_Components=ones(1,16).*(1/16);
Param_0_N=[54.5,6.5,pi/2,0,0,53.5,25];
Param_0_C=[54.5,6.5,pi/2,0,0,53.5,-25];

for iter=1:1:20
    anglerandom1=180*rand(1);
    Param=[53.5,6.5,90,anglerandom1];
    BindingSites16=GenerateBindingSites(Param);
    init_Mu=BindingSites16';
    
    for type=1:1:6
        NRP=[];
        CRP=[];
        NRP=Rings_NGD{type,1};
        CRP=Rings_NGD{type,2};
        %         NRP=Rings_NGD{type,1}{1,1};
        %         CRP=Rings_NGD{type,1}{1,2};
        %Search for best free sites by anisotropic GMM fitting
        init_Mu(:,3)=25;
        S = struct('mu',init_Mu,'Sigma',init_Sigma,'ComponentProportion',init_Components);
        GMModel_N = fitgmdist(NRP(:,1:3),16, 'Start', S,'SharedCovariance',true,'CovarianceType','diagonal','RegularizationValue',0.01,'Replicates',1,'Options',options);
        
        init_Mu(:,3)=-25;
        S = struct('mu',init_Mu,'Sigma',init_Sigma,'ComponentProportion',init_Components);
        GMModel_C= fitgmdist(CRP(:,1:3),16, 'Start', S,'SharedCovariance',true,'CovarianceType','diagonal','RegularizationValue',0.01,'Replicates',1,'Options',options);
        
        FreeEmitters_N=GMModel_N.mu';
        FreeEmitters_C=GMModel_C.mu';
        
        %Fit free Sites to Symmetric Sites
        [D_N0] = DP_sum_WithGlobalPhase2(FreeEmitters_N,Param_0_N);
        [Param_N,D_N]=fminunc(@(Param) DP_sum_WithGlobalPhase2(FreeEmitters_N,Param),Param_0_N);
        %         [Param_N,D_N]=fmincon(@(Param) DP_sum_WithGlobalPhase(FreeEmitters_N,Param),Param_0_N,A,b,Aeq,beq,lb,ub);
        SymmetricEmitters_N=GenerateBindingSites_WithGlobalPhase2(Param_N);
        
        [D_C0] = DP_sum_WithGlobalPhase2(FreeEmitters_C,Param_0_C);
        [Param_C,D_C]=fminunc(@(Param) DP_sum_WithGlobalPhase2(FreeEmitters_C,Param),Param_0_C);
        SymmetricEmitters_C=GenerateBindingSites_WithGlobalPhase2(Param_C);
        
        NRs_SymmetricEmitters{type,iter}=SymmetricEmitters_N;
        CRs_SymmetricEmitters{type,iter}=SymmetricEmitters_C;
        NRs_SymmetricParameters{type,iter}=Param_N;
        CRs_SymmetricParameters{type,iter}=Param_C;
        
        NRs_FreeGMM{type,iter}=GMModel_N;
        CRs_FreeGMM{type,iter}=GMModel_C;
        NRs_InitialSites{type,iter}= BindingSites16;
       end
end

iterationtimes=size(NRs_FreeGMM,2)
set(0,'defaultfigurecolor','white')
% set(0,'defaultfigurecolor','white')
E_R=54;
E_d=11.86;
E_phi_N=-32.6;%-27;Rr
E_phi_C=32.1;%27.3
E_theta=-(77.66+75.85)/2;
for type=1:6
    for iter=1:iterationtimes
        i=type;
        topring=NRs_SymmetricEmitters{type,iter};
        [rd_Top(type,iter),Rr_Top(i,iter),Theta_Top(i,iter),Phi_Top(i,iter),c1x_Top(i,iter),c1y_Top(i,iter),c1z_Top(i,iter)] = MeasureSymmetricParameters(topring);
        botring=CRs_SymmetricEmitters{i,iter};
        [rd_Bottom(i,iter),  Rr_Bottom(i,iter),Theta_Bottom(i,iter),Phi_Bottom(i,iter),c1x_Bottom(i,iter),c1y_Bottom(i,iter),c1z_Bottom(i,iter)] = MeasureSymmetricParameters(botring);
        % Phi_Bottom_new(i,iter)=90+Phi_Bottom(i,iter)-atan2(CRs_SymmetricParameters{i,iter}(1,6),CRs_SymmetricParameters{i,iter}(1,5))/pi*180;
        % Phi_Top_new(i,iter)=90+Phi_Top(i,iter)-atan2(NRs_SymmetricParameters{i,iter}(1,6),NRs_SymmetricParameters{i,iter}(1,5))/pi*180;
        SymmericParameters_NR{type,1}(iter,:)=[Rr_Top(type,iter),rd_Top(i,iter),Theta_Top(i,iter),Phi_Top(i,iter),c1x_Top(i,iter),c1y_Top(i,iter),c1z_Top(i,iter)];
        SymmericParameters_CR{type,1}(iter,:)=[Rr_Bottom(i,iter),rd_Bottom(i,iter),Theta_Bottom(i,iter),Phi_Bottom(i,iter),c1x_Bottom(i,iter),c1y_Bottom(i,iter),c1z_Bottom(i,iter)];
        %      SymmericParameters_NR{type,iter}(:,3:4)=SymmericParameters_NR{type,iter}(:,3:4)/180*pi;
        %        SymmericParameters_CR{type,iter}(:,3:4)=SymmericParameters_CR{type,iter}(:,3:4)/180*pi;
        newNR=[];
        newCR=[];
        newNR=GenerateBindingSites_WithGlobalPhase2(SymmericParameters_NR{type,1}(iter,:));
        newCR=GenerateBindingSites_WithGlobalPhase2(SymmericParameters_CR{type,1}(iter,:));
%         newNR-topring
%         newCR-botring
         AD1=EmittersDistAverage([newNR';newCR'],[topring';botring']);
         if AD1>0.11
             AD1
         end
     
    end
end

figure()
tiledlayout(3,2,'TileSpacing','Compact');
nexttile
xb=1.1:1:6.1;
xt=0.9:1:5.9;
yb=mean(Rr_Bottom');
stdyb=std(Rr_Bottom');

yt=mean(Rr_Top');
stdyt=std(Rr_Top');

mean(yt)
mean(yb)
errorbar(xb,yb,stdyb,'o','MarkerSize',10,...
    'MarkerEdgeColor','red','LineWidth',1,'color','red')
hold on
errorbar(xt,yt,stdyt,'o','MarkerSize',10,...
    'MarkerEdgeColor','blue','LineWidth',1,'color','blue')
hold on
line([0,7],[E_R,E_R],'color','k','linestyle','--','LineWidth',1)
xlim([0 7])
xticks([1 2 3 4 5 6 7])
% xticklabels({'dataset 1','dataset 2','dataset 3','dataset 4','dataset 5','combined dataset'})
xticklabels({'1','2','3','4','5','combined'})
xlabel('datasets')
ylabel('radius of the ring R (nm)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nexttile
% xb=1:1:6;
yb=mean(rd_Bottom'.*2);
stdyb=std(rd_Bottom'.*2);
yt=mean(rd_Top'.*2);
stdyt=std(rd_Top'.*2);

mean(yb)
errorbar(xb,yb,stdyb,'o','MarkerSize',10,...
    'MarkerEdgeColor','red','LineWidth',1,'color','red')
hold on
errorbar(xt,yt,stdyt,'o','MarkerSize',10,...
    'MarkerEdgeColor','blue','LineWidth',1,'color','blue')
hold on
line([0,7],[E_d,E_d],'color','k','linestyle','--','LineWidth',1)
xticks([1 2 3 4 5 6 7])
xticklabels({'1','2','3','4','5','combined'})
xlabel(['\Delta d_t=' num2str(round(mean(yt)-E_d),2) ' \Delta d_b=' num2str(round(mean(yb)-E_d),2)])
ylabel('distance in the dimer d (nm)')
hold on
scatter(6,16,70,'red','o')
text(6.2,16,'CR','FontSize',24,'FontName','Arial');
hold on
scatter(6,17,70,'blue','o','LineWidth',1)
text(6.2,17,'NR','FontSize',24,'FontName','Arial');
hold on
line([5.7,6.1],[15,15],'color','k','linestyle','--','LineWidth',1)
text(6.2,15,'EM','FontSize',24,'FontName','Arial');
xlim([0 7])
ylim([6 18])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nexttile
xb=1:1:6;
yb=mean(Phi_Bottom');
stdyb=std(Phi_Bottom');
yt=mean(Phi_Top');
stdyt=std(Phi_Top');
errorbar(xb,yb,stdyb,'o','MarkerSize',10,...
    'MarkerEdgeColor','red','LineWidth',1,'color','red')
hold on
errorbar(xt,yt,stdyt,'o','MarkerSize',10,...
    'MarkerEdgeColor','blue','LineWidth',1,'color','blue')
hold on
line([0,7],[E_phi_C,E_phi_C],'color','r','linestyle','--','LineWidth',1)
hold on
line([0,7],[E_phi_N,E_phi_N],'color','b','linestyle','--','LineWidth',1)
xticks([1 2 3 4 5 6 7])
xticklabels({'1','2','3','4','5','combined'})
xlabel(['\Delta \phi_t=' num2str(round(mean(yt)-E_phi_N),2) ' \Delta \phi_b=' num2str(round(mean(yb)-E_phi_C),2)])
ylabel('in plane angle \phi (^°)')
xlim([0 7])





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nexttile
% xb=1:1:6;
yb=mean(Theta_Bottom');
stdyb=std(Theta_Bottom');
yt=mean(Theta_Top');
stdyt=std(Theta_Top');

mean(yt)
mean(yb)
errorbar(xb,yb,stdyb,'o','MarkerSize',10,...
    'MarkerEdgeColor','red','LineWidth',1,'color','red')

hold on

errorbar(xt,yt,stdyt,'o','MarkerSize',10,...
    'MarkerEdgeColor','blue','LineWidth',1,'color','blue')

hold on
line([0,7],[E_theta,E_theta],'color','k','linestyle','--','LineWidth',1)


xticks([1 2 3 4 5 6 7])
% xticklabels({'dataset 1','dataset 2','dataset 3','dataset 4','dataset 5','combined dataset'})
xticklabels({'1','2','3','4','5','combined'})
% xticklabels(xticks([1 2 3 4 5 6]){'dataset 1','dataset 2','dataset 3','dataset 4','dataset 5','combined dataset'})

xlabel(['\Delta \theta_t=' num2str(round(mean(yt)-E_theta),2) ' \Delta \theta_b=' num2str(round(mean(yb)-E_theta),2)])
ylabel('out of plane angle \theta (^°)')
xlim([0 7])

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
%Search for the symmetric model which is most close to the mean symmertic
%model
% SymmericParameters_NR{type,1}(iter,:)=[Rr_Top(type,iter),rd_Top(i,iter),Theta_Top(i,iter),Phi_Top(i,iter),c1y_Top(i,iter),c1z_Top(i,iter)];
% SymmericParameters_CR{type,1}(iter,:)=[Rr_Bottom(i,iter),rd_Bottom(i,iter),Theta_Bottom(i,iter),Phi_Bottom(i,iter),c1x_Bottom(i,iter),c1y_Bottom(i,iter),c1z_Bottom(i,iter)];

meanNRs_SP=[]
meanCRs_SP=[]
for type=1:6
    for j=1:2
        if j==2
            for iter=1:iterationtimes
                CRs_SP_M(iter,:)=SymmericParameters_CR{type,1}(iter,:);
            end
            meanCRs_SP=mean(CRs_SP_M)
            for iter=1:iterationtimes
                Delta(iter,:)=abs(SymmericParameters_CR{type,1}(iter,:)- meanCRs_SP);
            end
        else
            for iter=1:iterationtimes
                NRs_SP_M(iter,:)=SymmericParameters_NR{type,1}(iter,:);
            end
            meanNRs_SP=mean(NRs_SP_M)
            for iter=1:iterationtimes
                Delta(iter,:)=abs(SymmericParameters_NR{type,1}(iter,:)- meanNRs_SP);
            end
        end

        DeltaSum=sum(Delta(:,1:4)');
        [mindelta(type,j),minp(type,j)]=min(DeltaSum);
    end
    meanNRs_SPA{type,1}=meanNRs_SP;
    meanCRs_SPA{type,1}=meanCRs_SP;
end
%Draw Figures x-y view for single ring
for type=1:6
    for j=1:2

        if j==1
              MS{type,j}= GenerateBindingSites_WithGlobalPhase2(meanNRs_SPA{type,1});
        else
            MS{type,j}=  GenerateBindingSites_WithGlobalPhase2(meanCRs_SPA{type,1});
        end

        if j==1
            FE{type,j}=NRs_FreeGMM{type,minp(type,j)}.mu';
                end
        if j==2
            FE{type,j}=CRs_FreeGMM{type,minp(type,j)}.mu';
        end
    end
    SM=[];
    FM=[];
    SM1=[];
    FM1=[];

    SM=[MS{type,1},MS{type,2}]';
    FM=[FE{type,1},FE{type,2}]';

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
%     figure()
%     scatter3(FM(:,1),FM(:,2),FM(:,3),1800,color(10,:),'.','linewidth',2)
%     hold on
%     scatter3(SM(:,1),SM(:,2),SM(:,3),140,color(6,:),'o','linewidth',2)
%     hold on
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
    Distance(type,:)=[mean(zd),std(zd),mean(xydd),std(xydd),mean(topdd),std(topdd),mean(botdd),std(botdd)];
    title(['fit Rings of Dataset ' num2str(type) 'NR\Delta=' num2str(mean(topdd)) '\pm' num2str(std(topdd)) sprintf('\n') 'CR\Delta=' num2str(mean(botdd)) '\pm' num2str(std(botdd)) ])
%     view(0,15)
%     axis off
end
nexttile
xb=1.1:1:6.1;
plot(xb,Distance(:,1))
xlabel(['datasets with index' num2str(index) 'meanAD=' num2str(mean(Distance(:,1)))])
ylabel('difference between unconstrained and constrained Emitters')



for type=1:6
    
  %minAD_All(type,1)%EmittersDistAverage(coord_snap, SMLMtoEMSNAP{type,1})/10
    for iter=1:20
        coord_SMLM=[];
        %     coord_SMLM= MS{type,1}'.*10;
        coord_SMLM(1:16,:)=MS{type,1}'.*10;
        coord_SMLM(17:32,:)=MS{type,2}'.*10;
        Coord_SMLM=[coord_SMLM(:,2),coord_SMLM(:,1),coord_SMLM(:,3)];
        %Align Datasets
        V_origin{1,1}=coord_snap';
        V_origin{2,1}=Coord_SMLM';
        
        %------------------Generate Xin1-----------------
        K=16;
        az1 = 2*pi*rand(1,K);
        el1 = 2*pi*rand(1,K);
        Xin1 = [cos(az1).*cos(el1); sin(el1); sin(az1).*cos(el1)];
        Xin1 = Xin1*100;%CCD_pixelsize;
        %B_initial=Xin1;
        %------------------Generate Xin1-----------------
        
        %------------------JRMPC 2D-----------------
        [R ,t,X,S,a] = jrmpc_Nooutliers(V_origin,Xin1,'maxNumIter',500, 'epsilon', 1e-5);%,'S',Sa);%'gamma',0.2);%'S',1000);   %JRMPC
        TVa= cellfun(@(V,R,t) bsxfun(@plus,R*V,t),V_origin,R,t,'uniformoutput',false);
        %Transform particles back to origin place of one particle
        Rback=R{1,1}^-1;
        tback=-t{1,1};
        R2{1,1}=Rback;
        R2{2,1}=Rback;
        t2{1,1}=tback;
        t2{2,1}=tback;
        coord_SMLMtosnap=[Rback*(TVa{2,1}+tback)]';%=TV2{1,2}';
        AD1=EmittersDistAverage(coord_snap,coord_SMLMtosnap)/10    
        if iter==1
              minAD=AD1;
        end
        if AD1<minAD
            minAD=AD1
            type
            minAD_All(type,1)=minAD;
            SMLMtoEMSNAP{type,1}=coord_SMLMtosnap;
            save('SMLMtoEMSNAP.mat','SMLMtoEMSNAP','minAD_All')
        end   
    end
end
    nexttile
xb=1.1:1:6.1;
plot(xb,minAD_All(:,1))
xlabel(['datasets with index' num2str(index) 'meanAD=' num2str(mean(minAD_All(:,1)))])
ylabel('difference between unconstrained and constrained Emitters')
save(['results/J_SymmetricAndFreeEmittersindex=' num2str(index) '.mat'])
end
% 
% save('E_Rings_NGD.mat','NRs','CRs','Rings_NGD','NRs_pure_G','CRs_pure_G','Classify')
