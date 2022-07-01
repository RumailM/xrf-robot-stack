
%%
% source ~/iiwa_stack_ws/devel/setup.bash; roslaunch iiwa_gazebo iiwa_gazebo_with_sunrise.launch
% source ~/iiwa_stack_ws/devel/setup.bash; roslaunch my_egg_sensor_desc spawn.launch
%% In order to close the Matlab - ROS connection
% rosshutdown
%% Connext to external (already running roscore)
% rosinit("http://127.0.0.1:11311")
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
collisionStateSub = rossubscriber("/collisionTopic",@collisionStateCallback,"DataFormat","struct");
%% Load poses
% posesq = load("poses_P_xyzO_wxyz.csv");
% max(posesq)
% min(posesq)
load("poses_P_xyzO_wxyz.mat");
% load("poses_collision_filtered.mat")
posesq_sectored{1,1}(4,3) = 20;
posesq_sectored{1,1}(20,3) = 20;
posesq_sectored{1,1}(40,3) = 20;
posesq_sectored{1,4}(20,3) = 20;
posesq_sectored{1,6}(6,3) = 20;
posesq_sectored{1,10}(11,3) = 20;
%% Preparing the ROS Carterian Pose Command Publisher

% rostopic pub /iiwa/command/CartesianPose geometry_msgs/PoseStamped ['{header: {stamp: now, frame_id: base_link}, pose: {position: {x: 1.0, y: 2.0, z: 3.0}, 'orientation: {x: 1.0, y: 2.0, z: 3.0, w: 4.0}}}'] -1

cartesian_command_topic = "/iiwa/command/CartesianPose";
cartesian_command_msg_type = "geometry_msgs/PoseStamped"

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
a = rosmessage(resetCollisionFlag_publisher);
            a.Data = true;    

home_pose = [0.0 0.0 0.8059999 0.707 0.0 0.707 0.0];


m = fillCommandMsg(m,home_pose);
send(cartesian_command_publisher,m)


pause(2)


index = 1
for j = 1:size(posesq_sectored,2)
% for j = 1:1
    good_idx = [];
    bad_idx = [];
    actualStates = [];
    sentStates = [];
    filtered_poses = [];
    posesq = posesq_sectored{1,j};
% % % % reduce amount of poses
%     temp = []
%     for i=1:size(posesq,1)
%         if mod(i,10) == 0
%             temp = [temp ; posesq(i,:)];
%         end
%     end
%     posesq= temp;
% % % % % %

    for i=1:size(posesq,1)

% % % % skip certain  poses
%         if isempty(find(idx==index))
%          
%             disp("skipping")
%             index
%             index = index + 1;
%             continue
%         end
% % % % % %

% % % % skip poeses until certain number
% 
%         if  index <70
%           
%             disp("skipping")
%             index
%             index = index + 1;
%             continue
%         end
% % % % % %

% % % % skip low poses 

%        if posesq(i,3)<0.12
% %             disp(m.Pose.Position.Z);
% %             disp("less")
%             bad_idx = [bad_idx i];
%             index = index +1 
%             continue
%        end
% % % % % %


        m = fillCommandMsg(m,posesq(i,:));
        send(cartesian_command_publisher,m)
        pause(1.5)
        if (checkPoseCommandValidity(prev_time, rosout_data) == false)
            invalid_cmd = [invalid_cmd rosout_data];
            prev_time = rosout_data.Header.Stamp.Sec;
            bad_idx = [bad_idx i];
            index = index +1
            continue 
        end

        if (collisionFlag.Data == true)
%             disp("Collision");
            bad_idx = [bad_idx i];
            index = index +1
            % Move to home position if collision or move to the previous
            % position if not given the first position
            home = 1;
            target_pose = posesq(i,:);
            if(j == 1) && isempty(filtered_poses)
                disp("Collision on first iteration, first sector, so going to home instead of last valid")
                home = 1;
                prev_pose = home;
            elseif (j > 1 && isempty(filtered_poses_sectored{j-1}))
                disp("Collision on first iteration, non-first sector, so going to home instead of last valid")
                home = 1;
                prev_pose = home;                
            elseif (isempty(filtered_poses) && j > 1)
                disp("Collision: moving to previous valid position previous sector")
                home = 0;
                prev_pose = filtered_poses_sectored{j-1}(end,:);        
            else
                disp("Collision: moving to previous valid position same sector")
                home = 0;
                prev_pose = filtered_poses(end,:);   
                
            end
            % first go back to the previous position
            m = fillCommandMsg(m,prev_pose);
            send(cartesian_command_publisher,m);
            pause(1.5)
            
            % reset the collision flag
            send(resetCollisionFlag_publisher,a);
            pause(0.5)

            % compute intermediary position            
            if home == 0
                disp("Calculating Intermediary Pose")
                lambda = 2;
                prev_pose_offset = prev_pose(1:3) -lambda*prev_pose(8:10);
                next_pose(1:3) = mean([prev_pose(1:3) -lambda*prev_pose(8:10); target_pose(1:3) -lambda*target_pose(8:10);],2);
                next_pose(4:7) = prev_pose(4:7);
            else
                disp("Going home")
            end

            m = fillCommandMsg(m,next_pose);
            send(cartesian_command_publisher,m);
            pause(1.5)

                    
            send(resetCollisionFlag_publisher,a);
            pause(0.5)
            
            %% Try an offset point
            if(checkPoseCommandValidity(prev_time,rosout_data) == false || collisionFlag.Data == true)
                disp("Collision or Invalid on offset mean")
                m = fillCommandMsg(m,prev_pose);
                send(cartesian_command_publisher,m);
                pause(1.5)
                send(resetCollisionFlag_publisher,a);
                pause(0.5)
                if(checkPoseCommandValidity(prev_time,rosout_data) == false || collisionFlag.Data == true)
                
                end
            end
            
%             while(~isempty(collisionState.States))
%                 pause(0.01);
%             end


            a = rosmessage(resetCollisionFlag_publisher);
            a.Data = true;            
            send(resetCollisionFlag_publisher,a);

%             disp('check collision state')
            
%             collisionState.States
%             pause(1)
            continue 
        end
        
        
        pause(0.5);

        
        sentStates = [sentStates m.Pose];
%         actualStates = [actualStates iiwaState.PoseStamped.Pose];
        actualStates = [actualStates iiwaState.Pose];
        filtered_poses = [filtered_poses ; posesq(i,:)];


%         input("Press entter to continue");
        
        index = index + 1
        good_idx = [good_idx index];
    end

    bad_idx_sectored{1,j} = bad_idx;
    good_idx_sectored{1,j}= good_idx;
    actualStates_sectored{1,j} = actualStates;
    sentStates_sectored{1,j} = sentStates;
    filtered_poses_sectored{1,j} = filtered_poses;
end
