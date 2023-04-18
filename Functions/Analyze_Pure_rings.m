function [data2process]= Analyze_Pure_rings(data2process,drawfigure)
F_measure_E_and_A
data2process.blobE=blobE;
G_fit_pure_rings_to_anisotropic_GMM1
data2process.Fitted_GMM_N=GMModel_N;
data2process.Fitted_GMM_C=GMModel_C;

H_fit_symmetric_constrained_emitters1
data2process.SymmetricEmitter_N=SymmetricEmitters_N;
data2process.SymmetricEmitter_C=SymmetricEmitters_C;
data2process.SymmetricParameters_N=Param_N;
data2process.SymmetricParameters_C=Param_C;

I_Record_the_mean_symmetric_Parameters
data2process.Rr_C=Rr_Bottom(1,:);
data2process.Rr_N=Rr_Top(1,:);
data2process.rd_C=rd_Bottom(1,:);
data2process.rd_N=rd_Top(1,:);
data2process.center_C=center_C;
data2process.center_N=center_N;

I_Transfer_the_mean_symmetric_Parameters
data2process.Phi_C=Phidegree_C(1:2,:);
data2process.Phi_N= Phidegree_N(1:2,:);
data2process.Theta_C= Thetadegree_C(1,:);
data2process.Theta_N=Thetadegree_N(1,:);
end