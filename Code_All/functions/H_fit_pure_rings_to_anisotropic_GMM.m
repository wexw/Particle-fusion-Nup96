%H_fit_pure_rings_to_anisotropic_GMM
clc
clear
addpath('functions')
load('E_Rings_NGD.mat')
options=statset('MaxIter', 2000,'Display','Final');
N_Gaussian=16;
init_Sigma=[100,100,400];
init_Components=ones(1,16).*(1/16);
Param_0_N=[54.5,6.5,pi/2,0,0,53.5,25];
Param_0_C=[54.5,6.5,pi/2,0,0,53.5,-25];

for iter=1:1:100
    anglerandom1=pi*rand(1);
    anglerandom2=pi*rand(1);
        Param=[53.5,6.5,pi/2,anglerandom1];
    BindingSites16=GenerateBindingSites(Param);
    init_Mu=BindingSites16';
    
      for type=1:1:6
        NRP=[];
        CRP=[];
        NRP=Rings_NGD{type,1};
        CRP=Rings_NGD{type,2};
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
        [D_N0] = DP_sum_WithGlobalPhase(FreeEmitters_N,Param_0_N);
        [Param_N,D_N]=fminunc(@(Param) DP_sum_WithGlobalPhase(FreeEmitters_N,Param),Param_0_N);
        %         [Param_N,D_N]=fmincon(@(Param) DP_sum_WithGlobalPhase(FreeEmitters_N,Param),Param_0_N,A,b,Aeq,beq,lb,ub);
        SymmetricEmitters_N=GenerateBindingSites_WithGlobalPhase(Param_N);
        
        [D_C0] = DP_sum_WithGlobalPhase(FreeEmitters_C,Param_0_C);
        [Param_C,D_C]=fminunc(@(Param) DP_sum_WithGlobalPhase(FreeEmitters_C,Param),Param_0_C);
        %         [Param_C,D_C]=fmincon(@(Param) DP_sum_WithGlobalPhase(FreeEmitters_C,Param),Param_0_C,A,b,Aeq,beq,lb,ub);
        %
        SymmetricEmitters_C=GenerateBindingSites_WithGlobalPhase(Param_C);
        
        NRs_SymmetricEmitters{type,iter}=SymmetricEmitters_N;
        CRs_SymmetricEmitters{type,iter}=SymmetricEmitters_C;
        NRs_SymmetricParameters{type,iter}=Param_N;
        CRs_SymmetricParameters{type,iter}=Param_C;
        
        NRs_FreeGMM{type,iter}=GMModel_N;
        CRs_FreeGMM{type,iter}=GMModel_C;
        NRs_InitialSites{type,iter}= BindingSites16;
        
       end
end
save('H_Fitting_model8_100_randomoutplaneAngle_z=2xAllSaved.mat')