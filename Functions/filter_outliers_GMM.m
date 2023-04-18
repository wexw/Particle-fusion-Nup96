function [V_nooutlier,classify]=filter_outliers_GMM(data2filter)

% K=8;
% az1 = 2*pi*rand(1,K);
% el1 = 2*pi*rand(1,K);
% Xin1Top = [cos(az1).*cos(el1); sin(el1); sin(az1).*cos(el1)];
Xin1Top = GenerateBindingSites8(55);
Xin1Top(:,9)=[0,0,0];
Xin1Top(3,:) =mean(data2filter(:,3));
%------------------Generate Xin1-----------------
VTop{1,1}=data2filter(:,1:3)';
Sa=1000;
%------------------JRMPC 2D-----------------
%[R ,t,X,S,a] = jrmpc(V1,Xin1,'maxNumIter',100, 'epsilon', 1e-5,'gamma',0.2);   %JRMPC
[R ,t,X,S,a] = jrmpc_Nooutliers(VTop,Xin1Top,'maxNumIter',500, 'epsilon', 1e-5,'S',Sa);%'gamma',0.2);%'S',1000);   %JRMPC
Rback=cell2mat(R);
tback=cell2mat(t);
XfinalTop=Rback^-1*(X-tback);

[~,classifyV] = cellfun(@(a) max([a 1-sum(a,2)],[],2),a,'uniformoutput',false);
classify1=cell2mat(classifyV);
classify=classify1;
[~,positionTop]=max(S);
V_nooutlier=data2filter;
V_nooutlier(find(classify1(:,1)==positionTop),:)=[];
classify(find(classify1(:,1)==positionTop),:)=[];
end