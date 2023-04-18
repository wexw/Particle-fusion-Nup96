function X_inAll =GMM_initial(Repeattimes,K)
% Input:
% - Repeattimes: number of JRMPC used in the particle fusion
% - K: estimated number of GMM centers for JRMPC
% Output:
% - X_inAll: cell array containing the initial input GMM for each JRMPC
%
% (C) Copyright 2023               
% CI Group, Faculty of Applied Physics,
% Delft University of Technology,
% Lorentzweg 1, 2628 CJ Delft, The Netherlands
%
% Wenxiu Wang, April,2023.

X_inAll = cell(Repeattimes, 1);

for JK = 1:Repeattimes
    % generate random initial input data for JRMPC
    az = 2*pi*rand(1,K);
    el = 2*pi*rand(1,K);
    Xin = [cos(az).*cos(el); sin(el); sin(az).*cos(el)];
    X_inAll{JK} = Xin;
end

end
