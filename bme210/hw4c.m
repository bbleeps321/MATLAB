% HW 4 Part 2 Section 3.
% Minimizes the objective function O(V,K) with respect to
% both parameters using MATLAB's fminsearch function.
function hw4c()
    % First set up given data:
    td = [1 3 5 14 18 24];
    data(1,:) = [0.489685 .386849 .316341 .110217 6.52e-02 2.75e-02];
    data(2,:) = [0.265321 .202436 .176838 .101266 .0796 .0552];
    data(3,:) = [.485949 .574634 .410763 .241312 .122885 .0944];
    data(4,:) = [.334405 .22657 .216041 .0898 .0599 .0447];
    
    D = 10;         % Dosage
    a1 = [.1 25];   % Initial guess (same for all)
    a = zeros(2,1); % Store vector of result pairs. 
                    % Ki = a(1,i), Vi = a(2,i).
    t = 0:.01:24;   % Time range for plotting prediction
    
    % Call fminsearch for each data set
    for (i=1:size(data,1))
        [aval fval(i)] = fminsearch(@(a) f(a,D,td,data(i,:)),a1);
        a(:,i) = aval;
        % Plot results
        subplot(2,2,i);
        plot(td,data(i,:),'ko');                % Plot data
        hold on;
        axis([0 24 0 .8]);
        title(sprintf('Subject %d',i));
        xlabel('Time (hr)');
        ylabel('Concentration (mg/L)');
        plot(t,(D/a(2,i))*exp(-a(1,i)*t),'r');     % Plot prediction
        
        % Display final K value.
        fprintf('Subject %d:\n',i);
        fprintf('\tK = %f\n',a(1,i));
        fprintf('\tV = %f\n',a(2,i));
    end
    
    % Display average K,V value.
    fprintf('Average value of K = %f\n',mean(a(1,:)));
    fprintf('Average value of V = %f\n',mean(a(2,:)));

end

% The function we want to find the root of: dO/dK
% t is the times, z is the actual measurements (must be same length).
% In this, a(1) = K, a(2) = V.
function y = f(a,D,t,z)
    y = sum((z - (D/a(2))*exp(-a(1)*t)).^2);
end