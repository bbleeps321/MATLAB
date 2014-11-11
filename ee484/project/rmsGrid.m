% Calculates a grid of RMS position error for the specified vectors of xy
% grid coordinates and using the specified tower positions matrix.
%
% x - vector of x coordinates
% y - vector of y coordinates
% towers - matrix of towers, defined column wise, where first row is
%          latitude, second row is longitude, and third row is altitude.
function rms = rmsGrid(x, y, towers)
    rms = zeros(length(x),length(y));
    
    % Convert tower positions to xyz coordinates.
    for (i = 1:size(towers,2))
        [N E] = ell2utm(towers(1,i),towers(2,i));
        towers(1:2,i) = [N;E];
    end
    
    % For each position, calculate RMS error.
    % We're assuming 0 time bias since we only care about PDOP.
    for (i = 1:length(x))
        for (j = 1:length(y))
            x0 = [x(i);y(j)];
            G = makeG(towers,x0);
            H = inv(G'*G);
            rms(i,j) = sqrt(trace(H));
        end
    end            
end