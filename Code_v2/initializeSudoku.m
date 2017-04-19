function [ sudoku_out ] = initializeSudoku( sudoku_in, givens )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
m = sqrt(size(sudoku_in,2));
all_digits = 1:m;
sudoku_out = zeros(size(sudoku_in));

for i=1:m
    grid = sudoku_in((i-1)*m+1 : i*m);
    grid_givens = givens((i-1)*m+1 : i*m);
    current_givens = grid(grid_givens == 1);
    new_digits = setdiff(all_digits, current_givens);
    rand_idx = randperm(length(new_digits));
    grid(grid_givens == 0) = new_digits(rand_idx);
    sudoku_out((i-1)*m+1 : i*m) = grid;
end

end

