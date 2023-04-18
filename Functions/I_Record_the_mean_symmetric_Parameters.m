%I_Draw_the_mean_symmetric_Parameters
set(0,'defaultfigurecolor','white')
E_R=54;
E_d=11.86;
E_phi_N=-32.6;%-27;
E_phi_C=32.1;%27.3/9
E_theta=-(77.66+75.85)/2;

NRs_SymmetricParameters=data2process.SymmetricParameters_N;
CRs_SymmetricParameters=data2process.SymmetricParameters_C;
IterA=1;
for iter_Angle=1:IterA
    Rr_Bottom(1,iter_Angle)=sqrt(CRs_SymmetricParameters(1,5)^2+CRs_SymmetricParameters(1,6)^2);
    Rr_Top(1,iter_Angle)=sqrt(NRs_SymmetricParameters(1,5)^2+NRs_SymmetricParameters(1,6)^2);

    rd_Bottom( 1,iter_Angle)=abs(CRs_SymmetricParameters(1,2));
    rd_Top( 1,iter_Angle)=abs(NRs_SymmetricParameters(1,2));

    center_C( 1:3,iter_Angle)=CRs_SymmetricParameters(1,5:7)';
    center_N( 1:3,iter_Angle)=NRs_SymmetricParameters(1,5:7)';
end



