% compute the histogram of the z coordinate of 3D localization data

function [xzP, yzP] = zHist(superparticle, nbins)
    
    figure;
    
%     [~,xzP,yzP] = histfit2_W(superparticle, nbins, 'kernel');
    [~,xzP,yzP] = histfit2(superparticle, nbins, 'kernel');
    % plot settings
    xlim([-100,100])
   % legend('z histogram','Gaussian fit')
    xlabel('z (nm)')%,'FontWeight','bold')
    ylabel('Frequency')%,'FontWeight','bold')
    set(gca,'linewidth',0.5,'FontSize',24)
    axis square
    
end