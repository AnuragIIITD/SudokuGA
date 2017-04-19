function [ grid_sudoku ] = wrapSudokuToGridArrays( sudoku )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

m = size(sudoku,2);
n = sqrt(m);

grid_sudoku = [];

for r=1:n
    i = (r-1)*n + 1;
    for c=1:n
        j = (c-1)*n + 1;
        su = transpose(sudoku(i:i+n-1, j:j+n-1));
        grid_sudoku = [grid_sudoku, transpose(su(:))];
    end
end
% for i=[1, 4, 7]
%     for j=[1, 4, 7]
%         su = transpose(sudoku(i:i+2, j:j+2));
%         grid_sudoku = [grid_sudoku, transpose(su(:))];
%     end
% end

end

