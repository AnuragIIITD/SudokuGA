function [ sudoku_out ] = initializeSudoku( sudoku_in, givens )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

all_digits = 1:9;
sudoku_out = zeros(size(sudoku_in));

for i=1:9
    grid = sudoku_in((i-1)*9+1 : i*9);
    grid_givens = givens((i-1)*9+1 : i*9);
    current_givens = grid(grid_givens == 1);
    new_digits = setdiff(all_digits, current_givens);
    rand_idx = randperm(length(new_digits));
    grid(grid_givens == 0) = new_digits(rand_idx);
    sudoku_out((i-1)*9+1 : i*9) = grid;
end

end

