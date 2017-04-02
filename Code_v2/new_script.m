clear all; close all;

sudoku_in = [0,0,4,3,0,0,2,0,9,0,0,5,0,0,9,0,0,1,0,7,0,0,6,0,0,4,3,0,0,6,0,0,2,0,8,7,1,9,0,0,0,7,4,0,0,0,5,0,0,8,3,0,0,0,6,0,0,0,0,0,1,0,5,0,0,3,5,0,8,6,9,0,0,4,2,9,1,0,3,0,0];
sudoku_in = transpose(reshape(sudoku_in, 9, 9));

sudoku = wrapSudokuToGridArrays(sudoku_in);
givens = sudoku ~= 0;

sudoku_init = initializeSudoku(sudoku, givens);
fitness_matrix = findFitness(sudoku_init);

sudoku_out = unwrapSudoku(sudoku);