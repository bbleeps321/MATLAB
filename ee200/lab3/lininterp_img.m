function img_out = lininterp_img(img, p, q)
    % rows
    N = [1:length(img(:,1))]';
    NN = [1:1/p:length(img(:,1))]';
    img_out = interp1(N,img,NN);
    % columns
    N = [1:length(img(1,:))]';
    NN = [1:1/q:length(img(1,:))]';
    img_out = interp1(N,img_out',NN)';
    disp(size(img_out));
end