function hw2a()
    t0 = 0;     % Start and end times in minutes
    tf = 1/60;
    h = 1/60000;  % Step size
    L(1) = 12;  % Initial conditions (in uM)
    R(1) = 12;
    D(1) = 12;
    LR(1) = 0;
    LD(1) = 0;
    % Rate constants
    k = [600 6000 28.8 .288 600 60 .6 .6];

    t = t0:h:tf;    % time scale
    % Solve with RK2 method
    % Let L_ denote the value of L at t + h/2.
    for (i=1:length(t)-1)
%         % get midpoint values
%         L_ = L(i) + .5*h*dLdt(L(i),R(i),D(i),LR(i),LD(i),k);
%         R_ = R(i) + .5*h*dRdt(L(i),R(i),D(i),LR(i),LD(i),k);
%         D_ = D(i) + .5*h*dDdt(L(i),R(i),D(i),LR(i),LD(i),k);
%         LR_ = LR(i) + .5*h*dLRdt(L(i),R(i),D(i),LR(i),LD(i),k);
%         LD_ = LD(i) + .5*h*dLDdt(L(i),R(i),D(i),LR(i),LD(i),k);
%         
%         % get next value by using slope
%         L(i+1) = L(i) + h*dLdt(L_,R_,D_,LR_,LD_,k);
%         R(i+1) = R(i) + h*dRdt(L_,R_,D_,LR_,LD_,k);
%         D(i+1) = D(i) + h*dDdt(L_,R_,D_,LR_,LD_,k);
%         LR(i+1) = LR(i) + h*dLRdt(L_,R_,D_,LR_,LD_,k);
%         LD(i+1) = LD(i) + h*dLDdt(L_,R_,D_,LR_,LD_,k);
    end
    
    subplot(2,2,1);
    plot(t,R);
    title('Concentration of R vs Time');
    xlabel('t (min)');
    ylabel('[R] (\muM)');
    
    subplot(2,2,2);
    plot(t,D);
    title('Concentration of D vs Time');
    xlabel('t (min)');
    ylabel('[D] (\muM)');
    
    subplot(2,2,3);
    plot(t,LR);
    title('Concentration of LR vs Time');
    xlabel('t (min)');
    ylabel('[LR] (\muM)');
    
    subplot(2,2,4);
    plot(t,LD);
    title('Concentration of LD vs Time');
    xlabel('t (min)');
    ylabel('[LD] (\muM)');
end

function y = f(L,R,D,LR,LD,k)
    y(1) = k(2)*LR+k(6)*LD+k(8)*L*D-(k(1)+k(7))*L*R-k(5)*L*D;
    y = k(2)*LR+k(8)*L*D-(k(1)+k(7))*L*R;
    y = k(6)*LD+k(7)*L*R-(k(5)+k(8))*L*D;
    y = k(1)*L*R+k(4)*LD-(k(2)+k(3))*LR;
    y = k(3)*LR+k(5)*L*D-(k(4)+k(6))*LD;
end

% % Returns the rate dL/dt based on the coupled differential equations model.
% function y = dLdt(L,R,D,LR,LD,k)
%     y = k(2)*LR+k(6)*LD+k(8)*L*D-(k(1)+k(7))*L*R-k(5)*L*D;
% end
% 
% % Returns the rate dR/dt based on the coupled differential equations model.
% function y = dRdt(L,R,D,LR,LD,k)
%     y = k(2)*LR+k(8)*L*D-(k(1)+k(7))*L*R;
% end
% 
% % Returns the rate dD/dt based on the coupled differential equations model.
% function y = dDdt(L,R,D,LR,LD,k)
%     y = k(6)*LD+k(7)*L*R-(k(5)+k(8))*L*D;
% end
% 
% % Returns the rate dLR/dt based on the coupled differential equations model.
% function y = dLRdt(L,R,D,LR,LD,k)
%     y = k(1)*L*R+k(4)*LD-(k(2)+k(3))*LR;
% end
% 
% % Returns the rate dLD/dt based on the coupled differential equations model.
% function y = dLDdt(L,R,D,LR,LD,k)
%     y = k(3)*LR+k(5)*L*D-(k(4)+k(6))*LD;
% end