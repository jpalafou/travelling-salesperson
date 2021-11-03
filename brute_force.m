% travelling salesman problem
% author:   jonathan palafoutas
% date:     november 2021

clear
clc
close all

%% input
n = 11; % number of locations
A = 100; % size of map

%% setup
xlocs = A*rand(1,n);
ylocs = A*rand(1,n);

% create distance array D that is the distance between each combination of
% two locations. assume distance is the same between two points regardless
% of the direction of travel
D = zeros(n);
for i = 1:n
    for j = 1:n
        D(i,j) = sqrt(((xlocs(i) - xlocs(j))^2) + ((ylocs(i) - ylocs(j))^2) );
    end
end

% path array 
% row 1: x values
% row 2: y values
% coordinate from left to right is the path of travel
path = zeros(2,n);
path(1,1) = 1;
path(2,end) = 1;

shortest_path = zeros(2,n);
shortest_dist = n*sqrt((A^2)+(A^2)); % longest possible distance

%% main calcs
fprintf('testing permutations:\n')
print_cnt = 1;

path_perms = perms(2:n);
l = length(path_perms);

for i = 1:l
    path(1,2:end) = path_perms(i,:);
    path(2,1:(end-1)) = path_perms(i,:);

    dist = 0;
    
    for j = 1:n
        dist = dist + D(path(2,j),path(1,j));
    end
    
    if dist < shortest_dist
        shortest_dist = dist;
        shortest_path = path;
    end 
    
    if i > print_cnt*l/10
        fprintf('%5i %%\n',10*print_cnt)
        print_cnt = print_cnt + 1;
    end
end

fprintf('%5i %% !\n',100)

%% plotting
plot(xlocs(1),ylocs(1),'r.','MarkerSize',20)
hold on
plot(xlocs(2:end),ylocs(2:end),'k.','MarkerSize',20)
xlim([0,A])
ylim([0,A])
grid on
hold on

for i = 1:n
    plot([xlocs(shortest_path(1,i)) xlocs(shortest_path(2,i))], ...
        [ylocs(shortest_path(1,i)) ylocs(shortest_path(2,i))], 'b--', 'LineWidth', 2) 
end

