close all
clear all

%% Global parameters

addpath('functions')

tune_segmentation = false;
tune_spot_counting = false;

%% Read image from a directory for the DAPI channel for the seed 
[file,path] = uigetfile('*.tif');
if isequal(file,0)
    disp('User selected Cancel');
else
    disp(['User selected ', fullfile(path,file)]);
end

% Read the image
img = imread(append(path,file));
imshow(img)