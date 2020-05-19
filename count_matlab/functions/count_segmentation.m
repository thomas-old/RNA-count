function [count, stats] = count_segmentation(L, image, threshold, alpha)
% This function perform the bright spot counting on a image specified
% the label matrix of the image and the intensity threshold
%
% count = array of size equal to the number of label in L, each element
% correspond to the number of spot quantified for region l in L
% stats = statistics of each region in L
% 
% L = label matrix obtained from matlab function labelmatrix(CC) 
% image = original image 
% threshold = intensity level for spot counting
%

%% Laplacian of Guassian filter on the image
img_d = double(image);
img3 = LOG_filter(img_d);
% Normalize img2
img3 = img3/max(img3(:));
img_binary = im2bw(img3, threshold);

%% Plot the segmented mask on the original image 

% Lrgb = label2rgb(L,'jet','k','shuffle');
% figure
% imshow(image)
% hold on;
% count = [];
% himage = imshow(Lrgb);
% himage.AlphaData = alpha;
% title('Original Image with segmented region')
% hold off;

%% Plot the spot

[B,~,~,~] = bwboundaries(img_binary);
figure
imshow(image); hold on;
visboundaries(B)
title('RNA spot visualization')
hold off;

%% Plot the count of the spots
stats = regionprops(L,'all');
CC = unique(L);
% 
% figure
% imshow(img_binary)
% title('RNA spot count for each segmented region')
% hold on;

Lrgb = label2rgb(L,'jet','k','shuffle');
figure
imshow(image)
hold on;
count = [];
himage = imshow(Lrgb);
himage.AlphaData = alpha;
title('RNA spot count for each segmented region')
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

