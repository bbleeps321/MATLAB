% Homework 1
function hw1()
    clear, close all, clc;

    % Load image into grayscale and as 256x256 double matrix
    myImg = rgb2gray(double(imread('mk1.png')));
    figure; imshow(myImg); title('Original Image');

    % Create 2D Gaussian PSF and display
    psf = fspecial('gaussian',256,5);
%     meshPlot(psf, '2D Gaussian PSF');

    % Simulate produced image through Fourier methods
    imgFFT = fft2(myImg);
    psfFFT = fft2(psf);
%     meshPlot(abs(fftshift(imgFFT)), 'FFT of Image');
%     meshPlot(abs(fftshift(psfFFT)), 'FFT of PSF');
    imgOutFFT = imgFFT.*psfFFT;
%     meshPlot(abs(imgOutFFT), 'FFT of Output Image');
    imgOut = ifftshift(ifft2(imgOutFFT));
    imgOut = imgOut/max(max(imgOut));   % normalize
    figure; imshow(abs(imgOut)); title('Output Image');
    
    % Add white noise for SNR of ~10
    % SNR = 10 = 1/sqrt(v) => v = 0.01
    imgNoise = imnoise(myImg, 'gaussian', 0, 0.01);
    figure; imshow(imgNoise); title('Image with Noise');
    
    % Low pass Filter with Gaussian PSF
    imgNoiseOutFFT = fft2(imgNoise).*psfFFT;
    imgNoiseOut = ifftshift(ifft2(imgNoiseOutFFT));
    imgNoiseOut = imgNoiseOut/max(max(imgNoiseOut)); % normalize
    figure; imshow(abs(imgNoiseOut)); title('Filtered Image');
end

function meshPlot(y, label)
    figure;
    mesh(y);
    title(label);
    axis([0 256 0 256 0 max(max(y))]);
end