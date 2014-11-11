%4.6
secs = input('Seconds = ');
mins = fix(secs/60);
hours = fix(mins/60);
mins = rem(mins, 60);
secs = rem(secs, 60);
disp([hours mins secs]);
