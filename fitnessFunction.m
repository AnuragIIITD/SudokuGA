function [ fitness ] = fitnessFunction( sudoku, solution )
% sudoku = [0,0,4,3,0,0,2,0,9,0,0,5,0,0,9,0,0,1,0,7,0,0,6,0,0,4,3,0,0,6,0,0,2,0,8,7,1,9,0,0,0,7,4,0,0,0,5,0,0,8,3,0,0,0,6,0,0,0,0,0,1,0,5,0,0,3,5,0,8,6,9,0,0,4,2,9,1,0,3,0,0];
% solution = randi(9,9);

if(size(sudoku,1) ~= size(sudoku,2))
    m = sqrt(max(size(sudoku,1),size(sudoku,2)));
    sudoku = reshape(sudoku,m,m)';
    n = sqrt(m);
else
    n = sqrt(size(sudoku,1));
end

% check rows
fitness = checkDuplicate(solution,1);
% check columns
fitness = fitness + checkDuplicate(solution,2);
% check boxes
fitness = fitness + checkBoxes(solution,n);
% check that it matches the known digits
fitness = fitness + compareKnownDigits(sudoku, solution) * 10;
% disp(['Fitness value = ',num2str(fitness)]);
end

function val = checkDuplicate(solution,dim)

val = 0;
if(dim==2)
    solution = solution';
end

for i = 1:size(solution,1)
    val = val + length(setdiff(1:size(solution,2) , unique(solution(i,:))));
end

end

function val = checkBoxes(solution,n)
val = 0;
for i = 1:n:size(solution,1)
    for j = 1:n:size(solution,2)
%         disp(['-i-' ,num2str(i),'-j-' ,num2str(j)])
        box = solution(i:i+2,j:j+2);
        val = val + length(setdiff(1:n*n , unique(box)));
    end
end
end

function val = compareKnownDigits(sudoku, solution)
solution(sudoku==0)=0;
val = sum(sum(solution~=sudoku));
end
