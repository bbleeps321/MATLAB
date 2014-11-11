% Limits values to be 0 or 1, with threshold of 0.5;
function y = bin(x)
    xeven = mod(x,2)==0;
    xodd = mod(x,2)==1;
    xfrac = mod(x,2)~=0 & mod(x,2)~=1;
    x = ones(size(x)).*xodd + zeros(size(x)).*xeven + x.*xfrac;
    y = ones(size(x)).*(x>=.5) + zeros(size(x)).*(x<.5);
end