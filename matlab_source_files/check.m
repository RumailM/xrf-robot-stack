function [outputArg2] = check(input)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

disp("type of input directly")
disp(class(input))
disp(input)

disp("str2num")
disp(class(str2num(input)))
disp(str2num(input))

disp("string")
disp(class(string(input)))
disp(string(input))

filtered_poses_sectored.a = "lol"
filtered_poses_sectored.b = [ 1 2 3 4 5 6 7 8; 1 2 3 4 5 6 7 8; 1 2 3 4 5 6 7 8; 1 2 3 4 5 6 7 8;];


save("filtered.mat","filtered_poses_sectored")

end