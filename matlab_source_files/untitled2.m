
% qq = quaternion([0.2364    0.7850    0.3399    0.4608]);
close all
clear C_proj
% qq = rot_q_sectors{10}(end)
qq = rot_q_sectors{20}(end)
% qq = rot_q_sectors{30}(end)

% qq = qq*quaternion(rotz(45),'rotmat','frame')
% qq = qq*quaternion(roty(45),'rotmat','frame')
poseplot(qq);
xlabel("North-x (m)")
ylabel("East-y (m)")
zlabel("Down-z (m)");
y_1 = [0; 1; 0];p_y = quat2rotm(qq)*y_1; 
x_1 = [1 ; 0 ; 0]; p_x = quat2rotm(qq)*x_1;
z_1 = [0 ;0 ;1]; p_z = quat2rotm(qq)*z_1;

hold on










%


% compute the normal
n = cross(p_y, p_x) ;
n = n / norm(n);
P = [0, 0, 0]';
C = [0,0,-2]';
% project onto the plane
C_proj = C - dot(C - P, n) * n;
C2 = 1*C_proj ;

cp = cross(C_proj,p_y)

% beta = subspace(C_proj,p_y)*180/pi
beta = atan2d(norm(cross(C_proj,p_y)), dot(C_proj,p_y))
if dot(cp,p_z) < 0
    beta = beta * -1
end
q_rot = qq*quaternion(rotz(beta),'rotmat','frame');

poseplot(q_rot)

% quiver3(0,0,0,0,0,C(3))
quiver3(0,0,0,C2(1),C2(2),C2(3))
quiver3(0,0,0,cp(1),cp(2),cp(3))
% 
