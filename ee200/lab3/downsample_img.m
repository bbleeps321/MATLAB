function img_out = downsample_img(img, p, q)
    % take every pth row
    pselect=1:p:length(img(:,1));
    img_out = img(pselect,:);
    % take every qth column
    qselect = 1:q:length(img_out(1,:));
    img_out = img_out(:,qselect);
end