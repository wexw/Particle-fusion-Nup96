%Compare and Draw SE SMLM to SNAP
%%%%Input

% Param_N=Param_N1;
% Param_C=Param_C1;
% Param_N=mean(allParam_N);
% Param_C=mean(allParam_C);
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
SSN = GenerateSymmetricEmitters(Param_N)';
SSC = GenerateSymmetricEmitters(Param_C)';
SSA=[SSN;SSC];

[Param_NS,Param_CS]=Measure_EM_Parameters(SNAP_fit)
SEN = GenerateSymmetricEmitters(Param_NS)';
SEC = GenerateSymmetricEmitters(Param_CS)';
SEA=[SEN;SEC];

DeltaC=SSC-SEC; 
Delta_zC=mean(vecnorm(DeltaC(:,3),2,2)); 
Delta_dC=mean(vecnorm(DeltaC(:,1:3),2,2));
Delta_xyC=mean(vecnorm(DeltaC(:,1:2),2,2));


DeltaN=SSN-SEN; 
Delta_zN=mean(vecnorm(DeltaN(:,3),2,2)); 
Delta_dN=mean(vecnorm(DeltaN(:,1:3),2,2));
Delta_xyN=mean(vecnorm(DeltaN(:,1:2),2,2));


DeltaA=SSA-SEA; 
Delta_zA=mean(vecnorm(DeltaA(:,3),2,2)); 
Delta_dA=mean(vecnorm(DeltaA(:,1:3),2,2));
Delta_xyA=mean(vecnorm(DeltaA(:,1:2),2,2));

figure()
nexttile
scatter3(SSN(:,1),SSN(:,2), SSN(:,3),40,color(1,:),'x','linewidth',2);
hold on
scatter3(SEN(:,1),SEN(:,2), SEN(:,3),40,color(2,:),'o','linewidth',2);
title(['NR,\Deltaz=' num2str(Delta_zN) ',\Deltaxy=' num2str(Delta_xyN) ',\Deltad=' num2str(Delta_dN)]);
axis equal

xlim([-60 60])
ylim([-60 60])
view(0,90)
axis off
nexttile
scatter3(SSC(:,1),SSC(:,2), SSC(:,3),40,color(1,:),'x','linewidth',2);
hold on
scatter3(SEC(:,1),SEC(:,2), SEC(:,3),40,color(2,:),'o','linewidth',2);
title(['CR,\Deltaz=' num2str(Delta_zC) ',\Deltaxy=' num2str(Delta_xyC) ',\Deltad=' num2str(Delta_dC)]);

axis equal

xlim([-60 60])
ylim([-60 60])
view(0,90)
axis off
nexttile
scatter3(SSA(:,1),SSA(:,2), SSA(:,3),40,color(1,:),'x','linewidth',2);
hold on
scatter3(SEA(:,1),SEA(:,2), SEA(:,3),40,color(2,:),'o','linewidth',2);
view(0,15)
axis off
title(['2R,\Deltaz=' num2str(Delta_zA) ',\Deltaxy=' num2str(Delta_xyA) ',\Deltad=' num2str(Delta_dA)]);


set(gcf,'position',[200,200,1200,300])

set(gcf,'Units','Inches');
alpha(0.9)

set(gcf, 'InvertHardCopy', 'off');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
axis off
print(gcf,filename,'-dsvg','-r1000')
