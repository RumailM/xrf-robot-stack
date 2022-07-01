%P = [0,x,y,z];
P = [0,0,0,1]; %vector points in the positive z direction
q = quaternion(rotx(180),'rotmat','frame'); % create a quaternion that rotates about the x axis by 180
% res = q
% compact(q)*P'*quatinv(compact(q))
Pq = quaternion(P)
resq = q*Pq*conj(q)
pres = compact(resq);
pres = pres(2:end)