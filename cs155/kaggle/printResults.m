function printResults(name,id,pred)
fid = fopen(name,'w');

fprintf(fid,'Id,Prediction\n');
for i = 1:length(id)
    fprintf(fid,'%d,%d\n',id(i),pred(i));
end

fclose(fid);