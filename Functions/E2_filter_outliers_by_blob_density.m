% Input index
for rlabel=1:2
    ring=[];
    if rlabel==1
        ring=NR_pure_G;
      Classify=Classify_NR;
    else
        ring=CR_pure_G;
        Classify=Classify_CR;
    end
    Ring_nooutlier_GD=[];


    blobnum=0;
    Ring_nooutlier_GD=[];
    for ib=unique(Classify)'
        blobnum=blobnum+1;

        data2cl=[];
        data2cl=ring(find(Classify==ib),:);

        densityc=[];
        densityc=visualizeCloud3D2(data2cl(:,1:3),40,0);
        Boudary=index*mean(densityc);
        position=find(densityc>=Boudary);
        Blob_pure=[];
        Blob_pure=data2cl(position,:);
        Blob_pure(:,5)=densityc(position);
        Blob_pure(:,6)=blobnum;
        Ring_nooutlier_GD=[Ring_nooutlier_GD;Blob_pure];
        %         x1=Blob_pure;
        %         hold on
        %         scatter(x1(:,1),x1(:,2),1,color(ib,:))

    end
    %     title(['R' num2str(rlabel) 'keep' num2str(100*index) '%locs' num2str(size(Ring_nooutlier_GD,1))])
    %     axis equal
    Rings_GD{1,rlabel}=Ring_nooutlier_GD;
end

NR_pure_GD=Rings_GD{1,1};
CR_pure_GD=Rings_GD{1,2};

