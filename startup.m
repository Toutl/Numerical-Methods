% Start matlab workspace

% Adds every subfolder of the workspace to the path
workspace = fileparts(which(mfilename));
paths = genpath(workspace);
addpath(paths);
