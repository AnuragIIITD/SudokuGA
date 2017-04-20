function [ fitness ] = findFitness( sudoku,givens)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
m = sqrt(size(sudoku,2));
% n = sqrt(m);
sudoku = unwrapSudoku(sudoku);
fitness = zeros(size(sudoku));

for i=1:m
    for j=1:m
        fitness(i, j) = (sum(sudoku(i, :) == sudoku(i, j)) > 1) + (sum(sudoku(:, j) == sudoku(i, j)) > 1);
    end
end
givens = unwrapSudoku(givens);

fitness = ~givens.*fitness;

end

