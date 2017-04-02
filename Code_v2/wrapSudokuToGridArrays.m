function [ grid_sudoku ] = wrapSudokuToGridArrays( sudoku )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

grid_sudoku = [];
for i=[1, 4, 7]
    for j=[1, 4, 7]
        su = transpose(sudoku(i:i+2, j:j+2));
        grid_sudoku = [grid_sudoku, transpose(su(:))];
    end
end

end

