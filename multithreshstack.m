function nout = multithreshstack(ims)
% Normalize image
ims = ims/max(ims(:));

% Number of thresholds to compute
npoints = 100;

fprintf('Computing threshold (of %d):    1',npoints);

for i = 1:npoints
  % Apply threshold
  bwl = ims > i/npoints;

  % Find particles
  [lab,n] = bwlabeln(bwl);  

  % Save count into variable nout
  nout(i) = n;

  fprintf('\b\b\b%3i',i);
end
fprintf('\n');
end

