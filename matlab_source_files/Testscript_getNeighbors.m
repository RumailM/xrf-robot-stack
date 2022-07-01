%% run other script first
tindex = 3;
neigh = getNeighbors(t,tindex);
%%
quiver3(c(tindex,1),c(tindex,2),c(tindex,3),N(tindex,1),N(tindex,2),N(tindex,3),"LineWidth",10)
%%
quiver3(c(neigh,1),c(neigh,2),c(neigh,3),N(neigh,1),N(neigh,2),N(neigh,3),"LineWidth",5)

