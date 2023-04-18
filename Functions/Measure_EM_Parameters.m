%Measure Parameters of EM model
function [Param_NS,Param_CS]=Measure_EM_Parameters(SNAP_fit)
F2E_C=SNAP_fit(:,1:16);
F2E_N=SNAP_fit(:,17:32);
Thetadegree_N= anglestozaxis(F2E_N);
Thetadegree_C= anglestozaxis(F2E_C);
[Phidegree_N,Phidegree_N1]= Phi2Tangent(F2E_N);
[Phidegree_C,Phidegree_C1]= Phi2Tangent(F2E_C);
z_N=mean(F2E_N(3,:));
z_C=mean(F2E_C(3,:));
r_N=norm(F2E_N(:,1)-F2E_N(:,2))/2;
r_C=norm(F2E_C(:,1)-F2E_C(:,2))/2;
R_N=norm(0.5.*(F2E_N(1:2,1)+F2E_N(1:2,2)));
R_C=norm(0.5.*(F2E_C(1:2,1)+F2E_C(1:2,2)));
Param_NS=[R_N,r_N,Thetadegree_N,Phidegree_N,z_N];
Param_CS=[R_C,r_C,Thetadegree_C,Phidegree_C,z_C];
end