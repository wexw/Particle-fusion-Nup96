function [data2process] = Get_Pure_Rings2(data2process,index)
E1_filter_outliers_by_GMM;
data2process.NR_pure_G=NR_pure_G;
data2process.CR_pure_G=CR_pure_G;
data2process.Classify_NR=Classify_NR;
data2process.Classify_CR=Classify_CR;

E2_filter_outliers_by_blob_density
data2process.NR_pure_GD=Rings_GD{1,1};
data2process.CR_pure_GD=Rings_GD{1,2};
end