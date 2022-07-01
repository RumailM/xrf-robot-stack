%% Import the stl
[V F N name] = stlRead("Trash_can_v4.stl"); % 15 seconds


%% Plot to inspect
% tp = theaterPlot();
% op = orientationPlotter(tp);
% hold on
% xlabel("North-x (m)")
% ylabel("East-y (m)")
% zlabel("Down-z (m)");
% h = patch("Faces",F,"Vertices",V);
% set(h,"FaceColor",[0.30,0.75,0.93],"EdgeColor",[0.94,0.94,0.94])
% hold off

%% In this example, the STL has the Y-axis swapped with the X axis, let's swap this and plot again
temp = V(:,2);
V(:,2) = V(:,3);
V(:,3)=-temp; % also flipping z axis
%% Plot Again
% 
% tp = theaterPlot();
% op = orientationPlotter(tp);
% hold on
% xlabel("North-x (m)")
% ylabel("East-y (m)")
% zlabel("Down-z (m)");
% h = patch("Faces",F,"Vertices",V);
% set(h,"FaceColor",[0.30,0.75,0.93],"EdgeColor",[0.94,0.94,0.94])
% hold off
%% Inspect the bounds of the vericies for centering
vals = [min(V);
    max(V)]
%% Translate vertices to center
ranges = vals(2,:)-vals(1,:)
V(:,1) = V(:,1)- vals(1,1) - (ranges(1))/2; %center x about 0
V(:,2) = V(:,2)- vals(1,2) - (ranges(2))/2; %center y about 0
V(:,3) = V(:,3)- vals(1,3) ; %translate z to strictly positive coordinates
vals = [min(V);
    max(V)]
%% Plot Again

tp = theaterPlot();
op = orientationPlotter(tp);
hold on
xlabel("North-x (m)")
ylabel("East-y (m)")
zlabel("Down-z (m)");
h = patch("Faces",F,"Vertices",V);
set(h,"FaceColor",[0.30,0.75,0.93],"EdgeColor",[0.94,0.94,0.94])
hold off

%% Save the corrected Orientation
stlWrite("./trash_can.stl",F,V)
