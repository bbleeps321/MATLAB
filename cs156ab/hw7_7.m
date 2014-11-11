clear; close all;
p = [sqrt(sqrt(3)+4) sqrt(sqrt(3)-1) sqrt(9+4*sqrt(6)) sqrt(9-sqrt(6))];
for (i=1:length(p))
    D = [-1 0; p(i) 1; 1 0];
    
end