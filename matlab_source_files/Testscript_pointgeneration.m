%% Chose 6 points on the  XZ plane
P = [500,0,500;
     600,0,600;
     700,0,700;
     500,0,300;
     600,0,200;
     700,0,100;]

%% Take these points and also create points rotated by 2pi/3

rot_z = rotz(120);



P1=pagemtimes(rot_z,P')';
P2=pagemtimes(rot_z,P1')';
P = [P;P1;P2]