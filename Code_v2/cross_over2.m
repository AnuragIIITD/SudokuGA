function [ population, fitness_mat, fitness_net ] = cross_over2( population, fitness_mat, fitness_net )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

m = size(fitness_mat{1,1},2);
n = sqrt(m);
popSize = size(population,2);

% Generate the two children
child = cell(1, 2);
child_fit_matrix = cell(1, 2);
child_fitness = zeros(1, 2);
fitnessBlockArray = zeros(size(population,2),m);
fitnessBlock = cell(size(population));
for i = 1:size(population,2)
    fitnessBlock{i}  = getFitnessBlock(fitness_mat{1,i});
    fitnessBlockArray(i,:) = reshape(fitnessBlock{i}', [1 size(fitnessBlock{i},1)*size(fitnessBlock{i},2)]);
end

fitnessBlockArrayIdx = zeros(size(fitnessBlockArray));
for i = 1:m
    [~,fitnessBlockArrayIdx(:,i)] = sort(fitnessBlockArray(:,i));
end

for i = 1:size(population,2)
    childBlock = reshape(fitnessBlockArrayIdx(i,:),[n  n])';    
    child{i} = makeChild(population,childBlock);
    child_fit_matrix{i} = findFitness(child{i});
    child_fitness(i) = sum(child_fit_matrix{i}(:));
end


population = [population,child];
fitness_mat = [fitness_mat,child_fit_matrix];
fitness_net = [fitness_net,child_fitness];

[~,Idx] = sort(fitness_net);

population = population(Idx(1:popSize));
fitness_mat = fitness_mat(Idx(1:popSize));
fitness_net = fitness_net(Idx(1:popSize));

end

function child = makeChild(population,childBlock)
m = sqrt(size(population{1},2));
n = sqrt(m);
child = zeros(m);
x = 1;
for i = 1:n:m-n+1   
    y = 1;
    for j = 1:n:m-n+1
    sudoku = unwrapSudoku(population{childBlock(x,y)});    
    child(i:i+n-1,j:j+n-1)= sudoku(i:i+n-1,j:j+n-1);
    y = y + 1;
    end
    x = x + 1;
end
child = wrapSudokuToGridArrays( child );
end


function fitnessBlock  = getFitnessBlock(fitnessMat)
fitnessBlock = zeros(sqrt(size(fitnessMat)));
filter = ones(size(fitnessBlock));
stride = size(fitnessBlock);
x = 1;

for i = 1 : stride(1) : size(fitnessMat,1)
    y = 1;
    for j = 1 : stride(2) : size(fitnessMat,2)
        fitnessBlock(x,y) = sum(sum(fitnessMat(i:i+stride(1)-1,j:j+stride(2)-1).* filter));
        y = y +1;
    end
    x = x + 1;
end

end


