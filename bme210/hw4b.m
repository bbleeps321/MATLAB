% For HW4 Part 2 Section 2.
% Minimizes the objective function O(K,25) for the given data set
% to fit a model to the data. Uses the secant method to find the 
% root of O(K,25).
function hw4b()
    % First set up given data:
    td = [1 3 5 14 18 24];
    data(1,:) = [0.489685 .386849 .316341 .110217 6.52e-02 2.75e-02];
    data(2,:) = [0.265321 .202436 .176838 .101266 .0796 .0552];
    data(3,:) = [.485949 .574634 .410763 .241312 .122885 .0944];
    data(4,:) = [.334405 .22657 .216041 .0898 .0599 .0447];

    % Constants
    % For this part, we assume V = 25 for all cases.
    D = 10;
    V = 25.315910;
    
    % Store matrix of K's. Each row of the K matrix matches one data set.
    K = zeros(1,1);
    Kf = zeros(1,1);    % final K values
    guesses = [.1 .05; .1 .05; .2 .05; .03 .05];
    
    % Set to keep iterating until this close to 0.
    eps = 1e-5;    
    t = 0:.01:24;    % time range for plotting prediction

    % For each of the data sets (each row).
    for (i=1:size(data,1))
        n = 2;      % Start at n = 2.
        K(i,1:2) = guesses(i,:); % Initial guesses
        f_n = f(K(i,n),V,D,td,data(i,:));          % f with K_n (n=2)
        while (abs(f_n) > eps)
            f_n_minus1 = f(K(i,n-1),V,D,td,data(i,:));  % f with K_n-1
            K(i,n+1) = K(i,n) - f_n*(K(i,n)-K(i,n-1))/(f_n - f_n_minus1);
            f_n = f(K(i,n+1),V,D,td,data(i,:));         % reevaluate f_n
            n = n+1;    % increment n
        end        
        Kf(i) = K(i,end);        
        % Plot results
        subplot(2,2,i);
        plot(td,data(i,:),'ko');                % Plot data
        hold on;
        axis([0 24 0 .8]);
        title(sprintf('Subject %d',i));
        xlabel('Time (hr)');
        ylabel('Concentration (mg/L)');
        plot(t,(D/V)*exp(-Kf(i)*t),'r');     % Plot prediction
        
        % Display final K value.
        fprintf('K Value for Subject %d = %f\n',i,Kf(i));
    end
    
    % Display average K value.
    fprintf('Average value of K = %f\n',mean(Kf));
end

% The function we want to find the root of: dO/dK
% t is the times, z is the actual measurements (must be same length).
function y = f(K,V,D,t,z)
    y = sum(z.*t.*exp(-K*t)) - (D/V)*sum(t.*exp(-2*K*t));
end