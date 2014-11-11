%--------------------------------------------------------------------------
% CDS 110a HW #3, cart-pendulum
% D. MacMynowski 10/10/10
%
% 
%--------------------------------------------------------------------------

function dy = cartpend_model(t, y, M, m, J, g, ell, c, gamma, f)

dy = zeros(4,1);

x = y(1);
theta = y(2);
xdot = y(3);
thetadot = y(4);

dy(1) = xdot;
dy(2) = thetadot;

% solve for second derivative by solving matrix equation
K = [M+m            -m*ell*cos(theta);
    -m*ell*cos(theta)  J+m*ell^2];
F = -(c*xdot + m*ell*sin(theta)*thetadot^2) + f;
G = -(gamma*thetadot-m*g*ell*sin(theta));
ddy = K\[F;G];
dy(3) = ddy(1);
dy(4) = ddy(2);
