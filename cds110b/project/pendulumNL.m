function [sys,x0,str,ts] = pendulumNL(t,x,u,flag)
switch flag
    case 0
        [sys,x0,str,ts] = initstates();
    case 1
        sys = derivatives(t,x,u);
    case 3
        sys = outputs(t,x,u);
    case { 2, 4, 9 },
        sys = [];
    otherwise
        DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end

function [sys,x0,str,ts] = initstates()
    sizes = simsizes;
    sizes.NumContStates = 4;
    sizes.NumDiscStates = 0;
    sizes.NumOutputs = 4;
    sizes.NumInputs = 1;
    sizes.DirFeedthrough = 1;
    sizes.NumSampleTimes = 1;
    sys = simsizes(sizes);
    x0 = .5*ones(4,1);
    str = [];
    ts = [0 0];

function [sys,x0,str,ts] = derivatives(t,x,u)
    M = 10; m = 1; g = 9.8; L = 10;
    d = m+M-m*cos(x(2))^2;
    sys = zeros(4,1);
    sys(1) = x(3);
    sys(2) = x(4);
    sys(3) = (u+L*m*x(4)^2*sin(x(2))-g*m*cos(x(2))*sin(x(2)))/d;
    sys(4) = (-u*cos(x(2))-L*m*x(4)^2*cos(x(2))*sin(x(2))+g*(M+m)*sin(x(2)))/(d*L);

function [sys,x0,str,ts] = outputs(t,x,u)
    sys = x;