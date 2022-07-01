function [area] = getTriangleArea(v)
%getTriangleArea given 3 dimensional coordinates of a triangle split it into
%2 smaller triangles along the longest dimension

% V = [x1, y1, z1;
%      x2, y2, z2;
%      x3, y3, z3 ]

AB = v(:,2)-v(:,1);
AC = v(:,3)-v(:,1);
area = 0.5*abs(cross(AB,AC));

end