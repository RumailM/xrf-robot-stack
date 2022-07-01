%% The problem 
% the base frame of the work peice needs to be translated and rotated about
% the z axis to reflect the physical configuration of the workpeice with
% respect to the base frame of the robot arm as they are physically placed
% in the real world. 

%%  Import the object to read and plot
% [V F N name] = stlReadAscii("egg.stl");
[V F N name] = stlRead("egg_50cm_3120.stl");
% V = V*10^(-3)
% max(V)
% stlWrite("./egg_50cm_3120.stl",F,V)

% [V F N name] = stlRead("egg_x_50.stl");
% stlWrite("./egg_50cm_1600.stl",F,V)


%% Set transformation parameters
x_displacement = 0.62; 
y_displacement = 0;
z_displacement = 0;

yaw_angle_rotate = 0;
% p = [x_displacement; y_displacement; z_displacement];
% T = [eye(3) p; 0 0 0 1]
%% Get triangle centroids and compute offsets
[t,c] = getTriangles(F,V); % get triangles and centroids to calculate poses
offsets = c + 2*N *10^(-2);
invertedNormals = -1*N;

%% Get poses
poses = getPose(offsets,invertedNormals);
xyz= poses(:,4:6);
q = quaternion([xyz(:,1) xyz(:,2) xyz(:,3)],"eulerd","XYZ","frame");

%% 1) Compute rotation matrix and a) rotate frames
rotms =quat2rotm(q);
rot_z = rotz(yaw_angle_rotate);
rotated_frames = pagemtimes(rot_z,rotms);
rotated_frames_q =  rotm2quat(rotated_frames);
rotated_frames_q = quaternion(rotated_frames_q);
%% b) rotate frame positions 
rotated_offsets=pagemtimes(rot_z,offsets')';
%% c) rotate vertices and direction vectors for plotting patches and quivers ( only for visual verification) 
rot_v=pagemtimes(rot_z,V')';
rot_inverted_normal = pagemtimes(rot_z,invertedNormals')';

%% 2) Translate frames  
translated_rotated_offsets = [];
translated_rotated_offsets(:,1) = rotated_offsets(:,1)+x_displacement; 
translated_rotated_offsets(:,2) = rotated_offsets(:,2)+y_displacement; 
translated_rotated_offsets(:,3) = rotated_offsets(:,3)+z_displacement; 
%% b) translate vertices for plotting patches ( only for visual verification) 
translated_rotated_V = [];
translated_rotated_V(:,1) = rot_v(:,1)+x_displacement; 
translated_rotated_V(:,2) = rot_v(:,2)+y_displacement; 
translated_rotated_V(:,3) = rot_v(:,3)+z_displacement; 

%%
tp = theaterPlot();
op = orientationPlotter(tp);
hold on
xlabel("North-x (m)")
ylabel("East-y (m)")
zlabel("Down-z (m)");
h = patch("Faces",F,"Vertices",translated_rotated_V);
set(h,"FaceColor",[0.30,0.75,0.93],"EdgeColor",[0.94,0.94,0.94])
quiver3(translated_rotated_offsets(:,1),translated_rotated_offsets(:,2),translated_rotated_offsets(:,3),rot_inverted_normal(:,1),rot_inverted_normal(:,2),rot_inverted_normal(:,3))
for i=1:400 :size(rot_inverted_normal,1)
    
    poseplot(rotated_frames_q(i),translated_rotated_offsets(i,:),ScaleFactor=0.01)

end
hold off


%%