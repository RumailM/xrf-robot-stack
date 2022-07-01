function [outPose] = computeOffset(pose,offset)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
outPose(1:3) = pose(1:3) - offset*pose(8:10);
outPose(4:10) = pose(4:10);
end