function plot_spot_threshold(img_filtered)
%PLOT_SPOT_THRESHOLD Summary of this function goes here
%   Detailed explanation goes here
% This function call will find the number of mRNAs for all thresholds
thresholdfn = multithreshstack(img_filtered);

% These are the thresholds
thresholds = (1:100)/100;


% Let's plot the threshold as a function of the number of mRNAs
figure(2)
plot(thresholds, thresholdfn);
xlabel('Threshold');
ylabel('Number of spots counted');

title('Click at appropriate x/threshold value and hit return')

[x,~] = getpts;
line([x x],[0 4000]);

x = round(x*100);  % 100 is the number of thresholds
% number_of_mrna = thresholdfn(x);

for n=1:length(x)
    img_binary = im2bw(img_filtered, x(n)/100);
    [~,~,N,~] = bwboundaries(img_binary);
    figure
    imshow(img_binary)
    title(['RNA spot counted: ',num2str(N),' for threshold of: ',num2str(x(n)/100)])
end

end

