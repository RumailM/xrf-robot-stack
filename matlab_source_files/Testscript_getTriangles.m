[V F N name] = stlReadAscii("egg.stl");
% [V F N name] = stlReadAscii("FE_3.stl");

%%
hold on
% plot3(1,1,1)
h = patch("Faces",F,"Vertices",V);
set(h,"FaceColor",[0.30,0.75,0.93],"EdgeColor",[0.94,0.94,0.94])
view(3)
axis('equal')
%% 
[t,c] = getTriangles(F,V)
%%
offsets = c + 5*N;
%%

invertedNormals = -1*N;

%%

quiver3(offsets(:,1),offsets(:,2),offsets(:,3),invertedNormals(:,1),invertedNormals(:,2),invertedNormals(:,3))
%%
% rpy = zeros(size(N,1),3);
% %%
% for i=1:size(N,1)
%     rpy(i,2) = asind(N(i,3)/sqrt((N(i,1)^2)+(N(i,2)^2)+(N(i,3)^2)));
%     rpy(i,3) = atan2d(N(i,2),N(i,1));
% end
% 
% %%
% 
% poses = [offsets rpy];
% 
% %%
% 
% q = quaternion([rpy(:,1) rpy(:,2) rpy(:,3)],"eulerd","ZYX","frame");
% 
% %%
% poseplot
% xlabel("North-x (m)")
% ylabel("East-y (m)")
% zlabel("Down-z (m)");
% h = patch("Faces",F,"Vertices",V);
% set(h,"FaceColor",[0.30,0.75,0.93],"EdgeColor",[0.94,0.94,0.94])
% for i=1:150:size(N,1)
%     hold on
%     poseplot(q(i),offsets(i,:))
% 
% end

