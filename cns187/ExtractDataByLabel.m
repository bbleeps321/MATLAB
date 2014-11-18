% Extracts data from MNIST structs for training. First N/2 of each or all.
function [X,y] = ExtractDataByLabel(st,y0,y1,N)
idx1 = find(st.labels==y1)';
idx0 = find(st.labels==y0)';
if nargin < 4
    idx = sort([idx1 idx0]);
else
    idx = sort([idx1(1:N/2) idx0(1:N/2)]);
end
y = st.labels(idx)';
temp = st.data(:,:,idx);
X = reshape(temp,28*28,size(temp,3)); % Reshape image to vector form