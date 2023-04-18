% Input index=0.7



for rlabel=1:2
    ring=[];
    if rlabel==1
        ring=NR_pure_G;
        ClassifyNO=[];
        ClassifyNO=Classify_NR;
    else
        ring=CR_pure_G;
        ClassifyNO=[];
        ClassifyNO=Classify_CR;
    end


    blobnum=0;
    Ring_nooutlier_GD=[];

    %     nexttile
    for ib=unique(ClassifyNO)'
        blobnum=blobnum+1;
        data2ca=[];
        data2ca=ring(find(ClassifyNO==ib),:);

        densityc=[];
        densityc=visualizeCloud3D2(data2ca(:,1:3),40,0);
        data2ca(:,5)=densityc;

        Nd=size(data2ca,1);
        num_points_to_keep = ceil(index * Nd); % calculate the number of points to keep
        [sorted_density, sorted_indices] = sort(densityc, 'descend'); % sort the points based on density
        threshold_density = sorted_density(num_points_to_keep); % find the density threshold to keep 95% of the points
        Blob_pure=[];
        Blob_pure = data2ca(sorted_indices(sorted_density >= threshold_density), :); % filter out the points with density below the threshol
        Blob_pure(:,6)=blobnum;
        %         x1=Blob_pure;
        %         hold on
        %         scatter(x1(:,1),x1(:,2),1,color(ib,:))
        Ring_nooutlier_GD=[Ring_nooutlier_GD;Blob_pure];
        blob{rlabel,ib}=Blob_pure;
    end
    %     title(['R' num2str(rlabel) 'keep' num2str(100*index) '%locs' num2str(size(Ring_nooutlier_GD,1))])
    %     axis equal
    Rings_GD{1,rlabel}=Ring_nooutlier_GD;
    
end



