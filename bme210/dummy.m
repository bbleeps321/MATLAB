% HW 4 Part 2 Section 3.
% Minimizes the objective function O(V,K) with respect to
% both parameters using MATLAB's fminsearch function.
function dummy()
    % First set up given data:
    global D;
    td = [1 3 5 14 18 24];
    data(1,:) = [0.489685 .386849 .316341 .110217 6.52e-02 2.75e-02];
    data(2,:) = [0.265321 .202436 .176838 .101266 .0796 .0552];
    data(3,:) = [.485949 .574634 .410763 .241312 .122885 .0944];
    data(4,:) = [.334405 .22657 .216041 .0898 .0599 .0447];
    
    D = 10;         % Dosage
    
    K = 0:.01:1;
    V = 0:.1:50;
    fn = 0;
    for (k=1:length(K))
        for (v=1:length(V))
            fn(v,k)=f(K(k),V(v),td,data(1,:));
        end
    end
    [K V] = meshgrid(K,V);
    disp(size(K));
    disp(size(V));
    disp(size(fn));
    mesh(K,V,fn);
end

% The function we want to find the root of: dO/dK
% t is the times, z is the actual measurements (must be same length).
% In this, a(1) = K, a(2) = V.
function y = f(K,V,t,z)
    global D;
    y = sum((z-(D/V)*sum(exp(-K.*t))).^2);
end