function [BW] = remove_cc(BW, L, x)
% This function remove connected components from binary mask
%
% BW = binary mask
% L = label Matrix after watershed segementation
% x = array of label to remove from the binary mask

for i=1:length(x)
    BW(L==x(i)) = 0;
end
end

