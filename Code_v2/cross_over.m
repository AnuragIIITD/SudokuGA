function [ population, fitness_mat, fitness_net ] = cross_over( population, fitness_mat, fitness_net, givens )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

m = size(fitness_mat{1,1},2);
n = sqrt(m);
parents = population(1:2);
cross_over_spot = randi(m);

% Generate the two children
child = cell(1, 2);
child_fit_matrix = cell(1, 2);
child_fitness = zeros(1, 2);

for i=1:2
    child{i} = [parents{i}(1 : cross_over_spot*m), parents{3-i}(cross_over_spot*m + 1 : end)];
    child_fit_matrix{i} = findFitness(child{i},givens);
% end
% 
% child = mutation2(child, child_fit_matrix, givens);
% 
% for i=1:2
%     child_fit_matrix{i} = findFitness(child{i},givens);
    
    child_fitness(i) = sum(child_fit_matrix{i}(:));
    
    % Find correct spot for the children
    [~, child_spot] = find(fitness_net >= child_fitness(i), 1);
    if(~isempty(child_spot))
        population(child_spot+1 : end) = population(child_spot : end-1);
        fitness_mat(child_spot+1 : end) = fitness_mat(child_spot : end-1);
        fitness_net(child_spot+1 : end) = fitness_net(child_spot : end-1);
        
        population{child_spot} = child{i};
        fitness_mat{child_spot} = child_fit_matrix{i};        
        fitness_net(child_spot) = child_fitness(i);
    end
end

end

