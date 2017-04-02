clear all; close all;

num_epochs = 100;

% Input a sudoku (now manually)
sudoku_in = [0,0,4,3,0,0,2,0,9,0,0,5,0,0,9,0,0,1,0,7,0,0,6,0,0,4,3,0,0,6,0,0,2,0,8,7,1,9,0,0,0,7,4,0,0,0,5,0,0,8,3,0,0,0,6,0,0,0,0,0,1,0,5,0,0,3,5,0,8,6,9,0,0,4,2,9,1,0,3,0,0];
sudoku_in = transpose(reshape(sudoku_in, 9, 9));        % Transform into a matrix

sudoku = wrapSudokuToGridArrays(sudoku_in);             % Transform into 1-D array of 3x3 grids
givens = sudoku ~= 0;                                   % Givens are designated by '1'

% Initialize a popultion of sudokus
pop_size = 10;
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

% Perform cross-over and generate new population
fit_max = zeros(1, num_epochs);
for i=1:num_epochs
    [sudoku_pop, fitness_matrix, net_fitness] = cross_over(sudoku_pop, fitness_matrix, net_fitness);
    fit_max(i) = net_fitness(1);
end

% Plot max fitness per epoch
plot(1:num_epochs, fit_max); xlabel('Epochs'); ylabel('Max fitness'); title('Fitness with epoch');

% sudoku_out = unwrapSudoku(sudoku);