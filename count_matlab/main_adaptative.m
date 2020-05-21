close all
clear all

%% Global parameters

addpath('functions')

%% Read image from a directory
[file,path] = uigetfile('*.tif');
if isequal(file,0)
    disp('User selected Cancel');
else
    disp(['User selected ', fullfile(path,file)]);
end

% Read the image
img = imread(strcat(path,file));
img_gray = rgb2gray(img);
img_adjusted = imadjust(img_gray);

% Guassian filter on the image
img_filtered = imgaussfilt(img_adjusted,4);

%% Adaptative thresholding 
T = adaptthresh(img_filtered, 0.4);
BW = imbinarize(img_filtered,T);
figure
imshowpair(img_filtered, BW, 'montage')

%% Otsu thresholding 

[counts,x] = imhist(img_filtered,32);
stem(x,counts)

T = otsuthresh(counts);
BW = imbinarize(img_filtered,T);
figure
imshowpair(img_filtered, BW, 'montage')

%% Gray thresholding 
T = graythresh(img_filtered);
BW = imbinarize(img_filtered,T);
figure
imshowpair(img_filtered, BW, 'montage')
