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

%% Read the image and stack up the file 
img_path = strcat(path,file);

info = imfinfo(img_path);
num_images = numel(info);
A = imread(img_path, 1, 'Info', info);

tiff_stack = imadjust(A);
for k = 2:num_images
    A = imread(img_path, k, 'Info', info);
    img_adjusted = imadjust(A);
    tiff_stack = cat(3, tiff_stack, img_adjusted);
end

figure
imshow(tiff_stack)
