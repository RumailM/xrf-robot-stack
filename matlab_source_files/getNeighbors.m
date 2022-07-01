function [neighborTriangleIndices] = ...
    getNeighbors(triangleMatrix,triangleIndex)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
neighborTriangleIndices=[];
for i=1:3
    for j=1:size(triangleMatrix,1)
        for k = 1:3
            if (triangleMatrix(triangleIndex,i,:)==triangleMatrix(j,k,:))
                neighborTriangleIndices = [neighborTriangleIndices j ];
            end
        end
    end
end

neighborTriangleIndices = unique(neighborTriangleIndices);

end