function img = reconstructImage(A,m,n,mm,nn)
    img = zeros(mm,nn);
    blocksPerCol = mm-m+1;
    for col = 1:size(A,2);
        block = reshape(A(:,col),m,n);
        i = 1+mod(col-1,blocksPerCol);
        j = 1+floor((col-1)/blocksPerCol);
        img(i:i+m-1,j:j+n-1) = img(i:i+m-1,j:j+n-1) + block;
    end

    div = 3*ones(mm,nn);
    div(1,:) = div(1,:) - 1;
    div(:,1) = div(:,1) - 1;
    div(end-m+1:end,:) = div(end-m+1:end,:) - 1;
    div(:,end-n+1:end) = div(:,end-n+1:end) - 1;
    
    img = img./div;
end