NRs_FGMM=[];
CRs_FGMM=[];
% NRs_FGMM=data2process.Fitted_GMM_N;
% CRs_FGMM=data2process.Fitted_GMM_C;
% 
% GMModel_N = NRs_FGMM{1,iter_Angle};
% GMModel_C = CRs_FGMM{1,iter_Angle};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FreeEmitters_N=GMModel_N.mu';
FreeEmitters_C=GMModel_C.mu';

Param_0_N=[54.5,6.5,0,-pi/2,0,53.5,mean(FreeEmitters_N(3,:))];
% Fit free Sites to Symmetric Sites
[D_N0] = DP_sum_WithGlobalPhase(FreeEmitters_N,Param_0_N);
[Param_N,D_N]=fminunc(@(Param) DP_sum_WithGlobalPhase(FreeEmitters_N,Param),Param_0_N);
SymmetricEmitters_N=GenerateBindingSites_WithGlobalPhase(Param_N);


Param_0_C=[54.5,6.5,0,-pi/2,0,53.5,mean(FreeEmitters_C(3,:))];

[D_C0] = DP_sum_WithGlobalPhase(FreeEmitters_C,Param_0_C);
[Param_C,D_C]=fminunc(@(Param) DP_sum_WithGlobalPhase(FreeEmitters_C,Param),Param_0_C);
% [Param_C,D_C]=fmincon(@(Param) DP_sum_WithGlobalPhase(FreeEmitters_C,Param),Param_0_C,A,b,Aeq,beq,lb,ub);

SymmetricEmitters_C=GenerateBindingSites_WithGlobalPhase(Param_C);

% NRs_SymmetricEmitters{type,iter_Angle}=SymmetricEmitters_N;
% 
% CRs_SymmetricEmitters{type,iter_Angle}=SymmetricEmitters_C;
% 
% NRs_SymmetricParameters{type,iter_Angle}=Param_N;
% CRs_SymmetricParameters{type,iter_Angle}=Param_C;
    %     figure()
    %     FE=FreeEmitters_C';
    %     scatter3(FE(:,1),FE(:,2),FE(:,3),'x',"blue")
    %     hold on
    %     FE=FreeEmitters_N';
    %     scatter3(FE(:,1),FE(:,2),FE(:,3),'x',"blue")
    %     hold on
    %     FE=SymmetricEmitters_C';
    %     scatter3(FE(:,1),FE(:,2),FE(:,3),'o',"k")
    %     hold on
    %     FE=SymmetricEmitters_N';
    %     scatter3(FE(:,1),FE(:,2),FE(:,3),'o',"k")
    %     hold on

