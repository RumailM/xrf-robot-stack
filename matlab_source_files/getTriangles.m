function [trianglematrix,centroids] = getTriangles(F,V)
%getTriangles(F,V)  returns a matrix of triangles and the centroids 
%   inputs Faces, sized Nx3, and Vector Matrices outputs a trianglematrix
%   sized N,j,k, where j=3 is the index of vertex in the face and where 
%   k=3 which is the index of the coordinate, k=1 is x coord, k=2 is the 
%   y coord, k=3 is the z coord

centroids = zeros(size(F,1),3);
trianglematrix = zeros(size(F,1),3,3);
for i=1:size(F,1)
    for j=1:3
    trianglematrix(i,j,:) = V(F(i,j),:);
    end

    centroids(i,:) = [mean(trianglematrix(i,:,1)) mean(trianglematrix(i,:,2)) mean(trianglematrix(i,:,3))];
end 
end