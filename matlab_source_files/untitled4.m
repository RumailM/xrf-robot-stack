% load("matlab_saved_states.mat")
%%
idx_w = [];
for i=1:size(actualStates,2)
    disp(num2str(actualStates(i).Orientation.W,"%.1f") + " " +num2str(sentStates(i).Orientation.W,"%.1f"))
    if strcmp(num2str(actualStates(i).Orientation.W,"%.1f")...
            ,num2str(sentStates(i).Orientation.W,"%.1f"))
        idx_w = [idx_w i]
        
    end
end
%% 
idx_x = [];
for i=1:size(actualStates,2)
    disp(num2str(actualStates(i).Position.X,"%.1f") + " " +num2str(sentStates(i).Position.X,"%.1f"))
    if strcmp(num2str(actualStates(i).Position.X,"%.1f")...
            ,num2str(sentStates(i).Position.X,"%.1f"))
        idx_x = [idx_x i]
    end
end
%%
idx_y = [];
for i=1:size(actualStates,2)
    if strcmp(num2str(actualStates(i).Position.Y,"%.1f")...
            ,num2str(sentStates(i).Position.Y,"%.1f"))
        idx_y = [idx_y i]
    end
end
%%
idx_z = [];
for i=1:size(actualStates,2)
    if strcmp(num2str(actualStates(i).Position.Z,"%.3f")...
            ,num2str(sentStates(i).Position.Z,"%.3f"))
        idx_z = [idx_z i];
    end
end
%%
idx_c = intersect(idx_y,idx_x)

%%

posesq_m = []
for i=1:size(posesq_sectored,2)
    posesq_m = [posesq_m ;posesq_sectored{1,i}];
end
%%
l = posesq_m(good_idx(idx_c),:)

%%
% aS = [];
% sS = [];
% count = 0;
% idx= [];
% for i=1:size(actualStates,2)
%     aC = actualStates(i).Posetion.X
%     aS = [aS actualStates(i).Position.X];
%     sS = [sS sentStates(i).Position.X];
%     if strcmp(num2str(actualStates(i).Position.X,"%.4f")...
%             ,num2str(sentStates(i).Position.X,"%.4f"))
%         count = count + 1
%         idx = [idx i];
%     end
% end


% 
