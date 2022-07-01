function [] = rosoutCallback(src,message)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global rosout_data;
rosout_data = message;

end