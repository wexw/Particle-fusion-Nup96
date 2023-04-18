%This script reconstruct and analyze NPC datasets.
% 1. Particle fusion
% 2. Straighten and filter the reonctruction to get pure rings
% 3. Analyze the pure rings to obtain the emitter positions
% 4. Compare the emitter positions with the EM results
addpath('Functions/')
addpath('Original Datasets/')
addpath('Results/')
%Add paths for Particle Fusion, /JCC3D/ is where you install the Particle
%Fusion Algorithm in 3D version, below is the link
%https://github.com/wexw/Joint-Registration-of-Multiple-Point-Clouds-for-Fast-Particle-Fusion-in-Localization-Microscopy/tree/main/3dcode

path_function=genpath('../JCC3D/Functions_3D');
addpath(path_function)

%Add paths for Classification, /all2all3D/  
% 3D Mex file:mex_expdist for 3D code in Software for Template-Free 3D Particle Fusion in Localization Microscopy is required for 3D classification, 
%https://github.com/imphys/smlm_datafusion3d
path_mex_matlab1 = genpath('../all2all3D/build/mex/');
path_mex_matlab2 = genpath('../all2all3D/build/figtree/src/mex/');
path_matlab = genpath('../all2all3D/MATLAB');

addpath(path_mex_matlab1)
addpath(path_mex_matlab2)
addpath(path_matlab)

load('./Original Datasets/RawParticles1to6.mat')
CCD_pixelsize=130;
for type=1:6
    for iteration=1:1:10

        Prapare_Input_Data

        %1. Particle Fusion
        K=34; %number of GMM centers
        Repeattimes=3;%number of joint registertion, at least 2
        nc=2;%number of clusters for every reconstruction
        minClustSize=N/(nc+2);  %The minumum number of  the particles in a good particle
        dimention=30;%round(N/6)*10; Dimentions of the multidimentional space
        
        tic
        [TVPick_straightened,X_inAll] = ParticleFusion(Particles1, V1, V2, Cscale,Repeattimes,K,nc,dimention,minClustSize);  
        data2process.fusiontime=toc;
        % 2. Straighten and filter the reonctruction to get pure rings
        tic
        [data2process]=Get_Pure_Rings(TVPick_straightened);
        index=0.8;%20% locs in a blob will be filtered out in the density filtering
        data2process= Get_Pure_Rings2(data2process,index);
        % 3. Analyze the pure rings to obtain the emitter positions
        drawfigure=0;%If drawfigure=1, draw fitted ellipses
        [data2process]=Analyze_Pure_rings(data2process,drawfigure);
        data2process.Analyzetime=toc;
        data2save{type,iteration}=data2process;
        save('data2save413.mat','data2save')
    end
end


 % Analyze obtained emitters AnalyzeSParameters and Draw Figures
 Compare_EM_and_overall_SMLM_Symmetric_emitters%Simple version of Figure 4
 Compare_Symmetric_constrained_and_Unconstrained_emitters%Figure 2
 Draw_Symmetric_Parameters%Figure 3
 Draw_Blobs_Analysis%Figure 1 d,e,f,g
 Draw_PureRings_For_60%Figure 1, a,b,cfor figtype=1 type=6 iter=6

