function [filtered_poses_sectored] = tool_path_generator(bof,off,rf,rfac,lf,lowthresh,poses_mat)
%% User Editable Option Parameters
% Should the toolpath only have endpoints along the scanning points, or
% should it try to backoff before and after each scanning point
% this may reduce collisions!

%% converssions
bof = str2num(bof);
off = str2num(off);
rf = str2num(rf);
rfac = str2num(rfac);
lf = str2num(lf);
lowthresh = str2num(lowthresh);
poses_mat = string(poses_mat);

%%
backOffFlag = bof; %  1: for back off between scanning points, 0 for not
offset = off; % 0.05: offset how far it should back off 0.05 = 5 cm

%reduce the number of scanning points, for testing purposes, makes the scan
%more sparese
reduceFlag = rf; % 0: if 1, make sparse, otherwise use all scanning points
reduceFactor = rfac; % 10: take every reduceFactor-th(10th for example) point, discard rest

% Should we skip low points? beyond a certain Z height, collisions with
% ground are gauranteed, enable this to save time computing a plausible
% toolpath
skipLowFlag = lf; % 1:
lowThreshold = lowthresh; % 0.11 :

% source ~/iiwa_stack_ws/devel/setup.bash; roslaunch iiwa_gazebo iiwa_gazebo_with_sunrise.launch
rosshutdown
%% Connext to external (already running roscore)
rosinit("http://127.0.0.1:11311")


%% Preparing a ROS /rosout subscriber
global rosout_data;
global iiwaState; 
global collisionFlag;
global collisionState;
rout =  rossubscriber("/rosout",@rosoutCallback,"DataFormat","struct");
iiwaStateSub = rossubscriber("/iiwa/state/CartesianPose",@iiwaCartesianStateCallback,"DataFormat","struct");
collisionFlagSub = rossubscriber("/collisionFlag",@collisionFlagCallback,"DataFormat","struct");
collisionStateSub = rossubscriber("/collisionTopicWorkpeice",@collisionStateCallback,"DataFormat","struct");
%% Load poses

load(poses_mat);

%% Preparing the ROS Carterian Pose Command Publisher

% rostopic pub /iiwa/command/CartesianPose geometry_msgs/PoseStamped ['{header: {stamp: now, frame_id: base_link}, pose: {position: {x: 1.0, y: 2.0, z: 3.0}, 'orientation: {x: 1.0, y: 2.0, z: 3.0, w: 4.0}}}'] -1

cartesian_command_topic = "/iiwa/command/CartesianPose";
cartesian_command_msg_type = "geometry_msgs/PoseStamped";

cartesian_command_publisher = rospublisher(cartesian_command_topic,...
    cartesian_command_msg_type,"DataFormat","struct");

resetCollisionFlag_publisher = rospublisher("/resetCollisionFlag","std_msgs/Bool","DataFormat","struct");

ro = rospublisher("/rosout","rosgraph_msgs/Log","DataFormat","struct");
a = rosmessage(ro);

%% Prepare Cartesian Pose Message

prev_time = -1;

bad_idx_sectored = {};
good_idx_sectored = {};
actualStates_sectored = {};
sentStates_sectored = {};
filtered_poses_sectored = {};
invalid_cmd = [];

m = rosmessage(cartesian_command_publisher);

home_pose = [0.0 0.0 0.8059999 0.707 0.0 0.707 0.0];
% home_pose = computeOffset(posesq_sectored{1,1}(50,:),0.1)


m = fillCommandMsg(m,home_pose);
send(cartesian_command_publisher,m)

a = rosmessage(resetCollisionFlag_publisher);
a.Data = true; 

pause(2)


index = 1
for j = 1:size(posesq_sectored,2)
    good_idx = [];
    bad_idx = [];
    actualStates = [];
    sentStates = [];
    if j == 1
        filtered_poses = [home_pose];
    else
        filtered_poses = [];
    end
    posesq = posesq_sectored{1,j};
