%Calculate the symmetric parameters in the model system.

set(0,'defaultfigurecolor','white')
E_R=54;
E_d=11.86;
E_phi_N=-32.6;%-27;
E_phi_C=32.1;%27.3/9
E_theta=-(77.66+75.85)/2;%-76
NRE=[];
CRE=[];
NRE=data2process.SymmetricEmitter_N;
CRE=data2process.SymmetricEmitter_C;
for iter_Angle=1:IterA
    F2E_N=NRE(:,1:2);
    F2E_C=CRE(:,1:2);
    Thetadegree_N(1,iter_Angle)= anglestozaxis(F2E_N);
    Thetadegree_C(1,iter_Angle)= anglestozaxis(F2E_C);
    [Phidegree_N(1,iter_Angle),Phidegree_N(2,iter_Angle)]= Phi2Tangent(F2E_N);
    [Phidegree_C(1,iter_Angle),Phidegree_C(2,iter_Angle)]= Phi2Tangent(F2E_C);
end