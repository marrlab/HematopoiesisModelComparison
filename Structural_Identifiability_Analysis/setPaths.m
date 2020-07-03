function [opt] = setPaths()
opt.c_path = cd;
cd('../../../../');
path1=cd;
addpath(genpath(fullfile(path1,'Tools')));
addpath(genpath(fullfile(path1,'Tools','AMICI-master')));
opt.a_path = fullfile(path1,'Tools','AMICI-master','matlab','examples');
opt.structIdent_path = fullfile(path1,'Tools','STRIKEGOLDD','STRIKE-GOLDD','models');
opt.pythonDataVisualization_path = fullfile(opt.c_path);
cd(opt.c_path);
end