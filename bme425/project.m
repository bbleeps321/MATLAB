function project
    clear, close all, clc;
    img = rgb2gray(double(imread('project.png')));
    
    n = size(img,1);
    
    % Mother wavelet form
    qmf = MakeONFilter('Haar');
    
    % Wavelet Transform, one dimension at a time
    temp = zeros(n);
    imgWT = zeros(n);
    for (i=1:n)
        temp(:,i) = FWT_PO(im	g(:,i),1,qmf);
    end
    for (i=1:n)
        imgWT(i,:) = FWT_PO(temp(i,:),1,qmf);
    end
    
    % Partial Inverse
    N = n/2;
    imgWTSmall = imgWT(1:N,1:N);
    imgOutWT = zeros(N);
    temp = zeros(N);
    for (i=1:N)
        temp(:,i) = IWT_PO(imgWTSmall(:,i),1,qmf);
    end
    for (i=1:N)
        imgOutWT(i,:) = IWT_PO(temp(i,:),1,qmf);
    end
    
    imshow(img); title('Original');
    figure; imshow(imgWT); title('Wavelet Transformed Image');
    figure; imshow(imgWT(1:N,1:N));
    figure; imshow(imgOutWT); title('Output - Wavelet Transform');
    
    % Fourier
    imgFT = fftshift(fft2(img));
    range = (n/4+1):(3*n/4);
    imgOutFT = ifft2(imgFT(range,range));
    figure; imshow(real(imgFT)); title('Fourier Transform');
    figure; imshow(real(imgFT(range,range)));
    figure; mesh(log(abs(imgFT))); title('Fourier Transform');
    figure; imshow(abs(imgOutFT)); title('Output - Fourier Transform');
    
    % Error computation
    imgSmall = img(1:2:n, 1:2:n);
    disp('Wavelet Error:');
    disp(sum(sum((imgOutWT-imgSmall).^2)));
    disp('Fourier Error:');
    disp(sum(sum(abs(imgOutFT-imgSmall).^2)));
end