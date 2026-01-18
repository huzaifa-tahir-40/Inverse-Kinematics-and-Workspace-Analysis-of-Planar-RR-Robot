function pts = workspace_scatter(a)

q1_grid = linspace(0, pi, 80);
q2_grid = linspace(-pi/2, pi/2, 80);
pts = zeros(2, numel(q1_grid) * numel(q2_grid));
idx = 1;
for i = 1:length(q1_grid)
 for j = 1:length(q2_grid)
 p = fkine_2link([q1_grid(i); q2_grid(j)], a);
 pts(:, idx) = p; idx = idx + 1;
 end
end
plot(pts(1,:), pts(2,:), 'bo', 'MarkerSize',1); 

end
