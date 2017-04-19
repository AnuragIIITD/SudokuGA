close all; 
% clear all;


rng('shuffle', 'twister')

% profile on
tic
num_epochs = 10000;
n = 4;
m = n*n;
% Input a sudoku (now manually)
load hexadocu1.mat
% sudoku_in = [0,0,4,3,0,0,2,0,9,0,0,5,0,0,9,0,0,1,0,7,0,0,6,0,0,4,3,0,0,6,0,0,2,0,8,7,1,9,0,0,0,7,4,0,0,0,5,0,0,8,3,0,0,0,6,0,0,0,0,0,1,0,5,0,0,3,5,0,8,6,9,0,0,4,2,9,1,0,3,0,0];
sudoku_in = a;
sudoku_in = transpose(reshape(sudoku_in, m, m));        % Transform into a matrix

sudoku = wrapSudokuToGridArrays(sudoku_in);             % Transform into 1-D array of 3x3 grids
givens = sudoku ~= 0;                                   % Givens are designated by '1'
Threshold = 0;
numSlopePoints = 5;
slopeThreshold = 0.5;

% Initialize a popultion of sudokus
pop_size = 20;
sudoku_pop = cell(1, pop_size);
fitness_matrix = cell(1, pop_size);
net_fitness = zeros(1, pop_size);
for i=1:pop_size
    sudoku_pop{i} = initializeSudoku(sudoku, givens);
    fitness_matrix{i} = findFitness(sudoku_pop{i});
    net_fitness(i) = sum(fitness_matrix{i}(:));
end
% Sort the population by fitness value
[net_fitness, net_fitness_idx] = sort(net_fitness);
sudoku_pop = sudoku_pop(net_fitness_idx);
fitness_matrix = fitness_matrix(net_fitness_idx);

% Perform cross-over and mutation to generate new population
fit_max = zeros(1, num_epochs);
for i=1:num_epochs
    [sudoku_pop, fitness_matrix, net_fitness] = cross_over(sudoku_pop, fitness_matrix, net_fitness);
    [sudoku_pop] = mutation(sudoku_pop, fitness_matrix, givens);
    for j=1:size(sudoku_pop,2)
        fitness_matrix{j} = findFitness(sudoku_pop{j});
        net_fitness(j) = sum(fitness_matrix{j}(:));
    end
    
    fit_max(i) = net_fitness(find(net_fitness==min(net_fitness),1));    
    
    if(i > numSlopePoints)
        
        slope = max(fit_max(i-numSlopePoints:i)) - min(fit_max(i-numSlopePoints:i));
        
        
        if(slope <= slopeThreshold)
            %% Reset the population
            disp('Resetting Population ...')
            bestChild = sudoku_pop{net_fitness==fit_max(i)};
            for j=1:pop_size
                sudoku_pop{j} = initializeSudoku(sudoku, givens);
                fitness_matrix{j} = findFitness(sudoku_pop{j});
                net_fitness(j) = sum(fitness_matrix{j}(:));
            end
            sudoku_pop{1} = bestChild;            
        end
    end
    
  if(min(net_fitness)<=Threshold)
   disp('Sudoku Solved !!')
   solution = sudoku_pop{find(net_fitness==min(net_fitness),1)};
   solvedSudoku = unwrapSudoku(solution);
   inputSudoku = unwrapSudoku(sudoku);
   disp('Input Sudoku :')
   disp(inputSudoku)
   disp('Solution :')
   disp(solvedSudoku)
   break; 
  end  
    
end
toc
% profile viewer
% Plot max fitness per epoch
plot(1:num_epochs, fit_max); xlabel('Epochs'); ylabel('Max fitness'); title('Fitness with epoch - With Mutation');

% sudoku_out = unwrapSudoku(sudoku);