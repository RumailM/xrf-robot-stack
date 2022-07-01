function [m] = fillCommandMsg(m,vec)
%fillCommandMsg Summary of this function goes here
%   Detailed explanation goes here
time_ros = rostime("now");
m.Header.Stamp.Sec = uint32(time_ros.Sec); m.Header.Stamp.Nsec = uint32(time_ros.Nsec); m.Header.FrameId = 'iiwa_link_0'; 
m.Pose.Position.X = vec(1); m.Pose.Position.Y = vec(2);
m.Pose.Position.Z = vec(3); m.Pose.Orientation.W = vec(4);
m.Pose.Orientation.X = vec(5);m.Pose.Orientation.Y = vec(6);
m.Pose.Orientation.Z = vec(7);
end