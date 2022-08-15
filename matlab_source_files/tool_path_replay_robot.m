% function [f_poses_sectored] = tool_path_replay(poses_mat)
poses_mat = "filtered4.mat"
%% User Editable Option Parameters
% Should the toolpath only have endpoints along the scanning points, or
% should it try to backoff before and after each scanning point
% this may reduce collisions!

%% converssions

poses_mat = string(poses_mat);

%%
% source ~/iiwa_stack_ws/devel/setup.bash; roslaunch iiwa_gazebo iiwa_gazebo_with_sunrise.launch
rosshutdown
%% Connext to external (already running roscore)
rosinit("http://127.0.0.1:11311")
% figure


% rosinit("http://127.0.0.1:11311","NodeHost","http://127.0.0.1:10000")
% rosinit("http://172.17.0.2:11311/")
% rosinit("http://192.168.1.147:11311")
% rosinit("http://rum:11311/")
%rosinit

%% Preparing a ROS /rosout subscriber
global rosout_data;
global iiwaState; 
global collisionFlag;
global collisionState;
rout =  rossubscriber("/rosout",@rosoutCallback,"DataFormat","struct");
% iiwaStateSub = rossubscriber("/iiwa/state/CartesianPose",@iiwaCartesianStateCallback,"DataFormat","struct");
% collisionFlagSub = rossubscriber("/collisionFlag",@collisionFlagCallback,"DataFormat","struct");
% collisionStateSub = rossubscriber("/collisionTopicWorkpeice",@collisionStateCallback,"DataFormat","struct");
%% Load poses
load(poses_mat);

%% Preparing the ROS Carterian Pose Command Publisher

% rostopic pub /iiwa/command/CartesianPose geometry_msgs/PoseStamped ['{header: {stamp: now, frame_id: base_link}, pose: {position: {x: 1.0, y: 2.0, z: 3.0}, 'orientation: {x: 1.0, y: 2.0, z: 3.0, w: 4.0}}}'] -1

cartesian_command_topic = "/iiwa/command/CartesianPose";
cartesian_command_msg_type = "geometry_msgs/PoseStamped";

cartesian_command_publisher = rospublisher(cartesian_command_topic,...
    cartesian_command_msg_type,"DataFormat","struct");

resetCollisionFlag_publisher = rospublisher("/resetCollisionFlag","std_msgs/Bool","DataFormat","struct");
poses_mat
ro = rospublisher("/rosout","rosgraph_msgs/Log","DataFormat","struct");
a = rosmessage(ro);

%% Prepare Cartesian Pose Message

prev_time = -1;

bad_idx_sectored = {};
good_idx_sectored = {};
actualStates_sectored = {};
sentStates_sectored = {};
invalid_cmd = [];

m = rosmessage(cartesian_command_publisher);

home_pose = [0.0 0.0 0.8059999 0.707 0.0 0.707 0.0];
% filtered_poses_sectored{1}(1,:) = [0.0 0.0 0.8059999 0.707 0.0 0.707 0.0 0 0 0];
% filtered_poses_sectored{1}
% home_pose = computeOffset(filtered_poses_sectored{1,1}(50,:),0.1);


m = fillCommandMsg(m,home_pose);
send(cartesian_command_publisher,m)

a = rosmessage(resetCollisionFlag_publisher);
a.Data = true; 

pause(4)
%%

index = 1
for j = 1:size(filtered_poses_sectored,2)
    good_idx = [];
    bad_idx = [];
    actualStates = [];
    sentStates = [];
    filtered_poses = [];
    posesq = filtered_poses_sectored{1,j};
%     posesq=flip(posesq)

   

    for i=1:size(posesq,1)
        invalidPoseFlag = 0;
        disp("========================= index : "+index)
      
        % go to scanning point
        if invalidPoseFlag == 0
            disp("Going to scan point")
            m = fillCommandMsg(m,posesq(i,:));
            send(cartesian_command_publisher,m)
            pause(2.5)
        end


        % Check to see if the position sent immediately returns a warning
        % or check to see if it thinks it found a solution and it was
        % incorrect
%         if checkPoseCommandValidity(prev_time, rosout_data,iiwaState,m) == false
%             prev_time = rosout_data.Header.Stamp.Sec;
%             invalidPoseFlag = 1;
%         end



        % Check to see if the sent position caused a collision or if it was
        % invalid (warning) or if false solution (check offset too)
%         if (collisionFlag.Data == true || invalidPoseFlag == 1)
%             if collisionFlag.Data == true
%                 disp("Invalid Pose, Collision")
%             end
%             
%             
% %             disp(num2str(iiwaState.Pose.Position.X,"%.1f") + " " +num2str(m.Pose.Position.X,"%.1f") )
%             disp(num2str(m.Pose.Position.X,"%.1f") + " " + num2str(m.Pose.Position.Y,"%.1f") + " " + num2str(m.Pose.Position.Z,"%.1f") + " " ...
% + num2str(m.Pose.Orientation.X,"%.1f") + " " + num2str(m.Pose.Orientation.Y,"%.1f") + " " + num2str(m.Pose.Orientation.Z,"%.1f") + " " + num2str(m.Pose.Orientation.W,"%.1f"))
%              disp(num2str(iiwaState.Pose.Position.X,"%.1f") + " " + num2str(iiwaState.Pose.Position.Y,"%.1f") + " " + num2str(iiwaState.Pose.Position.Z,"%.1f") + " " ...
% + num2str(iiwaState.Pose.Orientation.X,"%.1f") + " " + num2str(iiwaState.Pose.Orientation.Y,"%.1f") + " " + num2str(iiwaState.Pose.Orientation.Z,"%.1f") + " " + num2str(iiwaState.Pose.Orientation.W,"%.1f"))
%            
% 
%             send(resetCollisionFlag_publisher,a);
% 
%             invalidPoseFlag = 0;
%             bad_idx = [bad_idx i];
%             index = index +1;
% %             continue 
%         end
        
        pause(0.5);       
        sentStates = [sentStates m.Pose];
%         actualStates = [actualStates iiwaState.PoseStamped.Pose];
%         actualStates = [actualStates iiwaState.Pose];


        index = index + 1;
        good_idx = [good_idx index];
    end

    bad_idx_sectored{1,j} = bad_idx;
    good_idx_sectored{1,j}= good_idx;
    actualStates_sectored{1,j} = actualStates;
    sentStates_sectored{1,j} = sentStates;
end
save("replay_session_variables.mat");
clearFlag = 1;

for i=1:size(bad_idx_sectored,2)
    if ~isempty(bad_idx_sectored{1,i})
        clearFlag =0
        break
    end
end

if clearFlag == 1
    disp('!!! Success !!! Toolpath caused no collisions')
else
    disp('!!! Failure !!! Toolpath caused collisions, check "replay_session_variables.mat" output file to see where')
end

% end

