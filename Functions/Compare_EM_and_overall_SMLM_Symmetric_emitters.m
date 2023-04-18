
IterA=1;
num=0;
for type=1:1:6
    for iter=1:1:10
        num=num+1;
        d2p=[];
        d2p=data2save{type,iter};
        allParam_N(num,:)=[d2p.Rr_N,d2p.rd_N,d2p.Theta_N,d2p.Phi_N(1,1),d2p.center_N(3,1),...
            d2p.AnglesMean(1,1),d2p.AnglesStd(1,1),d2p.EsMean(1,1),d2p.EsStd(1,1),type,iter];
        allParam_C(num,:)=[d2p.Rr_C,d2p.rd_C,d2p.Theta_C,d2p.Phi_C(1,1),d2p.center_C(3,1),...
            d2p.AnglesMean(1,2),d2p.AnglesStd(1,2),d2p.EsMean(1,2),d2p.EsStd(1,2),type,iter];
        ParamAll_C{type,iter}=allParam_C(num,1:5);
        ParamAll_N{type,iter}=allParam_N(num,1:5);
    end
end
save('data2draw.mat','allParam_N','allParam_C')
load('SNAPFitData.mat')
% Measure the symmertic parameters for EM data
[Param_NS,Param_CS]=Measure_EM_Parameters(SNAP_fit);
Param_N=mean(allParam_N(:,1:5));
Param_C=mean(allParam_C(:,1:5));
filename=(['Results/CompareEmittersEM_oandSMLMOverAll.svg'])
DrawAndCompareSMLMtoEM
sgtitle('Overall Model, Average of 60 reconstructions')
print(gcf,filename,'-dsvg','-r1000')