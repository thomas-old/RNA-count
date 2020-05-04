%  main program of counting algorithm
%  05/04/2020, Thomas Hu
%  
%  This program counts t he number of mRNA spots in the image file and was
%  adapted frin arjun raj counting mRNA spots matlab script
%  
%  available online at www.math.nyu.edu/~arjunraj/raj_2008_software/
%  

%% Read image from a directory 
[file,path] = uigetfile('*.tif');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
end

% Read the image
img = imread(append(path,file));
% Int to double 
img_d = double(img);
% Laplacian of Guassian filter on the image
img2 = LOG_filter(img_d);
% Normalize img2
img2 = img2/max(img2(:));

% Plot the original image and the laplacian of the image
figure(1)
imshowpair(img, img2,'montage');
title('Original and laplacian of image')

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
ylim([0 1500]);

%% Count the number of dots for a specific threshold

title('Click at appropriate x/threshold value and hit return')

[x,y] = getpts;
line([x x],[0 4000]);

x = round(x*100);  % 100 is the number of thresholds
number_of_mrna = thresholdfn(x);

for n=1:length(x)
img_binary = im2bw(img2, x(n)/100);
[B,L,N,A] = bwboundaries(img_binary);
RGB = label2rgb(L,'jet','k','shuffle'); 
figure
imshow(RGB)
title(['RNA spot counted: ',num2str(N),' for threshold of: ',num2str( x(n)/100)])
end