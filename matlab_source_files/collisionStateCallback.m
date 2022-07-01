function [] = collisionStateCallback(src,message)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global collisionState;
collisionState = message;

end