% Draws image (vector form) in a new or existing figure.
function drawMNISTImage(image,hFigure)

if nargin < 2
    figure;
else
    figure(hFigure);
end

imshow(reshape(image,28,28));