%% Load poses
% posesq = load("poses_P_xyzO_wxyz.csv");
% max(posesq)
% min(posesq)
% load("poses_P_xyzO_wxyz.mat");
%%
% temp = []
% for i=1:3212
%     if mod(i,10) == 0
%         temp = [temp ; posesq(i,:)];
%     end
% end
% 
% posesq= temp;
%%
% source ~/iiwa_stack_ws/devel/setup.bash; roslaunch iiwa_gazebo iiwa_gazebo_with_sunrise.launch
% roslaunch iiwa_gazebo iiwa_gazebo_with_sunrise.launch
%
%%

%% In order to close the Matlab - ROS connection
rosshutdown
%% Connext to external (already running roscore)
% rosinit("http://127.0.0.1:11311")
rosinit("http://rum:11311/")
%rosinit

%% Preparing a ROS /rosout subscriber
global rosout_data;
global iiwaState; 
rout =  rossubscriber("/rosout",@rosoutCallback,"DataFormat","struct");
iiwaStateSub = rossubscriber("/iiwa/state/CartesianPose",@iiwaCartesianStateCallback,"DataFormat","struct");

%% Preparing the ROS Carterian Pose Command Publisher

% rostopic pub /iiwa/command/CartesianPose geometry_msgs/PoseStamped ['{header: {stamp: now, frame_id: base_link}, pose: {position: {x: 1.0, y: 2.0, z: 3.0}, 'orientation: {x: 1.0, y: 2.0, z: 3.0, w: 4.0}}}'] -1

cartesian_command_topic = "/iiwa/command/CartesianPose";
cartesian_command_msg_type = "geometry_msgs/PoseStamped"

cartesian_command_publisher = rospublisher(cartesian_command_topic,...
    cartesian_command_msg_type,"DataFormat","struct");
%% Prepare Cartesian Pose Message

prev_time = -1;
bad_idx_cell = {};

m = rosmessage(cartesian_command_publisher)

actualStates = [];
sentStates = [];
tried_idx = [];
good_idx = [];
index = 1;

    posesq = l;
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

%         if  index <180
%           
%             disp("skipping")
%             index
%             index = index + 1;
%             continue
%         end
% % % % % %

% % % % skip low poses

%         if m.Pose.Position.Z<0.4
% %             disp(m.Pose.Position.Z);
% %             disp("less")
%             index = index +1 
%             continue
%         end

% % % % % % %


        time_ros = rostime("now");
        m.Header.Stamp.Sec = uint32(time_ros.Sec); m.Header.Stamp.Nsec = uint32(time_ros.Nsec); m.Header.FrameId = 'iiwa_link_0'; 
    
        m.Pose.Position.X = posesq(i,1); 
        m.Pose.Position.Y = posesq(i,2);
        m.Pose.Position.Z = posesq(i,3);
        m.Pose.Orientation.W = posesq(i,4);
        m.Pose.Orientation.X = posesq(i,5);
        m.Pose.Orientation.Y = posesq(i,6);
        m.Pose.Orientation.Z = posesq(i,7);


        send(cartesian_command_publisher,m)
    
%         pause(2);
                input("Press entter to continue");

        sentStates = [sentStates m.Pose];
%         actualStates = [actualStates iiwaState.PoseStamped.Pose];
        actualStates = [actualStates iiwaState.Pose];


        if prev_time ~= rosout_data.Header.Stamp.Sec 
            disp(rosout_data.Msg)
            disp(rosout_data.Header.Stamp)
            prev_time = rosout_data.Header.Stamp.Sec;
            bad_idx = [bad_idx i];
        end
        index = index + 1
        good_idx = [good_idx index];
    end


