%% User Editable Option Parameters


% source ~/iiwa_stack_ws/devel/setup.bash; roslaunch iiwa_gazebo iiwa_gazebo_with_sunrise.launch
rosshutdown
%% Connext to external (already running roscore)
rosinit("http://127.0.0.1:11311")
% rosinit("http://rum:11311/")
%rosinit

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
% posesq = load("poses_P_xyzO_wxyz.csv");
% max(posesq)
% min(posesq)
load("poses_P_xyzO_wxyz.mat");
% load("poses_collision_filtered.mat")
% posesq_sectored{1,1}(4,3) = 20;
% posesq_sectored{1,1}(20,3) = 20;p
% posesq_sectored{1,1}(40,3) = 20;
% posesq_sectored{1,4}(20,3) = 20;
% posesq_sectored{1,6}(6,3) = 20;
% posesq_sectored{1,10}(11,3) = 20;
%% Preparing the ROS Carterian Pose Command Publisher

% rostopic pub /iiwa/command/CartesianPose geometry_msgs/PoseStamped ['{header: {stamp: now, frame_id: base_link}, pose: {position: {x: 1.0, y: 2.0, z: 3.0}, 'orientation: {x: 1.0, y: 2.0, z: 3.0, w: 4.0}}}'] -1

cartesian_command_topic = "/iiwa/command/CartesianPose";
cartesian_command_msg_type = "geometry_msgs/PoseStamped";

cartesian_command_publisher = rospublisher(cartesian_command_topic,...
    cartesian_command_msg_type,"DataFormat","struct");

resetCollisionFlag_publisher = rospublisher("/resetCollisionFlag","std_msgs/Bool","DataFormat","struct");
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
    filtered_poses = [];
    posesq = posesq_sectored{1,j};

    

    for i=1:size(posesq,1)
        invalidPoseFlag = 0;
        disp("========================= index : "+index)
      
       % % % % skip low poses 
        if skipLowFlag == 1 && posesq(i,3)<lowThreshold
            bad_idx = [bad_idx i];
            index = index +1;
            continue
        end
       % % % % % %

        % go to scanning point

        disp("Going to scan point")
        m = fillCommandMsg(m,posesq(i,:));
        send(cartesian_command_publisher,m)
        pause(1.5)



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
                disp("Invalid Movement on first iteration, so going to home instead of last valid")
                m = fillCommandMsg(m,home_pose);

            elseif (j > 1 && isempty(filtered_poses_sectored{j-1}))
                disp("Invalid Movement on first iteration, non-first sector, so going to home instead of last valid")
                m = fillCommandMsg(m,home_pose);

            elseif (isempty(filtered_poses) && j > 1)
                disp("Invalid Movement: moving to previous valid position previous sector")
                m = fillCommandMsg(m,computeOffset(filtered_poses_sectored{j-1}(end,:),offset));
        
            else
                disp("Invalid Movement: moving to previous valid position same sector")
                m = fillCommandMsg(m,computeOffset(filtered_poses(end,:),offset));

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
        filtered_poses = [filtered_poses ; posesq(i,:)];
        index = index + 1;
        good_idx = [good_idx index];
    end

    bad_idx_sectored{1,j} = bad_idx;
    good_idx_sectored{1,j}= good_idx;
    actualStates_sectored{1,j} = actualStates;
    sentStates_sectored{1,j} = sentStates;
    filtered_poses_sectored{1,j} = filtered_poses;
end

