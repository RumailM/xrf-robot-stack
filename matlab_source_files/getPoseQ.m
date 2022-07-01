function [poseq] = getPoseQ(locations, vectors)
%getPoseQ(locations, vectors) Given vectors and their locations return pose (x,y,z,q_w,q_x,q_y,q_z)
%   Computes the quaternion pose from the 
%   rotation from the vector [0,0,1] to the direction pointed to in
%   the input. vectors is a Nx3 matrix and locations is an Nx3 matrix where
%   each row stores the x,y,z coordinates in order of the vector locations.
%   vectors should also given in this order.
%   *NOTE PLEASE MODIFY THIS TO TAKE CARE OF EDGE CASES*
% posesq =zeros(size(vectors,1),4);
quaternions = zeros(size(vectors,1),4);
p1 = [0,0,1];




for i=1:size(vectors,1)
    p2 = vectors(i,:);
    u = cross(p1,p2)/norm(cross(p1,p2));
    alpha = acos(dot(p1,p2)/(norm(p1)*norm(p2)));
    quaternions(i,:) = [cos(alpha/2), sin(alpha/2)*u(1), sin(alpha/2)*u(2), sin(alpha/2)*u(3)];

end
poseq = [locations quaternions];
end