function [TVPick_straightened,X_inAll] = ParticleFusion(Particles1, V1, V2, Cscale,Repeattimes,K,nc,dimention,minClustSize)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
%Prapere Initial GMM
X_inAll = GMM_initial(Repeattimes,K);%Generate GMM centers
Sa=sqrt(800)/Cscale;%define standard deviation of GMM
%Step1: Joint registration
Run_JRMPC3DWithfixedXin
%Step2: Calculate Dissimilarity Matrix
Run_DissimilarityMatrixCalculation3D
%Step3: Classification
cluster_mode=2;
Run_Classification3D
%Step4: Connection
limit=0;
Run_Connection    %no need to change anything inside
%time_All=Time_JRMPC+time_Dissimilarity+Time_Connect+time_Classification; % Total Computational Time
effectiveParticlesNumber=size(TVPick,1);
%Step5: Adjust the pos of the NPC reconstruction
Run_Straighten_NPC
end