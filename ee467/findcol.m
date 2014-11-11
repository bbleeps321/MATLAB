% Returns the index in the matrix of the column that matches the 
% specified column.
function col = findcol(M,c)
    col = find(ismember(M',c','rows'),1);
end