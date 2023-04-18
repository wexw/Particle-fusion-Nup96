function [D] = DP_sum_WithGlobalPhase(V,Param)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% function [BidingSites,r,theta,phi] =FitRingModel(V,center_0,r_0,theta_0,phi_0)
sqe = @(Y,X) min(sum(bsxfun(@minus,permute(Y,[2 3 1]),permute(X,[3 2 1])).^2,3)');
% sqe = @(Y,X) mink(sum(bsxfun(@minus,permute(Y,[2 3 1]),permute(X,[3 2 1])).^2,3)',1);
BindingSites=GenerateBindingSites_WithGlobalPhase(Param);
D=sum(sqe(V,BindingSites));
end
