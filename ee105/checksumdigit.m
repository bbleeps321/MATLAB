function csd = checksumdigit(c)
    
    odds = sum(c(1:2:11));
    evens = sum(c(2:2:11));
    csd = mod(210 - 3*odds - evens,10);

end