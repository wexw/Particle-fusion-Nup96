% compute the histogram of the z coordinate of 3D localization data

function [xzP, yzP] = zHist(superparticle, nbins)
        
    [~,xzP,yzP] = histfit2(superparticle, nbins, 'kernel');

    % plot settings
    xlim([-150,150])
   % legend('z histogram','Gaussian fit')
    xlabel('z (nm)')%,'FontWeight','bold')
    ylabel('Frequency')%,'FontWeight','bold')
    axis square
    
end