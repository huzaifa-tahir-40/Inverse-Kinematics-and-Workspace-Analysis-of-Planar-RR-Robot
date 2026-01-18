function [p, T02] = fkine_2link(q, L)
% FKINE_2LINK forward kinematics for a 2-link planar robot
% q: [q1; q2] (radians)
% L: [L1; L2] (meters)
% p: 2x1 end-effector position in world frame
% T02: 3x3 homogeneous transform from base to end-effector

% Segmenting q and L to use trchain2()
q1 = q(1); q2 = q(2);
L1 = L(1); L2 = L(2);

T02 = trchain2('R(q1) Tx(L1) R(q2) Tx(L2)', [q1 q2]);
p = T02(1:2,3);

end

