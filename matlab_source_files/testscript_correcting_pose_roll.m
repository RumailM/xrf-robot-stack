rot = roty(31)*rotx(43)*rotz(34);

rotq = quaternion(rot,'rotmat','frame');
close all
% hold on
poseplot(rotq)
hold on


y_1 = [0 1 0];

rot_vec = 10*quat2rotm(rotq)*y_1';
% rot_vec = y_1*rot;


quiver3(0,0,0,rot_vec(1),rot_vec(2),rot_vec(3))
%%
qw = quaternion(rotx(45),'rotmat','frame')
% qw = quaternion([1 0 0 0]);
qr = quat2rotm(qw)
poseplot(qw)
hold

rv = [0 1 0]*qr

quiver3(0,0,-2,rv(1),rv(2),rv(3))

%%
rotm = rotx(32)


poseplot(quaternion(rotm,'rotmat','frame'))
hold
on

poseplot()

