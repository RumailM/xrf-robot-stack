%% The problem 
% the base frame of the work peice needs to be translated and rotated about
% the z axis to reflect the physical configuration of the workpeice with
% respect to the base frame of the robot arm as they are physically placed
% in the real world. 

%%  Import the object to read and plot
[V F N name] = stlRead("egg_50cm_3120.stl");


%% Set transformation parameters
x_displacement = 0.80; 
y_displacement = 0;
z_displacement = 0;

yaw_angle_rotate = 0;
% p = [x_displacement; y_displacement; z_displacement];
% T = [eye(3) p; 0 0 0 1]
%% Get triangle centroids and compute offsets
[t,c] = getTriangles(F,V); % get triangles and centroids to calculate poses
offsets = c + 5*N *10^(-2);
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

%% Preparing Sent States

count = zeros(1,num_sectors_simulated);

limits = [0 78 155 196 235 312 390 468 546 586 627];
num_sectors_simulated = size(limits,2)-1;
counts = zeros(1,num_sectors_simulated)




for sector_idx=1:num_sectors_simulated
    for i=1:size(good_idx,2)
        if good_idx(i)> limits(sector_idx) && good_idx(i)<= limits(sector_idx+1)
            counts(sector_idx) = counts(sector_idx) +1
        end
    end
end
cumulative_counts = [counts(1)];

for i=2:numel(counts)
    cumulative_counts(i) = cumulative_counts(i-1) + counts(i)
end
%
get = {};
get2 = {};
temp={};
temp2 ={};
sector_idx=1;
for i=1:numel(good_idx)
    
    if i > cumulative_counts(sector_idx)
        get{sector_idx} = temp;
        get2{sector_idx} = temp2;
        sector_idx = sector_idx +1
        temp = {};
        temp2 = {};
    end
    if counts(sector_idx) == 0
        sector_idx = sector_idx +1  ;
        
            
    end
    temp{end+1} = sentStates(i);
    temp2{end+1} = actualStates(i);

end
get{sector_idx} = temp;
get2{sector_idx} = temp2;

%%
idx = 5;
translated_rotated_offsets = translated_rotated_offsets_sectored{1,idx};
rot_inverted_normal = rot_inverted_normal_sectored{1,idx};
translated_rotated_V = translated_rotated_v_sectored{1,idx};
rotated_frames_q = rot_q_sectors{1,idx};
% Plotting
tp = theaterPlot();
op = orientationPlotter(tp);
hold on
xlabel("North-x (m)")
ylabel("East-y (m)")
zlabel("Down-z (m)");
h = patch("Faces",F,"Vertices",translated_rotated_V);
set(h,"FaceColor",[0.30,0.75,0.93],"EdgeColor",[0.94,0.94,0.94])
quiver3(translated_rotated_offsets(:,1),translated_rotated_offsets(:,2),translated_rotated_offsets(:,3),rot_inverted_normal(:,1),rot_inverted_normal(:,2),rot_inverted_normal(:,3))


number = 0;
comp = [];

% for i=1 :size(get{idx},2)
for i =1:size(translated_rotated_offsets,1)
    
%     poseplot(quaternion([get{idx}{i}.Orientation.W get{idx}{i}.Orientation.X ...
%         get{idx}{i}.Orientation.Y get{idx}{i}.Orientation.Z ]),...
%         [get{idx}{i}.Position.X get{idx}{i}.Position.Y get{idx}{i}.Position.Z],...
%         ScaleFactor=0.01)
%     poseplot(quaternion([get2{idx}{i}.Orientation.W get2{idx}{i}.Orientation.X ...
%         get2{idx}{i}.Orientation.Y get2{idx}{i}.Orientation.Z ]),...
%         [get2{idx}{i}.Position.X get2{idx}{i}.Position.Y get2{idx}{i}.Position.Z],...
%         ScaleFactor=0.01)
    if translated_rotated_offsets(i,3)>0.4
        number = number + 1
        poseplot(rotated_frames_q(i),translated_rotated_offsets(i,:),ScaleFactor=0.01)
        comp = [comp;[ translated_rotated_offsets(i,:) compact(rotated_frames_q(i)) ]];
    end

end
hold off










