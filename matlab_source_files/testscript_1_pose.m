%% In order to close the Matlab - ROS connection
% rosshutdown
%% Connext to external (already running roscore)
rosinit("http://localhost:11311")
% source ~/iiwa_stack_ws/devel/setup.bash; roslaunch iiwa_gazebo iiwa_gazebo_with_sunrise.launch

% rosinit

%% Preparing a ROS /rosout subscriber
global rosout_data;
rout =  rossubscriber("/rosout",@rosoutCallback,"DataFormat","struct");

%% Preparing the ROS Carterian Pose Command Publisher

% rostopic pub /iiwa/command/CartesianPose geometry_msgs/PoseStamped ['{header: {stamp: now, frame_id: base_link}, pose: {position: {x: 1.0, y: 2.0, z: 3.0}, 'orientation: {x: 1.0, y: 2.0, z: 3.0, w: 4.0}}}'] -1

cartesian_command_topic = "/iiwa/command/CartesianPose";
cartesian_command_msg_type = "geometry_msgs/PoseStamped"

cartesian_command_publisher = rospublisher(cartesian_command_topic,...
    cartesian_command_msg_type,"DataFormat","struct");

%%

m = rosmessage(cartesian_command_publisher)

time_ros = rostime("now");
m.Header.Stamp.Sec = uint32(time_ros.Sec); m.Header.Stamp.Nsec = uint32(time_ros.Nsec); m.Header.FrameId = 'iiwa_link_0'; 
% m.Pose.Position.X = 0.0000000; 
% m.Pose.Position.Y = 0.0000000;
% m.Pose.Position.Z = 1.3059999;
% m.Pose.Position.X = 0.000000; 
% m.Pose.Position.Y = 0.3000000;
% m.Pose.Position.Z = 0.959999;
m.Pose.Position.X = 0.400000; 
m.Pose.Position.Y = 0.0000000;
m.Pose.Position.Z = 1.859999;

% % % %  z direction 1
% W=0.707;X=0.0;Y=0.0;Z=0.707;

% % % % z direction 2
% W=1.0;X=0.0;Y=0.0;Z=0.0;

% % % % negative x direciton ??? not really 
% W=0.707;X=0.0;Y=-0.707;Z=0.0;

% % % %  x direciton positive
W=0.707; X=0.0; Y=0.707; Z=0.0;


% % % rotate x axis
% m.Pose.Orientation.W = 0.924;
% m.Pose.Orientation.X = 0.383;
% m.Pose.Orientation.Y = 0;
% m.Pose.Orientation.Z = 0.0;  
% % % rotate y axis 45
% m.Pose.Orientation.W = 0.924;
% m.Pose.Orientation.X = 0.0;
% m.Pose.Orientation.Y = 0.383;
% m.Pose.Orientation.Z = 0.0;  
% % % rotate z axis 45
% m.Pose.Orientation.W = 0.924;
% m.Pose.Orientation.X = 0.0;
% m.Pose.Orientation.Y = 0.0;
% m.Pose.Orientation.Z = 0.383;    

m.Pose.Orientation.W = W;
m.Pose.Orientation.X = X;
m.Pose.Orientation.Y = Y;
m.Pose.Orientation.Z = Z;

send(cartesian_command_publisher,m)

%% poseplot(quaternion([W,X,Y,Z]))

%% poseplot(quaternion([W,X,Y,Z])*rotq)
%% rotq = quaternion(rotz(45),'rotmat','frame')
%% rotq = quaternion(quaternion([W,X,Y,Z])*rotq,'rotmat','frame')

% quaternion([W,X,Y,Z])*rotq



