function [ sudoku ] = unwrapSudoku( sudoku_grid )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
m = sqrt(size(sudoku_grid,2));
n = sqrt(m);
sudoku = zeros(m);
for i=1:m
    su_grid = sudoku_grid(m*(i-1)+1:m*i);
    su_grid = transpose(reshape(su_grid, n, n));
    sudoku(floor((i-1)/n)*n+1 : ceil(i/n)*n, mod(i-1, n)*n+1 : (mod(i-1, n)+1)*n) = su_grid;
end

end

