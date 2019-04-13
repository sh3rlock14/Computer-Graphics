function h = myScatter(c,s)
%MYSCATTER Summary of this function goes here
%   Detailed explanation goes here
    h = scatter3(c(:,1),c(:,2),c(:,3),s*1e-2,c./255,'fill');
end

