v = [-1 1 -1];
v = v./norm(v)
pose = getPose([0,0,0],[v(1),v(2),v(3)])
%%
R1 = rotx(pose(4));
R2 = roty(pose(5));
R3 = rotz(pose(6));
%%