%     posesq=flip(posesq)

    % % % reduce amount of poses
    if reduceFlag == 1

    temp = [];
        for i=1:size(posesq,1)
            if mod(i,reduceFactor) == 0
                temp = [temp ; posesq(i,:)];
            end
        end
        posesq= temp;
    end
    % % % % %

    for i=1:size(posesq,1)
        invalidPoseFlag = 0;
        disp("========================= index : "+index)
      
       % % % % skip low poses 
        if (skipLowFlag == 1 && posesq(i,3)<lowThreshold) ||(index <53)
            bad_idx = [bad_idx i];
            index = index +1;
            continue
        end
       % % % % % %

       % if back off, go to an offset point before the scanning point first
        if backOffFlag == 1
            disp("Going to offset point")
            m = fillCommandMsg(m,computeOffset(posesq(i,:),offset));
            send(cartesian_command_publisher,m)
            pause(1.5)
            % Check to see if the position sent immediately returns a warning
            % or check to see if it thinks it found a solution and it was
            % incorrect
            if checkPoseCommandValidity(prev_time, rosout_data,iiwaState,m) == false
                prev_time = rosout_data.Header.Stamp.Sec;
                invalidPoseFlag = 1;
            end
        end % then go to the actual scanning point
        
        % go to scanning point
        if invalidPoseFlag == 0
            disp("Going to scan point")
            m = fillCommandMsg(m,posesq(i,:));
            send(cartesian_command_publisher,m)
            pause(1.5)
        end


        % Check to see if the position sent immediately returns a warning
        % or check to see if it thinks it found a solution and it was
        % incorrect
        if checkPoseCommandValidity(prev_time, rosout_data,iiwaState,m) == false
            prev_time = rosout_data.Header.Stamp.Sec;
            invalidPoseFlag = 1;
        end



        % Check to see if the sent position caused a collision or if it was
        % invalid (warning) or if false solution (check offset too)
        if (collisionFlag.Data == true || invalidPoseFlag == 1)
            if collisionFlag.Data == true
                disp("Invalid Pose, Collision")
            end
            
            
%             disp(num2str(iiwaState.Pose.Position.X,"%.1f") + " " +num2str(m.Pose.Position.X,"%.1f") )
            disp(num2str(m.Pose.Position.X,"%.1f") + " " + num2str(m.Pose.Position.Y,"%.1f") + " " + num2str(m.Pose.Position.Z,"%.1f") + " " ...
+ num2str(m.Pose.Orientation.X,"%.1f") + " " + num2str(m.Pose.Orientation.Y,"%.1f") + " " + num2str(m.Pose.Orientation.Z,"%.1f") + " " + num2str(m.Pose.Orientation.W,"%.1f"))
             disp(num2str(iiwaState.Pose.Position.X,"%.1f") + " " + num2str(iiwaState.Pose.Position.Y,"%.1f") + " " + num2str(iiwaState.Pose.Position.Z,"%.1f") + " " ...
+ num2str(iiwaState.Pose.Orientation.X,"%.1f") + " " + num2str(iiwaState.Pose.Orientation.Y,"%.1f") + " " + num2str(iiwaState.Pose.Orientation.Z,"%.1f") + " " + num2str(iiwaState.Pose.Orientation.W,"%.1f"))
           
            % Move to home position if collision or move to the previous
            % position if not given the first position

            

            if(j == 1) && isempty(filtered_poses)
                disp("Invalid Movement, so going to home instead of last valid")
                m = fillCommandMsg(m,home_pose);

            elseif (j > 1 && isempty(filtered_poses_sectored{j-1}))
                disp("Invalid Movement, non-first sector, previous sector empty, so going to home instead of last valid")
                m = fillCommandMsg(m,home_pose);

            elseif (isempty(filtered_poses) && j > 1)
                disp("Invalid Movement: moving to previous valid position previous sector")
                m = fillCommandMsg(m,filtered_poses_sectored{j-1}(end,:));
        
            else
                disp("Invalid Movement: moving to previous valid position same sector")
                m = fillCommandMsg(m,filtered_poses(end,:));

            end
            send(cartesian_command_publisher,m)
            pause(1)

           
            while(~isempty(collisionState.States))  % Wait till collision stops
                pause(0.01);
            end           
            send(resetCollisionFlag_publisher,a);

            invalidPoseFlag = 0;
            bad_idx = [bad_idx i];
            index = index +1;
            continue 
        end
        
        
        pause(0.5);

        
        sentStates = [sentStates m.Pose];
%         actualStates = [actualStates iiwaState.PoseStamped.Pose];
        actualStates = [actualStates iiwaState.Pose];


        % if backoff, go to offset to prepare for next point
        if backOffFlag == 1
            disp("Going back to offset point")
            m = fillCommandMsg(m,computeOffset(posesq(i,:),offset));
            send(cartesian_command_publisher,m)
            pause(1.5)
            filtered_poses = [filtered_poses ;computeOffset(posesq(i,:),offset) ;posesq(i,:) ; computeOffset(posesq(i,:),offset)];
            
        else
            filtered_poses = [filtered_poses ; posesq(i,:)];
        end
        index = index + 1;
        good_idx = [good_idx index];
    end

    bad_idx_sectored{1,j} = bad_idx;
    good_idx_sectored{1,j}= good_idx;
    actualStates_sectored{1,j} = actualStates;
    sentStates_sectored{1,j} = sentStates;
    filtered_poses_sectored{1,j} = filtered_poses;
end


save("filtered.mat","filtered_poses_sectored");
writecell(filtered_poses_sectored,"filtered.csv");
save("generator_session_variables.mat");

end

