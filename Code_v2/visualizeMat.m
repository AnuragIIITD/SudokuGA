function [ d ] = visualizeMat( fitness_matrix )
%VISUALIZEMAT Summary of this function goes here
%   Detailed explanation goes here

b = cell2mat(fitness_matrix);
c = reshape(b, 16, 16, []);
d = sum(c, 3);

end
<<<<<<< HEAD
=======

>>>>>>> 676e86858fade42b727d0d96f7ce2ebb106f2fc2
