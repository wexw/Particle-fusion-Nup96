NR_straighten=[];
CR_straighten=[];
NR_straighten=data2process.NRall;
CR_straighten=data2process.CRall;
[NR_pure_G,Classify_NR]=filter_outliers_GMM(NR_straighten');
[CR_pure_G,Classify_CR]=filter_outliers_GMM(CR_straighten');

%%%check Classify_GMM
% figure()
% nexttile
% for ib=1:1:8
% x1=[];
% x1=NR_pure_G(:,find(Classify_NR==ib))';
% hold on
% scatter(x1(:,1),x1(:,2),1,color(ib,:))
% end
% nexttile
% for ib=1:1:8
% x1=[];
% x1=CR_pure_G(:,find(Classify_CR==ib))';
% hold on
% scatter(x1(:,1),x1(:,2),1,color(ib,:))
% end
