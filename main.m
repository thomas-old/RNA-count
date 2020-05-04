

%% Read image from a directory 
file = uigetfile('*.tif');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
end

% Read the image
img = imread(file);
% Int to double 
img_d = double(img);
% Laplacian of Guassian filter on the image
img2 = LOG_filter(img_d);
% Normalize img2
img2 = img2/max(img2(:));

% Plot the original image and the laplacian of the image
figure(1)
imshowpair(img, img2,'montage');

%% Find threshold for counting the number of RNA dot

% This function call will find the number of mRNAs for all thresholds
thresholdfn = multithreshstack(img2);

% These are the thresholds
thresholds = (1:100)/100;

% Let's plot the threshold as a function of the number of mRNAs
figure(2)
plot(thresholds, thresholdfn);
xlabel('Threshold');
ylabel('Number of spots counted');
% Zoom in on important area
ylim([0 1000]);

%% Count the number of dots for a specific threshold

title('Click at appropriate x/threshold value and hit return')

[x,y] = getpts;
line([x x],[0 4000]);

x = round(x*100);  % 100 is the number of thresholds
number_of_mrna = thresholdfn(x)

img_binary = im2bw(img2, x/100);
figure(3)
imshow(img_binary)