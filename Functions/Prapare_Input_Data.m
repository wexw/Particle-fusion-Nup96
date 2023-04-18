% Particle0 is a 1xN cell
% every cell has a struct
%  P1{1,1}.points        -> localization data (x,y) in camera pixel
%  P1{1,1}.sigma         -> localization uncertainties (sigma) in camera pixel
switch type
    case 1
        Particles0 = P1;
    case 2
        Particles0 = P2;
    case 3
        Particles0 = P3;
    case 4
        Particles0 = P4;
    case 5
        Particles0 = P5;
    case 6
        Particles0 = P6;
end
model_name = ['P' num2str(type)];

N=size(Particles0,2);
% make all the particles at the real size
[Particles1, V1, V2, Cscale] = processParticlesForParticleFusion(Particles0, CCD_pixelsize);