set(0,'defaultfigurecolor','white')
options=statset('MaxIter', 2000,'Display','Final');
N_Gaussian=16;
init_Sigma=[49,49,441];
init_Components=ones(1,16).*(1/16);
NRP=[];
CRP=[];
% NRP=NRs_pure_GD{type,iter};
% CRP=CRs_pure_GD{type,iter};
NRP=  data2process.NR_pure_GD;
CRP=  data2process.CR_pure_GD;
iter_Angle=1;
Theta1=pi/2;

Param=[53.5,6.5,pi/4,Theta1];
BindingSites16=GenerateBindingSites(Param);
init_Mu=BindingSites16';
% figure()
% init_Mu(:,3)=25;
%     scatter3(init_Mu(:,1),init_Mu(:,2),init_Mu(:,3),'x',"blue")
%     hold on
%     scatter3(init_Mu(:,1),init_Mu(:,2),-init_Mu(:,3),'x',"red")
%     hold off



%Search for best free sites by anisotropic GMM fitting
init_Mu(:,3)=24;
%init_Mu=GenerateBindingSites_WithGlobalPhase(Param_0_N)';
S = struct('mu',init_Mu,'Sigma',init_Sigma,'ComponentProportion',init_Components);
GMModel_N = fitgmdist(NRP(:,1:3),16, 'Start', S,'SharedCovariance',true,'CovarianceType','diagonal','RegularizationValue',0.01,'Replicates',1,'Options',options);
% FreeEmitters_N=GMModel_N.mu';
init_Mu(:,3)=-24;
S = struct('mu',init_Mu,'Sigma',init_Sigma,'ComponentProportion',init_Components);
GMModel_C= fitgmdist(CRP(:,1:3),16, 'Start', S,'SharedCovariance',true,'CovarianceType','diagonal','RegularizationValue',0.01,'Replicates',1,'Options',options);
% FreeEmitters_C=GMModel_C.mu';
% NRs_FreeGMM{type,iter_Angle}=GMModel_N;
% CRs_FreeGMM{type,iter_Angle}=GMModel_C;
% FM=[FreeEmitters_N,FreeEmitters_C]';


