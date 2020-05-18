function [L,BW2] = mask(threshold_level, image, r1, r2)
% This function perform the binary threshold without threshold level on the
% image 
%
% L = label Matrix after watershed segementation
% BW2 = binary mask image of the input
% threshold_level = intensity level for binary thresholding
% image = input image
% r1 = r2 = radius for morphological transformation

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

