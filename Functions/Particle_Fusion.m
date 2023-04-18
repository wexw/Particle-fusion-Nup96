%Prapere Initial GMM
X_inAll = GMM_initial(Repeattimes,K);%Generate GMM centers
Sa=sqrt(800)/Cscale;%define standard deviation of GMM
%Step1: Joint registration
Run_JRMPC3DWithfixedXin
%Step2: Calculate Dissimilarity Matrix
Run_DissimilarityMatrixCalculation3D
%Step3: Classification
nc=2;%number of clusters for every reconstruction
minClustSize=N/(nc+2);  %The minumum number of  the particle
dimention=30;%round(N/6)*10; If classification doesn't work, try different dimention values
Run_Classification3D


%Step4: Connection
Run_Connection    %no need to change anything inside

time_All=Time_JRMPC+time_Dissimilarity+Time_Connect+time_Classification; % Total Computational Time
effectiveParticlesNumber=size(TVPick,1);
%Step5: Adjust the pos of the NPC reconstruction
Run_Straighten_NPC