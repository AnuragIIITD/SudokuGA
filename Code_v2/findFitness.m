function [ fitness ] = findFitness( sudoku )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

sudoku = unwrapSudoku(sudoku);
fitness = zeros(size(sudoku));

for i=1:9
    for j=1:9
        fitness(i, j) = sum(sudoku(i, :) == sudoku(i, j)) + sum(sudoku(:, j) == sudoku(i, j));
    end
end

end

