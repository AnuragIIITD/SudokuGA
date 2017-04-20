close all; 
% clear all;


rng('shuffle', 'twister')

% profile on
tic
num_epochs = 1000;
n = 4;
m = n*n;
figure;
h = pcolor(256*ones(m));
figure;
h2 = plot(1:num_epochs, 256*zeros(1,num_epochs)); xlabel('Epochs'); ylabel('Max fitness'); title('Fitness with epoch - With Mutation');

% Input a sudoku (now manually)
load hexadocu1.mat
% sudoku_in = [0,0,4,3,0,0,2,0,9,0,0,5,0,0,9,0,0,1,0,7,0,0,6,0,0,4,3,0,0,6,0,0,2,0,8,7,1,9,0,0,0,7,4,0,0,0,5,0,0,8,3,0,0,0,6,0,0,0,0,0,1,0,5,0,0,3,5,0,8,6,9,0,0,4,2,9,1,0,3,0,0];
sudoku_in = a;
sudoku_in = transpose(reshape(sudoku_in, m, m));        % Transform into a matrix

sudoku = wrapSudokuToGridArrays(sudoku_in);             % Transform into 1-D array of 3x3 grids
givens = sudoku ~= 0;                                   % Givens are designated by '1'
Threshold = 0;
numSlopePoints = 50;
slopeThreshold = logspace(1,-1,num_epochs);

% Initialize a popultion of sudokus
pop_size = 5;
sudoku_pop = cell(1, pop_size);
fitness_matrix = cell(1, pop_size);
net_fitness = zeros(1, pop_size);
for i=1:pop_size
    sudoku_pop{i} = initializeSudoku(sudoku, givens);
    fitness_matrix{i} = findFitness(sudoku_pop{i},givens);
    net_fitness(i) = sum(fitness_matrix{i}(:));
end
% Sort the population by fitness value
[net_fitness, net_fitness_idx] = sort(net_fitness);
sudoku_pop = sudoku_pop(net_fitness_idx);
fitness_matrix = fitness_matrix(net_fitness_idx);

% Perform cross-over and mutation to generate new population
fit_max = zeros(1, num_epochs);
for i=1:num_epochs
    [sudoku_pop, fitness_matrix, net_fitness] = cross_over(sudoku_pop, fitness_matrix, net_fitness, givens);
    [sudoku_pop] = mutation2(sudoku_pop, fitness_matrix, givens);
    for j=1:size(sudoku_pop,2)
        fitness_matrix{j} = findFitness(sudoku_pop{j},givens);
        net_fitness(j) = sum(fitness_matrix{j}(:));
    end
    
    fit_max(i) = net_fitness(find(net_fitness==min(net_fitness),1));    
    
    if(i > numSlopePoints)
        
        slope = max(fit_max(i-numSlopePoints:i)) - min(fit_max(i-numSlopePoints:i));
        
        
        if(slope <= slopeThreshold(i))
            %% Reset the population
            disp('Resetting Population ...')
            idx = find(net_fitness==fit_max(i),1);
            cnt = 1;
            for j = idx
            bestChild{cnt} = sudoku_pop{j};
            cnt = cnt +1;
            end
            
            for j=1:pop_size
                sudoku_pop{j} = initializeSudoku(sudoku, givens);
                fitness_matrix{j} = findFitness(sudoku_pop{j},givens);
                net_fitness(j) = sum(fitness_matrix{j}(:));
            end
            [sudoku_pop] = mutation2(sudoku_pop, fitness_matrix, givens);
            for j =1:size(idx,2)
            sudoku_pop{j} = bestChild{j}; 
            fitness_matrix{j} = findFitness(bestChild{j},givens);
            net_fitness(j) = sum(fitness_matrix{j}(:));
            end
%             [sudoku_pop] = mutation(sudoku_pop, fitness_matrix, givens);
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
    d = visualizeMat(fitness_matrix);
    h.CData = d;
    h2.YData = fit_max;
    pause(0.00000001);
end
toc
% profile viewer
