%% The problem 
% the base frame of the work peice needs to be translated and rotated about
% the z axis to reflect the physical configuration of the workpeice with
% respect to the base frame of the robot arm as they are physically placed
% in the real world. 

%%  Import the object to read and plot
[V F N name] = stlRead("egg_50cm_3120.stl");


%% Set transformation parameters
x_displacement = 0.95; 
y_displacement = 0;
z_displacement = 0;

% tool_length = 0.1275;
% lambda = 0.1275;
lambda = 0.016; %10 cm

yaw_angle_rotate = 0;
% p = [x_displacement; y_displacement; z_displacement];
% T = [eye(3) p; 0 0 0 1]
%% Get triangle centroids and compute offsets
[t,c] = getTriangles(F,V); % get triangles and centroids to calculate poses
offsets = c + lambda*N;
invertedNormals = -1*N;

%% Get poses
poses = getPose(offsets,invertedNormals);
angles = [];
for i=1:size(poses,1)
    angle = atan2d(poses(i,2),poses(i,1));
    if angle <0
        angle = angle + 360;
    end
    angles = [angles angle];

end
%%
num_sectors = 48;
degrees_per_sector = 360/num_sectors;
g = {};
for j=1:num_sectors
    temp = [];
    for i=1:size(angles,2)
           
            if angles(i) >= degrees_per_sector*(j-1) && angles(i) < degrees_per_sector*(j) 
                temp = [temp i];
            end
    end

    g{j} = temp;
end
%%
l = {};
offsets_sectored= {};
for j=1:size(g,2)
    l{j} = poses(g{1,j},:);
    offsets_sectored{j} = offsets(g{1,j},:);
end
%%
rot_q_sectors = {};
rot_frame_setors = {};
translated_rotated_v_sectored = {};
translated_rotated_offsets_sectored = {};
rot_inverted_normal_sectored = {};

for i=1:size(l,2)

xyz= l{1,i}(:,4:6);
q = quaternion([xyz(:,1) xyz(:,2) xyz(:,3)],"eulerd","XYZ","frame");

% 1) Compute rotation matrix and a) rotate frames
rotms =quat2rotm(q);
rot_angle = 180 -1*(i-1)*degrees_per_sector - degrees_per_sector/2;
rot_z = rotz(rot_angle);
rotated_frames = pagemtimes(rot_z,rotms);
rotated_frames_q =  rotm2quat(rotated_frames);
rotated_frames_q = quaternion(rotated_frames_q);
rot_q_sectors{i} = rotated_frames_q;
% b) rotate frame positions 
rotated_offsets=pagemtimes(rot_z,offsets_sectored{1,i}')';
rot_frame_setors{1,i} = rotated_offsets;
% %% c) rotate vertices and direction vectors for plotting patches and quivers ( only for visual verification) 
rot_v=pagemtimes(rot_z,V')';
rot_inverted_normal = pagemtimes(rot_z,(invertedNormals(g{1,i},:))')';
rot_inverted_normal_sectored{i} = rot_inverted_normal;
 
%2) Translate frames  
translated_rotated_offsets = [];
translated_rotated_offsets(:,1) = rotated_offsets(:,1)+x_displacement; 
translated_rotated_offsets(:,2) = rotated_offsets(:,2)+y_displacement; 
translated_rotated_offsets(:,3) = rotated_offsets(:,3)+z_displacement; 


% b) translate vertices for plotting patches ( only for visual verification) 
translated_rotated_V = [];
translated_rotated_V(:,1) = rot_v(:,1)+x_displacement; 
translated_rotated_V(:,2) = rot_v(:,2)+y_displacement; 
translated_rotated_V(:,3) = rot_v(:,3)+z_displacement; 
translated_rotated_v_sectored{i} = translated_rotated_V;
translated_rotated_offsets_sectored{i} =translated_rotated_offsets;
end

% 3) orient poses so that scanning head always faces up
y_1 = [0 ;1 ;0];
% count = 0
for i=1:size(l,2)
    for j = 1: size(rot_q_sectors{i},1)
%         count = count + 1
        qq = rot_q_sectors{i}(j);
        y_1 = [0; 1; 0];p_y = quat2rotm(qq)*y_1; 
        x_1 = [1 ; 0 ; 0]; p_x = quat2rotm(qq)*x_1;
        z_1 = [0 ;0 ;1]; p_z = quat2rotm(qq)*z_1;
        % compute the normal
        n = cross(p_y, p_x) ;
        n = n / norm(n);
        P = [0, 0, 0]';
        C = [0,0,-2]';
        % project onto the plane
        C_proj = C - dot(C - P, n) * n;
        C2 = 1*C_proj ;
        
        cp = cross(C_proj,p_y);
        
        % beta = subspace(C_proj,p_y)*180/pi
        beta = atan2d(norm(cross(C_proj,p_y)), dot(C_proj,p_y));
        if dot(cp,p_z) < 0
            beta = beta * -1;
        end
        q_rot = qq*quaternion(rotz(beta),'rotmat','frame');
        rot_q_sectors{i}(j) = q_rot;
        
    end
end


%%
idx = 44;
translated_rotated_offsets = translated_rotated_offsets_sectored{1,idx};
rot_inverted_normal = rot_inverted_normal_sectored{1,idx};
translated_rotated_V = translated_rotated_v_sectored{1,idx};
rotated_frames_q = rot_q_sectors{1,idx};
% Plotting
% figure(3)
tp = theaterPlot();
op = orientationPlotter(tp);


hold on
xlabel("North-x (m)")
ylabel("East-y (m)")
zlabel("Down-z (m)");
h = patch("Faces",F,"Vertices",translated_rotated_V);
set(h,"FaceColor",[0.30,0.75,0.93],"EdgeColor",[0.94,0.94,0.94])
quiver3(translated_rotated_offsets(:,1),translated_rotated_offsets(:,2),translated_rotated_offsets(:,3),rot_inverted_normal(:,1),rot_inverted_normal(:,2),rot_inverted_normal(:,3))
for i=1 :size(rot_inverted_normal,1)
    
    poseplot(rotated_frames_q(i),translated_rotated_offsets(i,:),ScaleFactor=0.015)

end
hold off


%% Resorting for best scanning motions + rotate eef
posesq_sectored= {};
for i=1:size(g,2)
%     comb = [ translated_rotated_offsets_sectored{1,i} compact(rot_q_sectors{1,i}*quaternion(rotz(eff_rotate_angle),'rotmat','frame')) rot_inverted_normal_sectored{1,i} ];
    comb = [ translated_rotated_offsets_sectored{1,i} compact(rot_q_sectors{1,i}) rot_inverted_normal_sectored{1,i} ];

    if mod(i,2)== 1 % odd
        [comb, index_] = sortrows(comb,3,'descend');
    else % even
        [comb, index_] = sortrows(comb,3);
    end
        
        posesq_sectored{1,i}= [comb];
end


%% Repacking and Combining into CSV
save("poses_P_xyzO_wxyz.mat","posesq_sectored")
% t = cell2table(posesq_sectored);
% writetable(t,'poses_P_xyzO_wxyz.csv')
% matrixq = compact(rotated_frames_q);
% posesq = [translated_rotated_offsets matrixq];
% writematrix(posesq,"poses_P_xyzO_wxyz.csv")
% writecell(posesq_sectored,"poses_P_xyzO_wxyz.csv")




