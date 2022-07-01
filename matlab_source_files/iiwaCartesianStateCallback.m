function [] = iiwaCartesianStateCallback(src,message)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global iiwaState;
iiwaState = message;

end