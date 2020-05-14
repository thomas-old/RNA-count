function plot_water(L, image)
%WATER Summary of this function goes here
%   Detailed explanation goes here

stats = regionprops(L,'all');
figure
imshowpair(label2rgb(L,'jet','w'), image, 'montage')

% Plot the label
centroids = cat(1, stats.Centroid);
for k = 1 : size(centroids,1)
    H= text(centroids(k,1), centroids(k,2),[num2str(k)]);
    set(H,'Color',[0 0 0], 'FontSize', 13)
end
hold off
end

