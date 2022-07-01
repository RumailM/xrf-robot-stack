function [] = collisionFlagCallback(src,message)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global collisionFlag;
collisionFlag = message;

end