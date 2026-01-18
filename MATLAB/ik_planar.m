function [qs, reachable] = ik_planar(xy, L)
% IK_2LINK_TRIG Closed-form IK for 2-link planar robot 
% (no end-effector orientation)
% Inputs:
% xy: [x; y] desired position
% L: [L1; L2]
% Outputs:
% qs: 2x2 matrix where columns are two solutions [q1; q2]
% reachable: logical
x = xy(1); y = xy(2); L1 = L(1); L2 = L(2);
r2 = x^2 + y^2; r = sqrt(r2);
% check reachability
reachable = (r <= (L1 + L2) + 1e-12) && (r >= abs(L1 - L2) - 1e-12);
% compute cos(q2)
c = (r2 - L1^2 - L2^2) / (2 * L1 * L2);
% clamp numerical noise
c = max(-1, min(1, c));
% possible sine values
s = sqrt(max(0, 1 - c^2));
q2a = atan2( s, c );
q2b = atan2(-s, c );
phi = atan2(y, x);
psi_a = atan2( L2 * sin(q2a), L1 + L2 * cos(q2a) );
psi_b = atan2( L2 * sin(q2b), L1 + L2 * cos(q2b) );
q1a = phi - psi_a;
q1b = phi - psi_b;
qs = [q1a, q1b; q2a, q2b];
end
