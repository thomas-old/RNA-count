img = imread('1_CH3.tif');
img_d = double(img);
img2 = LOG_filter(img_d);

% Normalize ims2
img2 = img2/max(img2(:));

figure(1)
imshowpair(img, img2,'montage');

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

% In this case, the appropriate threshold is around 0.23 or so.

% This code helps extract the number of mRNA from the graph

title('Click at appropriate x/threshold value and hit return')

[x,y] = getpts;
line([x x],[0 4000]);

x = round(x*100);  % 100 is the number of thresholds
number_of_mrna = thresholdfn(x)

img_binary = im2bw(img2, x/100);
figure(3)
imshow(img_binary)