function [BW] = remove_cc(BW, L, x)
%REMOVE_CC Summary of this function goes here
%   Detailed explanation goes here
for i=1:length(x)
    BW(L==x(i)) = 0;
end
end

