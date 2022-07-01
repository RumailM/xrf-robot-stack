% disp(rosout_data.Msg)
for i=1:size(bad_idx_sectored,2)
    for j=size(bad_idx_sectored{i},2):-1:1
        posesq_sectored{i}(bad_idx_sectored{i}(j),:) = [];
    end
end
%%
save("poses_collision_filtered.mat","posesq_sectored")

% temp2 = removerows(posesq,'ind',bad_idx)