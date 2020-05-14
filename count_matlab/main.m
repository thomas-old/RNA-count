close all
clear all

%% Global parameters

addpath('functions')

tune_segmentation = true;
tune_spot_counting = true;

%% Read image from a directory
[file,path] = uigetfile('*.tif');
if isequal(file,0)
    disp('User selected Cancel');
else
    disp(['User selected ', fullfile(path,file)]);
end

% Read the image
img = imread(append(path,file));
img_gray = rgb2gray(img);
img_adjusted = imadjust(img_gray);

% Laplacian of Guassian filter on the image
img_filtered = imgaussfilt(img_adjusted,4);

%% Thresholding
if tune_segmentation ~= 0
    plot_seg_threshold(img);
end

%% Choose a threshold level
threshold = 50;
[~,BW] = mask(threshold, img_filtered, 15, 10);
plot_cc(BW, img);

%% Remove Small Objects
CC = bwconncomp(BW);
stats = regionprops(BW,'all');
radius = 800;
L = labelmatrix(CC);

BW = ismember(L, find([stats.Area] >= radius));

[L,~] = plot_cc(BW, img);

%% Manually remove CC
c_list = [2 15];
BW2 = remove_cc(BW, L, c_list);

plot_cc(BW2, img);

%% Image region segmentation
D = bwdist(BW2);
L = watershed(D);
plot_water(L, img);

%% Connect components
L(L==7) = 5;
L(L==6) = 1;img_binary
L(L== 12) = 9;
L(L== 4) = 9;
L(L== 11) = 3;
L(L== 8) = 10;

%% Plot new region segmmentation

stats = regionprops(L,'all');

plot_water(L, img);
Lrgb = label2rgb(L,'jet','w','shuffle');
figure
imshow(img)
hold on
himage = imshow(Lrgb);
himage.AlphaData = 0.3;
title('Colored Labels Superimposed Transparently on Original Image')

%% Find threshold for counting the number of RNA dot

[file,path] = uigetfile('*.tif');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
end

tune_spot_countintg = true;

% Read the image
img = imread(append(path,file));
% Laplacian of Guassian filter on the image
img_d = double(img);
img_filtered = LOG_filter(img_d);
% Normalize img2
img_filtered = img_filtered/max(img_filtered(:));

if tune_spot_counting ~= 0
plot_spot_threshold(img_filtered)
end


%% RNA Count for each segmented region
threshold = 0.04;
[count, stats] = count_segmentation(L, img, threshold); 

%% Save data to csv file