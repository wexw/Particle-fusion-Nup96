function [fwhm, half_max] = calc_fwhm(x, y)
% Calculate full width at half maximum
half_max = max(y)/2;
p1 = find(y > half_max, 1, 'first');
p2 = find(y > half_max, 1, 'last');
fwhm = x(p2) - x(p1);
end
