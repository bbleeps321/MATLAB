function img_out = samplehold_img(img, p, q)
    img_out = zeros([p q].*size(img));
    for (i=1:length(img(:,1)))  % rows
        for (j=1:length(img(1,:)))  % cols
            img_out(1+(i-1)*p+(0:p-1),1+(j-1)*q+(0:q-1)) = img(i,j);
        end
    end
end