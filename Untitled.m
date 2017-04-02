sudoku = randi(9,9,9);

fm = zeros(9,9);

for i =1:size(sudoku,1)
    for j =1:size(sudoku,2)
        fm(i,:) = fm(i,:) +(sudoku(i,:) == sudoku(i,j));
        fm(:,j) = fm(:,j) +(sudoku(:,j) == sudoku(i,j));        
    end
end