poses = getPose(offsets,invertedNormals);
%%
rpy= poses(:,4:6);

% writematrix(poses,'pose.csv') 
%%
q = quaternion([rpy(:,1) rpy(:,2) rpy(:,3)],"eulerd","XYZ","frame");
%%
tp = theaterPlot();
op = orientationPlotter(tp);
hold on
xlabel("North-x (m)")
ylabel("East-y (m)")
zlabel("Down-z (m)");
h = patch("Faces",F,"Vertices",V);
set(h,"FaceColor",[0.30,0.75,0.93],"EdgeColor",[0.94,0.94,0.94])
quiver3(offsets(:,1),offsets(:,2),offsets(:,3),invertedNormals(:,1),invertedNormals(:,2),invertedNormals(:,3))
for i=1:50000:size(invertedNormals,1)
    
    poseplot(q(i),offsets(i,:))

end


%%
% 
% tp = theaterPlot();
%     op = orientationPlotter(tp);
% 
% 
% for i=1:100:3200
% %     pause(1)
% %     close all
%     
%     
%     hold on
%     
%     quiver3(0,0,0,invertedNormals(i,1),invertedNormals(i,2),invertedNormals(i,3))
%     
%     q = quaternion([rpy(i,1),rpy(i,2),rpy(i,3)],"eulerd","XYZ","frame");
%     
%     poseplot(q,[0,0,-i])
%     
%     hold off
%     input("press enter")
% end

%%

