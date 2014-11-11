% Load data file containing W and s.
load('data');

% Solve for u.
u = W\s;

% Rearrange into 50x50 matrix.
B = reshape(u,50,50)';

% Normalize
B = abs(B/max(max(B)));

% Define RGB triplet matrix.
C = zeros(50,50,3);
C(:,:,1) = B;
C(:,:,2) = B;
C(:,:,3) = B;

% Display image.
image(C);

