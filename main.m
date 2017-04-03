function main()
close all;
sudoku = [0,0,4,3,0,0,2,0,9,0,0,5,0,0,9,0,0,1,0,7,0,0,6,0,0,4,3,0,0,6,0,0,2,0,8,7,1,9,0,0,0,7,4,0,0,0,5,0,0,8,3,0,0,0,6,0,0,0,0,0,1,0,5,0,0,3,5,0,8,6,9,0,0,4,2,9,1,0,3,0,0];

if(size(sudoku,1) ~= size(sudoku,2))
    m = sqrt(max(size(sudoku,1),size(sudoku,2)));
    sudoku = reshape(sudoku,m,m)';
    n = sqrt(m);
else
    n = sqrt(size(sudoku,1));
end
solution = zeros(n*n,n*n);



popSize = 10;
Epochs = 250;
Threshold = 0;
numSlopePoints = 10;
slopeThreshold = 0.5;

fitnessVals = zeros(1,Epochs);

figure;
hold on;
title('Fitness value vs epochs')
xlabel('# of Epochs') % x-axis label
ylabel('Fitness Value') % y-axis label

%% Initialize the population
population = initPop(sudoku,popSize,n);

for i = 1:Epochs



%% Evaluate the population
popFitness = evalPop(sudoku,population);
sortedFitness = sort(popFitness);
disp(['Epoch # ', num2str(i),': Worst Fitness = ', num2str(max(popFitness)),' Best Fitness = ', num2str(min(popFitness))]);
fitnessVals(i) = min(popFitness);

%% find slope of fitnessValue curve with epochs to determine if the population needs to be reset
if(i > numSlopePoints)
% coefficients = polyfit(i-numSlopePoints:i, fitnessVals(i-numSlopePoints:i), 1);
% Now get the slope, which is the first coefficient in the array:
slope = max(fitnessVals(i-numSlopePoints:i)) - min(fitnessVals(i-numSlopePoints:i));

% disp(slope)
if(slope <= slopeThreshold)
    %% Reset the population
    disp('Resetting Population ...')
    bestChild = population{find(popFitness==sortedFitness(1),1)};
    population = initPop(sudoku,popSize,n);
    population{1} = shake(bestChild,1);
%   population{1} = bestChild;
    continue;
end
end
% plot(1:Epochs,fitnessVals); hold on

if(min(popFitness)<=Threshold)
   solution = population{find(popFitness==min(popFitness),1)};
   break; 
end


 
%% Evolve the population
population{find(popFitness==sortedFitness(end),1)} = crossover(population{find(popFitness==sortedFitness(1),1)},population{find(popFitness==sortedFitness(2),1)});

end

plot(1:Epochs,fitnessVals); hold on


disp('Final Solution: ');
solution = population{find(popFitness==min(popFitness),1)};
[ solved_sudoku ] = wrapSudoku( sudoku_grid );
disp(solution);
end


function population = initPop(sudoku,popSize,n)
population = cell(1,popSize);
for i = 1:popSize    
    child = randi(n*n,n*n);
    child(sudoku~=0)=sudoku(sudoku~=0);
    population{i} = child;
end
end

function popFitness = evalPop(sudoku,population)
popFitness = zeros(1,size(population,2));
for i = 1:size(population,2)    
    popFitness(i) = fitnessFunction(sudoku,population{i});
end
end

function child = crossover(parent1, parent2)
crossoverType = randi(6);
child = zeros(size(parent1));
%% Build child out of halves of parents
if (crossoverType == 1)
    child = [parent1(:,1:ceil(end/2)),parent2(:,ceil(end/2)+1:end)];
elseif (crossoverType == 2)
    child = [parent2(:,1:ceil(end/2)),parent1(:,ceil(end/2)+1:end)];          
elseif (crossoverType == 3)
    child = [parent1(1:ceil(end/2),:);parent2(ceil(end/2)+1:end,:)];                    
elseif (crossoverType == 4)
    child = [parent2(1:ceil(end/2),:);parent1(ceil(end/2)+1:end,:)];   
    
%% Build child out of interlaced halves of parents
elseif (crossoverType == 5)
    child(1:2:end,:) = parent1(1:2:end,:);    
    child(2:2:end,:) = parent2(2:2:end,:);   
else
    child(:,1:2:end) = parent1(:,1:2:end);    
    child(:,2:2:end) = parent2(:,2:2:end);                    
end
    

end