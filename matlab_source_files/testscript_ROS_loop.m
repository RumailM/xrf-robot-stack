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
%% Prepare Cartesian Pose Message
Xp = [0.123946893805 0.0141916668092 0.369669472435 0.484190124626 0.603172981889 0.606448652261 0.608047718504 0.614025314837 0.621317922637 0.641683690733 ];
Yp = [0.398684531363 -0.0529417908666 0.0614990277267 0.103883819942 0.146774190511 0.132835755833 0.126127232478 0.121298759547 0.115447559826 0.117694199958];
Zp = [1.09306936226 1.31713845597 1.22186559632 1.03952899004 0.833159863369 0.626213875115 0.524953162773 0.42182585589 0.290950344828 0.191759884641];
Xo = [-0.111055794243 -0.0928578402289 -0.0729040444844 -0.137131258541 -0.183235653162 -0.183163929435 -0.179996546981 -0.179970193463 -0.168324483329 -0.168177136701];
Yo = [0.666493837806 0.012393037272 0.16961565182 0.463286841403 0.688501698238 0.688380137194 0.672009988549 0.672107605588 0.613713707782 0.613762071793];
Zo = [-0.0146433410133 0.062383416058 0.215542661055 0.181539412261 0.1349487897 0.134870180054 0.13902708238 0.13898632968 0.153191623361 0.152910533077];
Wo = [0.737046897411 0.993645906448 0.958883166313 0.856506705284 0.688606500626 0.688762485981 0.704751908779 0.704673588276 0.756012380123 0.756062805653];

%%

m = rosmessage(cartesian_command_publisher)
for i=1:numel(Wo)
    time_ros = rostime("now");
    m.Header.Stamp.Sec = uint32(time_ros.Sec); m.Header.Stamp.Nsec = uint32(time_ros.Nsec); m.Header.FrameId = 'iiwa_link_0'; 
    m.Pose.Position.X = Xp(i); 
    m.Pose.Position.Y = Yp(i);
    m.Pose.Position.Z = Zp(i);
    m.Pose.Orientation.W = Wo(i);
    m.Pose.Orientation.X = Xo(i);
    m.Pose.Orientation.Y = Yo(i);
    m.Pose.Orientation.Z = Zo(i);
    send(cartesian_command_publisher,m)

    pause(1);
%     input("Press entter to continue");
end



send(cartesian_command_publisher,m)
pause(1);

%%
tf = strcmp(rosout_data.Msg, 'invalid pose command')
disp(rosout_data.Msg)
