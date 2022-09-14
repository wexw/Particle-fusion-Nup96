K_Align_SMLM_to_EM
% Add_Paths
addpath('functions')
addpath('results')
load('EMEmitters.mat')
load('J_SymmetricAndFreeEmitters.mat','MS','FE')
for type=1:6
    
    minAD=6.3%minAD_All(type,1)%EmittersDistAverage(coord_snap, SMLMtoEMSNAP{type,1})/10
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
        %
        %     figure; hold on
        %     %plot3(Coord_snap2(:,1), Coord_snap2(:,2), Coord_snap2(:,3),'gd')
        %     plot3(coord_snap(:,1), coord_snap(:,2), coord_snap(:,3),'gd')
        %     plot3(coord_SMLMtosnap(:,1), coord_SMLMtosnap(:,2),coord_SMLMtosnap(:,3),'b*')
        %     title(['align Model' num2str(i) 'with snap AD=' num2str(round(AD1)) 'nm' ] )
        %     hold off
        
        
        
        
        %     figure; hold on
        %     plot3(coord_nup96(:,1), coord_nup96(:,2), coord_nup96(:,3),'rx')
        %     %plot3(Coord_snap(:,1), Coord_snap(:,2), Coord_snap(:,3),'gd')
        %     plot3(coord_SMLMtonup96(:,1), coord_SMLMtonup96(:,2),coord_SMLMtonup96(:,3),'b*')
        %     title(['align Model' num2str(i) 'with nup96 AD=' num2str(round(AD2)) 'nm' ] )
        %     hold off
        if AD1<minAD
            minAD=AD1
            type
            minAD_All(type,1)=minAD;
            SMLMtoEMSNAP{type,1}=coord_SMLMtosnap;
            save('SMLMtoEMSNAP.mat','SMLMtoEMSNAP','minAD_All')
        end
        
    end
end