%% Find threshold for counting the number of RNA dot

%% Read image from a directory
img_path = get_img_path();

% Read the image
img = imread(img_path);
% Laplacian of Guassian filter on the image
img_d = double(img);
img_filtered = LOG_filter(img_d);
% Normalize img2
img_filtered = img_filtered/max(img_filtered(:));

%% Plot histogram of the image for threshold intensity selection
tune_spot_counting = false;

if tune_spot_counting ~= 0
plot_spot_threshold(img_filtered)
end

%% RNA Count for each segmented region
threshold = 0.03;
[count, stats] = count_segmentation(L, img, threshold, 0.3); 

%% Save data to csv file
