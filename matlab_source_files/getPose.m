function [pose, angles] = getPose(locations, vectors)
%getPose(locations, vectors) Given vectors and their locations return pose (x,y,z,r,p,y)
%   Computes roll pitch and yaw by first calculating the quaternion
%   rotation from the vector [1/3,1/3,1/3] to the direction pointed to in
%   the input. vectors is a Nx3 matrix and locations is an Nx3 matrix where
%   each row stores the x,y,z coordinates in order of the vector locations.
%   vectors should also given in this order.
%   *NOTE PLEASE MODIFY THIS TO TAKE CARE OF EDGE CASES*
rpy = zeros(size(vectors,1),3);
% p1 = [1/3,1/3,1/3];
p1 = [0,0,1];
% y_1 = [0; 1; 0];

% angles = []
for i=1:size(vectors,1)
    p2 = vectors(i,:);
    u = cross(p1,p2)/norm(cross(p1,p2));
    alpha = acos(dot(p1,p2)/(norm(p1)*norm(p2)));
    q = [cos(alpha/2), sin(alpha/2)*u(1), sin(alpha/2)*u(2), sin(alpha/2)*u(3)];

    
    q = quaternion(q);
    
%     p_y = quat2rotm(q)*y_1; %vector where the pose frame y axis points
%     p_y_xy = [p_y(2) p_y(3)];% working on the xz plane now, project y_p[p_y(1) 0 p_y(3)];
%     beta = acosd(p_y(3)/(norm(p_y_xy)));
%     q_rot = q*quaternion(rotz(180+beta),'rotmat','frame');
%     angles = [angles beta];

  
    
    rpy(i,:) = eulerd(q,'xyz','frame');
end
pose = [locations rpy];
end