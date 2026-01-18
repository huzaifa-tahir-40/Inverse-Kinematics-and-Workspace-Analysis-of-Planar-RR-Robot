function h = plot_planar_robot(q, L, varargin)
% PLOT_PLANAR_ROBOT Draws a planar robot given joint angles and link lengths
% 
% Inputs:
%   q : vector of joint angles (in radians)
%   L : vector of link lengths (in meters)
%   varargin : (optional) color for the robot plot
%
% Example:
%   plot_planar_robot([pi/4, pi/3], [1, 0.5], 'r');

n = numel(q); % Number of joints/links

% Pre-allocate joint positions
% positions(:,k) will store the (x,y) coordinates of the k-th joint
% positions(:,1) = base, positions(:,n+1) = end-effector
positions = zeros(2, n+1); 
T = eye(3);             % Initialize homogeneous transformation matrix (identity)
positions(:,1) = [0;0]; % Base of the robot is at the origin

% Forward kinematics loop to compute joint positions
for i = 1:n
    % Update transformation by applying rotation (joint angle) and translation (link length)
    T = T * trot2(q(i),'rad') * transl2(L(i),0);
    
    % Extract (x,y) position of the current joint/end-effector
    ph = T * [0;0;1];       
    positions(:, i+1) = ph(1:2); % Save joint position
end

% Plot the robot

axis equal; grid on;
xlabel('x (m)'); ylabel('y (m)');

if(nargout > 0)
    if (nargin > 2) % If color is provided
    h = plot(positions(1,:), positions(2,:), '-o', ...
        'LineWidth', 2, 'MarkerSize', 6, 'color', varargin{1});
    else            % Default plot without custom color
    h = plot(positions(1,:), positions(2,:), '-o', ...
        'LineWidth', 2, 'MarkerSize', 6);
    end
else
    if (nargin > 2) % If color is provided
    plot(positions(1,:), positions(2,:), '-o', ...
        'LineWidth', 2, 'MarkerSize', 6, 'color', varargin{1});
    else            % Default plot without custom color
        plot(positions(1,:), positions(2,:), '-o', ...
            'LineWidth', 2, 'MarkerSize', 6);
    end
end

end