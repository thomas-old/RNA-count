function [count, stats] = count_segmentation(L, image, threshold)
%COUNT_SEGMENTATION Summary of this function goes here
%   Detailed explanation goes here

% Laplacian of Guassian filter on the image
img_d = double(image);
img3 = LOG_filter(img_d);
% Normalize img2
img3 = img3/max(img3(:));
img_binary = im2bw(img3, threshold);

stats = regionprops(L,'all');
CC = unique(L);
Lrgb = label2rgb(L,'jet','w','shuffle');
figure
imshow(image)
hold on;
count = [];
himage = imshow(Lrgb);
himage.AlphaData = 0.1;
title('Original Image with segmented region')
hold off;

figure
imshow(img_binary)
title('RNA spot count for each segmented region')
hold on;
% Plot the label
centroids = cat(1, stats.Centroid);
for n = 2 : length(CC)
    k = CC(n);
    mask = (L == k);
    img_binary = im2bw(img3, threshold);
    img_binary(~mask) = 0;
    [~,~,N,~] = bwboundaries(img_binary);
    H= text(centroids(k,1), centroids(k,2),[num2str(N)]);
    set(H,'Color',[1 0 0], 'FontSize', 13)
    count = [count N];
end
hold off
end

