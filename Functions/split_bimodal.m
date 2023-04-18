function [x1, y1, x2, y2] = split_bimodal(x, y)
% Find the peaks and valleys in y
[pks, locs] = findpeaks(y);
[valleys, idx] = min(y(min(locs):max(locs)));
split_idx = idx+min(locs);
% Split x and y into two parts
x1 = x(1:split_idx);
y1 = y(1:split_idx);
x2 = x(split_idx+1:end);
y2 = y(split_idx+1:end);
end
