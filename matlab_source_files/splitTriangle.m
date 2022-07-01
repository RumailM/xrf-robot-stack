function [V1,V2] = splitTriangle(V)
%splitTriangle given 3 dimensional coordinates of a triangle split it into
%2 smaller triangles along the longest dimension

% V = [x1, y1, z1;
%      x2, y2, z2;
%      x3, y3, z3 ]
AB = V(2,:)-V(1,:);
BC = V(3,:)-V(2,:);
AC = V(3,:)-V(1,:);
% disp(norm(AB))
% disp(norm(BC))
% disp(norm(AC))

if norm(AB) == max([norm(AB),norm(BC),norm(AC)])
    V1 = [V(:,1),mean([V(:,1) V(:,2)],2),V(:,3)];
    V2 = [mean([V(:,1) V(:,2)],2),V(:,2),V(:,3)];
elseif norm(BC) == max([norm(AB),norm(BC),norm(AC)])
    V1 = [V(:,1),V(:,2),mean([V(:,2) V(:,3)],2)];
    V2 = [V(:,1),mean([V(:,2) V(:,3)],2),V(:,3)];
else %norm(AC) == max([norm(AB),norm(BC),norm(AC)])
    V1 = [V(:,1),V(:,2),mean([V(:,1) V(:,3)],2)];
    V2 = [mean([V(:,1) V(:,3)],2),V(:,2),V(:,3)];
end

      

 
end