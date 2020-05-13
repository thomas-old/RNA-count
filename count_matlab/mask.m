function [L,BW2] = mask(threshold_level, image, r1, r2)
%MASK Summary of this function goes here
%   Detailed explanation goes here

if nargin < 3
    r1=25;
    r2=25;
end
%% Threshold
level = threshold_level/256;
BW = imbinarize(image,level);
% figure
% imshow(BW)
% title('Masked image')

%% Morphological transformation
se = strel('disk',r1);

BW2 = imclose(BW,se);

se = strel('disk',r2);
BW2 = imopen(BW2,se);

%% Segmentation
D = bwdist(BW2);
L = watershed(D);
bgm = L == 0;

L(~BW2) = 0;
end

