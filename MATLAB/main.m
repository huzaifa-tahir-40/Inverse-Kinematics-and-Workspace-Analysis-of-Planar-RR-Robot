clc; clear; close all;

L1 = 10; L2 = 10;
L = [L1; L2];
x = 19.8322;
y = 2.5775;
xy = [x; y];
q = ik_planar(xy, L);
qa = q(:,1);
qb = q(:,2);

figure; grid; axis equal; hold on;
plot_planar_robot(qa, L, 'r');
pts = workspace_scatter(L);
figure; grid; axis equal; hold on;
plot_planar_robot(qb, L, 'b');
workspace_scatter(L);

disp("Angles : ");
disp("Down Configuration:");
disp(rad2deg(qa));
disp("Up Configuration: ");
disp(rad2deg(qb));

%% Max and Min
n = vecnorm(pts);
[maxNorm, idxMax] = max(n);
[minNorm, idxMin] = min(n);
p_max = pts(:, idxMax);

p_min = pts(:, idxMin);
