function [BI] = Generate16blobcenters(R_Ring,D_Ring)
B_initial=GenerateBindingSites8(R_Ring);
B_initial_Up=B_initial;
B_initial_Up(3,:)=D_Ring;
B_initial_Down=B_initial;
B_initial_Down(3,:)=-D_Ring;
BI=[B_initial_Up,B_initial_Down];
end