function [Ring_pure,Ring_No]=filter_outliers_Density(Ringtofilter,index)
density=Ringtofilter(:,5);
Boudary=index*mean(density);
position=find(density>=Boudary);
Ring_pure=Ringtofilter(position,:);
positionNo=find(density<Boudary);
Ring_No=Ringtofilter(positionNo,:);
end