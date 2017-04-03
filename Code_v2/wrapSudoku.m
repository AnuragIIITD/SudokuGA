function [ sudoku ] = unwrapSudoku( sudoku_grid )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

sudoku = zeros(9);
for i=1:9
    su_grid = sudoku_grid(9*(i-1)+1:9*i);
    su_grid = transpose(reshape(su_grid, 3, 3));
    sudoku(floor((i-1)/3)*3+1 : ceil(i/3)*3, mod(i-1, 3)*3+1 : (mod(i-1, 3)+1)*3) = su_grid;
end

end

