% Takes a hamming code block (7,4) and read the data.
% Makes any necessary error corrections.
function data = readHammingCode(block)
blockData = block(4:7);
blockr = block(1:3);

% get what the block should be if the data is correct
correct = createHammingCode(blockData);

% if matches, everything is good, stop here
if (correct(1:3) == blockr(1:3))
    data = blockData;
    return;
end

% error, need to find it
if (blockr(1) ~= correct(1) && blockr(2) ~= correct(2))
end

data = [0 0 0 0];
    

end