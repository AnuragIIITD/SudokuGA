function [ population ] = mutation( population, fitness_mat, givens )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
prob_mat = cell(1,size(population,2));
mutation_mat = cell(1,size(population,2));

n = sqrt(size(population{1},2));
m = n^2;
for i = 1:size(population,2)
prob_mat{i} = logsig(fitness_mat{i});
prob_mat{i}(prob_mat{i} == 0.5) = 0;
mutation_mat{i} = zeros(size(prob_mat{i}));

for i2 = 1 :size(mutation_mat{i},1)
    for j2 = 1 :size(mutation_mat{i},2)
        x=rand;
        if x<prob_mat{i}(i2,j2)
            mutation_mat{i}(i2,j2)=1;
        end
    end
end

mutation_mat{i} = wrapSudokuToGridArrays(mutation_mat{i}).*~givens;    

%% Find swap locaations withing 3X3 grids

for k = 1 : n  :m
    grid  = zeros(1,m);
    grid(k:k+n-1)  = mutation_mat{i}(1,k:k+n-1);
    swapidx = find(grid);
    if(length(swapidx)>1)
    population{i} = cyclicSwap(population{i},swapidx);
    end
end
end
end


%% Perform cyclic swap
function population = cyclicSwap(population,swapidx)
    temp = population(swapidx(1));
    for i = 1:length(swapidx)-1
        population(swapidx(i)) = population(swapidx(i+1));
    end
    population(swapidx(end)) = temp;
end


